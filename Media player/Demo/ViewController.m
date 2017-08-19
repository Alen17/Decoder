//
//  ViewController.m
//  Demo
//
//  Created by hu on 14-7-21.
//  Copyright (c) 2014年 jxj. All rights reserved.
//

#import "ViewController.h"

#import "avcodec.h"
#import "swscale.h"
//#import "avformat.h"
//#import "file.h"
#include <stdio.h>
#import "FileFrame.h"

#include <pthread.h>


#define MAX_FRAME_SIZE (1024)

@interface ViewController ()<FrameDelegate>

@property (nonatomic, strong) FileFrame *fileFrame;

@end

typedef enum {
    DT_None = -1,
    DT_ImageRGB = 0
}EM_DELEGATE_TYPE;

typedef enum {
    JDE_OK = 0,
    JDE_PARAM,
    JDE_MEMORY,
    JDE_NOCODEC,
    JDE_CONTEXT,
    JDE_OPENCODEC,
    JDE_PICTURE,
    JDE_DATADECODE
}JXJDecode_Eror;

typedef struct {
    int type;
    int width;
    int height;
}JXJDECODE_FORMAT;

#ifdef ALLOCMEM_TEST
#define YUVBUFFER_MAX 1024 * 1024 *10
#endif

typedef struct {
    AVCodec *codec;
    AVCodecContext *context;
    int frameCount;
    AVFrame *frame;
    struct SwsContext *img_convert_ctx;
#ifndef ALLOCMEM_TEST
    AVPicture *rgbPicture;
    BOOL bFree;
#endif
    AVPacket avpkt;
    int comsumedSize;
    int got_picture;
    JXJDECODE_FORMAT format;
}JXJDecode_Info;


@implementation ViewController{
    JXJDecode_Info *decodeInfo;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _fileFrame = [FileFrame new];
    _fileFrame.delegate = self;
    [_fileFrame initOBJ:_fileFrame];
    
    if (!_imageViewShow) {
        _imageViewShow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 320, 200)];
        _imageViewShow.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_imageViewShow];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    sleep(2.0f);
    [self playFile:nil];
}

- (void)playFile:(id)sender
{
//    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
//    NSString *filePath = [bundlePath stringByAppendingPathComponent:@"720p_15.264"];
    /*
    // [1]注册所支持的所有的文件（容器）格式及其对应的CODEC av_register_all()
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        av_register_all();
    });
    //  [2]打开文件 avformat_open_input()
    //AVFormatContext * pFormatContext = avformat_alloc_context();
    if (avformat_open_input(&pFormatContext, [fileName cStringUsingEncoding:NSASCIIStringEncoding], NULL, NULL) != 0)//[1]函数调用成功之后处理过的AVFormatContext结构体;[2]打开的视音频流的URL;[3]强制指定AVFormatContext中AVInputFormat的。这个参数一般情况下可以设置为NULL，这样FFmpeg可以自动检测AVInputFormat;[4]附加的一些选项，一般情况下可以设置为NULL。)
    {
        NSLog(@"无法打开文件");
        return;
    }
     */
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *filePath = [bundlePath stringByAppendingPathComponent:@"stream_chn0.h264"];
    
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
        self.bOpen = YES;
        [self openDecode];
    }
    
    long lTemp=0;
    
    uint8_t*  NalBuf = malloc(MAX_FRAME_SIZE);
    int rdSize = 0;
    int type = 0;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        file_read([filePath UTF8String], fd, (char*)NalBuf, MAX_FRAME_SIZE, &type);
    });
    

    //lTemp = [self jxjInputData:NalBuf withSize:rdSize frameType:type];
//
//    sleep(0.01f);
//
//    
//    file_close(fd);
//    free(NalBuf);
//
//    //释放对象
//    [self closeDecode];
//    
//    self.bOpen = NO;
    
}

- (void)callBackFrame:(unsigned char *)buf Len:(int)len{

    [self jxjInputData:buf withSize:len frameType:0];
    
}


- (BOOL)openDecode
{
    _lastError = JDE_OK;
    
    decodeInfo = malloc(sizeof(JXJDecode_Info));
    
#ifdef ALLOCMEM_TEST
    yuvBuffer = malloc(YUVBUFFER_MAX);
    if (decodeInfo == nil || yuvBuffer == nil) {
        _lastError = JDE_MEMORY;
        return NO;
    }
#endif
    
    memset(decodeInfo, 0, sizeof(JXJDecode_Info));
    
    do {
        avcodec_register_all();
        av_init_packet(&decodeInfo->avpkt);
        decodeInfo->codec = avcodec_find_decoder(AV_CODEC_ID_H264);
        if (decodeInfo->codec == nil) {
            _lastError = JDE_NOCODEC;
            break;
        }
        
        decodeInfo->context = avcodec_alloc_context3(decodeInfo->codec);
        if (decodeInfo->context == nil) {
            _lastError = JDE_CONTEXT;
            break;
        }
        
        if (decodeInfo->codec->capabilities & CODEC_CAP_TRUNCATED) {
            decodeInfo->context->flags |= CODEC_FLAG_TRUNCATED;
        }
        
        if (avcodec_open2(decodeInfo->context, decodeInfo->codec, nil) != 0) {
             NSLog(@"open codec failed");
            _lastError = JDE_OPENCODEC;
            break;
        }
        
        decodeInfo->frame = av_frame_alloc();
        if (decodeInfo->frame == nil) {
            _lastError = JDE_MEMORY;
            break;
        }
        decodeInfo->frameCount = 0;
        
        return YES;
    } while (0);
    
    [self closeDecode];
    
    return NO;
}

- (void)closeDecode
{
    if (decodeInfo) {
        avcodec_close(decodeInfo->context);
        free(decodeInfo->frame);
#ifndef ALLOCMEM_TEST
        if (decodeInfo->rgbPicture) {
            if (decodeInfo->bFree) {
                avpicture_free(decodeInfo->rgbPicture);
                decodeInfo->bFree = NO;
            }
            free(decodeInfo->rgbPicture);
            decodeInfo->rgbPicture = nil;
        }
        
#endif
        free(decodeInfo);
        decodeInfo = nil;
    }
    
#ifdef ALLOCMEM_TEST
    if (yuvBuffer) {
        free(yuvBuffer);
        yuvBuffer = nil;
    }
#endif
}


- (BOOL)jxjInputData:(unsigned char *)data withSize:(int)size frameType:(int)type
{    
    if (decodeInfo == nil) {
        _lastError = JDE_PARAM;
        return NO;
    }
    
    BOOL bChangeFmt = NO;
    decodeInfo->avpkt.data = data;
    decodeInfo->avpkt.size = size;
    while (decodeInfo->avpkt.size > 0) {
        decodeInfo->comsumedSize = avcodec_decode_video2(decodeInfo->context, decodeInfo->frame, &decodeInfo->got_picture, &decodeInfo->avpkt);
        if (decodeInfo->comsumedSize < 0) {
            _lastError = JDE_DATADECODE;
            return NO;
        }
        NSLog(@"decodeInfo->got_picture = %d",decodeInfo->got_picture);
        if (decodeInfo->got_picture) {
            
            decodeInfo->format.type = type;
            bChangeFmt = decodeInfo->format.width != decodeInfo->frame->width || decodeInfo->format.height != decodeInfo->frame->height;
            decodeInfo->format.width = decodeInfo->frame->width;
            decodeInfo->format.height = decodeInfo->frame->height;
            
#ifndef ALLOCMEM_TEST

//            AVFrame *pDstFrame=(AVFrame *)decodeInfo->frame;
//            struct SwsContext *img_convert_ctx=(struct SwsContext *)decodeInfo->context;
//            struct SwsContext * imgSwsCtx = decodeInfo->img_convert_ctx;
//            
//            if (imgSwsCtx==NULL)
//            {
//                unsigned int m_frameDataSize = 0;
//                m_frameDataSize=avpicture_get_size(AV_PIX_FMT_RGB24, decodeInfo->format.width, decodeInfo->format.height);
//                unsigned char *m_outBuffer=(unsigned char *)malloc(m_frameDataSize + sizeof(decodeInfo));
//                if(m_outBuffer == NULL)
//                {
//                    return -1;
//                }
//                avpicture_fill((AVPicture *)pDstFrame,m_outBuffer+sizeof(decodeInfo) , AV_PIX_FMT_RGB24, decodeInfo->format.width, decodeInfo->format.height);
//                imgSwsCtx= sws_getContext(decodeInfo->format.width, decodeInfo->format.height, AV_PIX_FMT_YUV420P, decodeInfo->format.width, decodeInfo->format.height, AV_PIX_FMT_RGB24, SWS_FAST_BILINEAR, NULL, NULL, NULL);
//                decodeInfo->img_convert_ctx=imgSwsCtx;
//            }
            
            struct SwsContext *imgSwsCtx = sws_getContext(decodeInfo->context->width, decodeInfo->context->height, AV_PIX_FMT_YUV420P, decodeInfo->frame->width, decodeInfo->frame->height, AV_PIX_FMT_RGB24, SWS_BICUBIC, NULL, NULL, NULL);
            
            if (imgSwsCtx != NULL) {
                if (decodeInfo->rgbPicture == nil) {
                    decodeInfo->rgbPicture = malloc(sizeof(AVPicture));
                }
                if (bChangeFmt || !decodeInfo->bFree) {
                    if (decodeInfo->bFree) {
                        avpicture_free(decodeInfo->rgbPicture);
                        decodeInfo->bFree = NO;
                    }
                    if (avpicture_alloc(decodeInfo->rgbPicture, AV_PIX_FMT_RGB24, decodeInfo->frame->width, decodeInfo->frame->width) < 0) {
                        sws_freeContext(imgSwsCtx);
                        _lastError = JDE_MEMORY;
                        return NO;
                    }
                    decodeInfo->bFree = YES;
                }
                if (decodeInfo->rgbPicture) {
                    /*图像颠倒*/
                    /*decodeInfo->frame->data[0] = decodeInfo->frame->data[0]+decodeInfo->frame->linesize[0]*(decodeInfo->context->height-1);
                     decodeInfo->frame->data[1] = decodeInfo->frame->data[1]+decodeInfo->frame->linesize[1]*(decodeInfo->context->height/2-1);
                     decodeInfo->frame->data[2] = decodeInfo->frame->data[2]+decodeInfo->frame->linesize[2]*(decodeInfo->context->height/2-1);
                     decodeInfo->frame->linesize[0] *= -1;
                     decodeInfo->frame->linesize[1] *= -1;
                     decodeInfo->frame->linesize[2] *= -1;*/
                    sws_scale(imgSwsCtx, decodeInfo->frame->data, decodeInfo->frame->linesize, 0, decodeInfo->format.height, decodeInfo->rgbPicture->data, decodeInfo->rgbPicture->linesize);
                    
                    [self decodeYUV:decodeInfo->rgbPicture->data[0] withSize:decodeInfo->rgbPicture->linesize[0] frameFormat:&decodeInfo->format];
                }
                //sws_freeContext(imgSwsCtx);
            }
            
#else
            int iSize = 0;
            for (int i = 0; i < decodeInfo->format.height; i++) {
                memcpy(yuvBuffer + iSize, decodeInfo->frame->data[0] + decodeInfo->frame->linesize[0] * i, decodeInfo->format.width);
                iSize += decodeInfo->format.width;
            }
            
            for (int i = 0; i < decodeInfo->format.height / 2; i++) {
                memcpy(yuvBuffer + iSize, decodeInfo->frame->data[1] + decodeInfo->frame->linesize[1] * i, decodeInfo->format.width / 2);
                iSize += decodeInfo->format.width / 2;
            }
            
            for (int i = 0; i < decodeInfo->format.height / 2; i++) {
                memcpy(yuvBuffer + iSize, decodeInfo->frame->data[2] + decodeInfo->frame->linesize[2] * i, decodeInfo->format.width / 2);
                iSize += decodeInfo->format.width / 2;
            }
            
            [self.delegate decodeYUV:yuvBuffer withSize:iSize frameFormat:&decodeInfo->format];
#endif
            
            decodeInfo->frameCount++;
        }
        
        if (decodeInfo->avpkt.data) {
            decodeInfo->avpkt.size -= decodeInfo->comsumedSize;
            decodeInfo->avpkt.data += decodeInfo->comsumedSize;
        }
    }
    
    return YES;
}

#pragma mark - JXJ Decode Delegate Methods
- (void)decodeYUV:(void *)data withSize:(int)size frameFormat:(JXJDECODE_FORMAT *)format
{
#ifdef ALLOCMEM_TEST
    if (rgbBuffer == nil) {
        return;
    }
#endif
    
#ifndef ALLOCMEM_TEST
    [self eventNotify:data userParam:format eventType:DT_ImageRGB];
#else
    rgbBufferLen = JXJ_BUFFER_MAX;
    if (YUV420pToRGB(data, format->width, format->height, rgbBuffer, &rgbBufferLen) != 0) {
        NSLog(@"decodeYUV : YUV2RGB error");
        return;
    }
    
    [self eventNotify:rgbBuffer userParam:format eventType:DT_ImageRGB];
#endif
}

-(long)eventNotify:(void *)arg userParam:(void *)arg1 eventType:(long)type
{
    JXJDECODE_FORMAT* format = (JXJDECODE_FORMAT *)arg1;
    [self decodeAndShow:arg length:format->width*format->height*3 nWidth:format->width nHeight:format->height];
    
    return 0;
}

-(void)decodeAndShow:(uint8_t *)pFrameRGB length:(int)len nWidth:(int)nWidth nHeight:(int)nHeight
{
    if (len > 0) {
        
        CFDataRef dataRef = CFDataCreate(kCFAllocatorDefault, (const UInt8 *)pFrameRGB, nWidth*nHeight*3);
        CGDataProviderRef provider = CGDataProviderCreateWithCFData(dataRef);
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGImageRef cgImage = CGImageCreate(nWidth,
                                           nHeight,
                                           8,
                                           24,
                                           nWidth*3,
                                           colorSpace,
                                           kCGBitmapByteOrderDefault,
                                           provider,
                                           NULL,
                                           NO,
                                           kCGRenderingIntentDefault);
        
        CGColorSpaceRelease(colorSpace);
        UIImage *image = [UIImage imageWithCGImage:cgImage];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _imageViewShow.image = image;

        });
        
        CGImageRelease(cgImage);
        CGDataProviderRelease(provider);
        CFRelease(dataRef);
        
        
        
//        CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
//        CFDataRef data = CFDataCreateWithBytesNoCopy(kCFAllocatorDefault, pFrameRGB, nWidth*nHeight*3, kCFAllocatorNull);
//        CGDataProviderRef provider = CGDataProviderCreateWithCFData(data);
//        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//        
//        CGImageRef cgImage = CGImageCreate(nWidth, nHeight, 8, 24, nWidth*3, colorSpace, bitmapInfo, provider, NULL, YES, kCGRenderingIntentDefault);
//        UIImage* image = [[UIImage alloc]initWithCGImage:cgImage];
//        _imageViewShow.image = image;
//        NSLog(@"image size:%f,%f",image.size.width,image.size.height);
//        [self loadImageFinished:image];
//        
//        CGColorSpaceRelease(colorSpace);
//        CGImageRelease(cgImage);
//        CGDataProviderRelease(provider);
//        CFRelease(data);
        
    }
    
    return;
}

- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
