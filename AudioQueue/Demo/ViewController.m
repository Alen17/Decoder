//
//  ViewController.m
//  Demo
//
//  Created by hu on 14-7-21.
//  Copyright (c) 2014年 jxj. All rights reserved.
//

#import "ViewController.h"
#include <stdio.h>
#include <pthread.h>
#import "FCOutputAudio.h"
#import "FileFrame.h"

#define MAX_FRAME_SIZE (512 *1024)
#define MAXAUDIOBUF     9000 //9600/*245760*/

@interface ViewController ()<FrameDelegate>
{
    AudioStreamBasicDescription _audio_fmt;
}

@property (nonatomic, strong) FCOutputAudio *outputAudio;

@property (nonatomic, strong) FileFrame *fileFrame;

@end

@implementation ViewController

@synthesize m_queue_talk;

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _fileFrame = [FileFrame new];
    _fileFrame.delegate = self;
    [_fileFrame initOBJ:_fileFrame];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    sleep(2.0f);
    [self playFile:nil];
}

- (void)playFile:(id)sender{
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *filePath = [bundlePath stringByAppendingPathComponent:@"file.726"];
    
    if (filePath == nil)
    {
        NSLog(@"Couldn't open file:%@",filePath);
        return;
    }
    
    int fd;
    fd = file_open([filePath UTF8String]);
    if (fd < 0) {
        NSLog(@"ffmpeg file_open error : %d", fd);
        return ;
    }else{
        [self initAudioFmt];
    }
    
    long lTemp=0;
    
    uint8_t*  NalBuf = malloc(MAX_FRAME_SIZE);
    int rdSize = 0;
    int type = 0;
    
    file_read([filePath UTF8String], fd);
    
}

-(void)initAudioFmt{
    //----------------------音频相关----------------//
    _outputAudio = [[FCOutputAudio alloc] init];
    bzero(&_audio_fmt, sizeof(AudioStreamBasicDescription));
    _audio_fmt.mSampleRate = 8000;
    _audio_fmt.mFormatID = kAudioFormatLinearPCM;
    _audio_fmt.mFormatFlags = kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
    //_audio_fmt.mFormatFlags = kAudioFormatFlagsAudioUnitCanonical;
    _audio_fmt.mBytesPerPacket = 2;
    _audio_fmt.mBytesPerFrame = 2;
    _audio_fmt.mFramesPerPacket = 1;
    _audio_fmt.mChannelsPerFrame = 1;
    _audio_fmt.mBitsPerChannel = 16;
    
}

- (void)callBackFrame:(unsigned char *)buf Len:(int)len{
    
    if ([_outputAudio IsInit]) {
        [_outputAudio WriteData:buf : len];
    }else{
        if (![_outputAudio IsInit]) {
            assert([_outputAudio InitAudio:&_audio_fmt : MAXAUDIOBUF]);
        }
        [_outputAudio AudioStart];
    }
}

-(void)deallocAudioQueueTalk
{
    if (m_queue_talk)
    {
        AudioQueueStop(m_queue_talk, true);
        for (int i = 0; i < QUEUE_BUFFER_SIZE; i++)
        {
            //AudioQueueFreeBuffer(m_queue_talk, m_Buffers_talk[i]);
        }
        
        AudioQueueDispose(m_queue_talk, true);
        m_queue_talk = nil;
    }
}

-(void)initAudioQueueTalk
{
    m_audioDescription_talk.mSampleRate = 8000;
    m_audioDescription_talk.mFormatID = kAudioFormatLinearPCM;
    m_audioDescription_talk.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger |kLinearPCMFormatFlagIsPacked;
    m_audioDescription_talk.mFramesPerPacket = 1;
    m_audioDescription_talk.mChannelsPerFrame = 1;
    
    m_audioDescription_talk.mBitsPerChannel = 16;
    m_audioDescription_talk.mBytesPerFrame = (m_audioDescription_talk.mBitsPerChannel/8) * m_audioDescription_talk.mChannelsPerFrame;
    m_audioDescription_talk.mBytesPerPacket = m_audioDescription_talk.mBytesPerFrame;
    
    
    m_talk_framesize = 320;
    
    AudioQueueNewInput(&m_audioDescription_talk, AQInputCallback, self, NULL, kCFRunLoopCommonModes,0, &m_queue_talk);
    //     AudioQueueNewInput(&m_audioDescription, AQInputCallback, self, NULL, kCFRunLoopCommonModes,0, &m_audioQueue);
    
    for (int i=0; i < QUEUE_BUFFER_SIZE; i++)
    {
        AudioQueueAllocateBuffer(m_queue_talk, m_talk_framesize, &m_Buffers_talk[i]);
        AudioQueueEnqueueBuffer(m_queue_talk, m_Buffers_talk[i], 0, NULL);
    }
    //设置话筒模式
    UInt32 category = kAudioSessionCategory_PlayAndRecord;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
    //if (error) printf("couldn't set audio category!");
    
    
    //UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    //AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryMixWithOthers, sizeof (audioRouteOverride),&audioRouteOverride);
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, sizeof (audioRouteOverride),&audioRouteOverride);
    AudioSessionSetActive(true); //激活AudioSession
    AudioQueueStart(m_queue_talk, NULL);
}

static void AQInputCallback (void                   * inUserData,
                             AudioQueueRef          inAudioQueue,
                             AudioQueueBufferRef    inBuffer,
                             const AudioTimeStamp   * inStartTime,
                             unsigned long          inNumPackets,
                             const AudioStreamPacketDescription * inPacketDesc)
{
    ViewController *pRTV = (ViewController *)inUserData;
    
    if (inNumPackets > 0)
    {
        unsigned char* pFrame[MIN_SIZE_PER_FRAME];
        memset(pFrame, 0x0, MIN_SIZE_PER_FRAME);
        int       len = 0;
        //        [pRTV AudioEnc:inBuffer->mAudioData :inBuffer->mAudioDataByteSize :pFrame :&len];
        NSLog(@"inNumPackets is %ld %d %ld!!!",inNumPackets, len, inBuffer->mAudioDataByteSize);
        [pRTV Senddatebuff:inBuffer->mAudioData datelen:inBuffer->mAudioDataByteSize];
    }
    AudioQueueEnqueueBuffer(pRTV.m_queue_talk, inBuffer, 0, NULL); //may has error;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


////PCM
////  ViewController.m
////  Demo
////
////  Created by hu on 14-7-21.
////  Copyright (c) 2014年 jxj. All rights reserved.
////
//
//#import "ViewController.h"
//#import "FileFrame.h"
//#include <stdio.h>
//#include <pthread.h>
//#import "FCOutputAudio.h"
//
//#define MAX_FRAME_SIZE (512 *1024)
//#define MAXAUDIOBUF     245760 //9600/*245760*/
//
//@interface ViewController ()<FrameDelegate>
//{
//    AudioStreamBasicDescription _audio_fmt;
//}
//
//@property (nonatomic, strong) FCOutputAudio *outputAudio;
//
//@property (nonatomic, strong) FileFrame *fileFrame;
//
//@end
//
//@implementation ViewController
//
//@synthesize m_queue_talk;
//
//- (void)viewDidLoad{
//    [super viewDidLoad];
//    
//    _fileFrame = [FileFrame new];
//    _fileFrame.delegate = self;
//    [_fileFrame initOBJ:_fileFrame];
//    
//}
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    sleep(2.0f);
//    [self playFile:nil];
//}
//
//- (void)playFile:(id)sender{
//    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
//    NSString *filePath = [bundlePath stringByAppendingPathComponent:@"audioInp.pcm"];
//    
//    if (filePath == nil)
//    {
//        NSLog(@"Couldn't open file:%@",filePath);
//        return;
//    }
//    
//    int fd;
//    fd = file_open([filePath UTF8String]);
//    if (fd < 0) {
//        NSLog(@"ffmpeg file_open error : %d", fd);
//        return ;
//    }else{
//        [self initAudioFmt];
//    }
//    
//    long lTemp=0;
//    
//    uint8_t*  NalBuf = malloc(MAX_FRAME_SIZE);
//    int rdSize = 0;
//    int type = 0;
//    //dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        file_read([filePath UTF8String], fd, (char*)NalBuf, MAX_FRAME_SIZE, &type);
//    //});
//    
//}
//
//-(void)initAudioFmt{
//    //----------------------音频相关----------------//
//    _outputAudio = [[FCOutputAudio alloc] init];
//    bzero(&_audio_fmt, sizeof(AudioStreamBasicDescription));
//    _audio_fmt.mSampleRate = 44100;
//    _audio_fmt.mFormatID = kAudioFormatLinearPCM;
//    _audio_fmt.mFormatFlags = kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
//    //_audio_fmt.mFormatFlags = kAudioFormatFlagsAudioUnitCanonical;
//    _audio_fmt.mBytesPerPacket = 4;
//    _audio_fmt.mBytesPerFrame = 4;
//    _audio_fmt.mFramesPerPacket = 1;
//    _audio_fmt.mChannelsPerFrame = 2;
//    _audio_fmt.mBitsPerChannel = 16;
//    
//}
//
//- (void)callBackFrame:(unsigned char *)buf Len:(int)len{
//    
//    if ([_outputAudio IsInit]) {
//        [_outputAudio WriteData:buf : len];
//    }else{
//        if (![_outputAudio IsInit]) {
//            assert([_outputAudio InitAudio:&_audio_fmt : MAXAUDIOBUF]);
//        }
//        [_outputAudio AudioStart];
//    }
//}
//
//-(void)deallocAudioQueueTalk
//{
//    if (m_queue_talk)
//	{
//        AudioQueueStop(m_queue_talk, true);
//        for (int i = 0; i < QUEUE_BUFFER_SIZE; i++)
//        {
//            //AudioQueueFreeBuffer(m_queue_talk, m_Buffers_talk[i]);
//        }
//        
//		AudioQueueDispose(m_queue_talk, true);
//		m_queue_talk = nil;
//	}
//}
//
//-(void)initAudioQueueTalk
//{
//    m_audioDescription_talk.mSampleRate = 8000;
//    m_audioDescription_talk.mFormatID = kAudioFormatLinearPCM;
//    m_audioDescription_talk.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger |kLinearPCMFormatFlagIsPacked;
//    m_audioDescription_talk.mFramesPerPacket = 1;
//    m_audioDescription_talk.mChannelsPerFrame = 1;
//    
//    m_audioDescription_talk.mBitsPerChannel = 16;
//    m_audioDescription_talk.mBytesPerFrame = (m_audioDescription_talk.mBitsPerChannel/8) * m_audioDescription_talk.mChannelsPerFrame;
//    m_audioDescription_talk.mBytesPerPacket = m_audioDescription_talk.mBytesPerFrame;
//    
//    
//    m_talk_framesize = 320;
//    
//    AudioQueueNewInput(&m_audioDescription_talk, AQInputCallback, self, NULL, kCFRunLoopCommonModes,0, &m_queue_talk);
//    //     AudioQueueNewInput(&m_audioDescription, AQInputCallback, self, NULL, kCFRunLoopCommonModes,0, &m_audioQueue);
//    
//    for (int i=0; i < QUEUE_BUFFER_SIZE; i++)
//    {
//        AudioQueueAllocateBuffer(m_queue_talk, m_talk_framesize, &m_Buffers_talk[i]);
//        AudioQueueEnqueueBuffer(m_queue_talk, m_Buffers_talk[i], 0, NULL);
//    }
//    //设置话筒模式
//    UInt32 category = kAudioSessionCategory_PlayAndRecord;
//    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
//    //if (error) printf("couldn't set audio category!");
//    
//    
//    //UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
//    //AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryMixWithOthers, sizeof (audioRouteOverride),&audioRouteOverride);
//    
//    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
//    AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, sizeof (audioRouteOverride),&audioRouteOverride);
//    AudioSessionSetActive(true); //激活AudioSession
//    AudioQueueStart(m_queue_talk, NULL);
//}
//
//static void AQInputCallback (void                   * inUserData,
//                             AudioQueueRef          inAudioQueue,
//                             AudioQueueBufferRef    inBuffer,
//                             const AudioTimeStamp   * inStartTime,
//                             unsigned long          inNumPackets,
//                             const AudioStreamPacketDescription * inPacketDesc)
//{
//    ViewController *pRTV = (ViewController *)inUserData;
//    
//    if (inNumPackets > 0)
//    {
//        unsigned char* pFrame[MIN_SIZE_PER_FRAME];
//        memset(pFrame, 0x0, MIN_SIZE_PER_FRAME);
//        int       len = 0;
//        //        [pRTV AudioEnc:inBuffer->mAudioData :inBuffer->mAudioDataByteSize :pFrame :&len];
//        NSLog(@"inNumPackets is %ld %d %ld!!!",inNumPackets, len, inBuffer->mAudioDataByteSize);
//        [pRTV Senddatebuff:inBuffer->mAudioData datelen:inBuffer->mAudioDataByteSize];
//    }
//    AudioQueueEnqueueBuffer(pRTV.m_queue_talk, inBuffer, 0, NULL); //may has error;
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//@end
