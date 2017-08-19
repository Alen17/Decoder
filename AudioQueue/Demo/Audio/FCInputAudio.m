//
//  FCInputAudio.m
//  plugin_test_1
//
//  Created by foscam on 11/11/11.
//  Copyright 2011 foscam. All rights reserved.
//

#import "FCInputAudio.h"


void input_callback(void *data, AudioQueueRef aq, AudioQueueBufferRef buf, const AudioTimeStamp *time, UInt32 num, const AudioStreamPacketDescription *desc)
{
    
 //   printf("OnInput －－－＝＝\n");
    
   [(FCInputAudio *)data OnInput:buf :time];
}

@implementation FCInputAudio

#ifdef _FOR_DEBUG_  
-(BOOL) respondsToSelector:(SEL)aSelector {  
    //printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);
    return [super respondsToSelector:aSelector];  
}  
#endif

- (id)init
{
	self = [super init];
	if (self) {
		_queue = NULL;
		_audio_cb = NULL;
		_userdata = NULL;
		_index = 0;
		
		mAudioQueueStrar=false;
        mThreadRef = nil;
        mThread = nil;
	}
	
	return self;
}

- (void)dealloc
{
	//NSLog(@"FCInputAudio dealloc--- %d", [self retainCount]);
	if (_queue != NULL) {
		[self ReleaseAudio];
	}
	
	[super dealloc];
}

- (void)OnInput :(AudioQueueBufferRef)buf :(const AudioTimeStamp *)time
{
    if (!mAudioQueueStrar) {
        return;
    }
    //printf("OnInput In\n");
	if (_audio_cb) {
		_index++;
		(_audio_cb)(buf->mAudioData, _length, _index, time, _userdata);
	}
	AudioQueueEnqueueBuffer(_queue, buf, 0, NULL);
}

- (void)ThreadWork
{
    OSStatus err = noErr;
    mThreadRef = CFRunLoopGetCurrent();
	err = AudioQueueNewInput(_fmt, input_callback, self, mThreadRef, NULL, 0, &_queue);
	if (err != noErr) {
		_queue = NULL;
		return;
	}
	
	for (int i = 0; i < AUDIO_TALK_COUNT; i++) {
		AudioQueueAllocateBuffer(_queue, _length, &_buf[i]);
		AudioQueueEnqueueBuffer(_queue, _buf[i], 0, NULL);
	}
	mAudioQueueStrar=true;
	AudioQueueStart(_queue, NULL);
	_index = 0;
    
    mTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self
															selector:@selector(CheckStop)
															userInfo:nil
															 repeats:YES];
    CFRunLoopRun();
}

- (void)CheckStop
{
    if (_queue == NULL) {
        if (mThreadRef) {
            CFRunLoopStop(mThreadRef);
            mThreadRef = nil;
            
            [mTimer invalidate];
            mTimer = nil;
        }
    }
}

- (bool)InitAudio:(AudioStreamBasicDescription *)fmt :(int)pack_len :(INPUT_AUDIO_CB)audio_cb :(void *)userdata
{
	_fmt = fmt;
	_length = pack_len;
	_audio_cb = Block_copy(audio_cb);
	_userdata = userdata;
    
    if (mThreadRef) {
        CFRunLoopStop(mThreadRef);
        mThreadRef = nil;
    }
    if (mThread) {
        [mThread cancel];
        [mThread release];
        mThread = nil;
    }
    mThread = [[NSThread alloc] initWithTarget:self selector:@selector(ThreadWork) object:nil];
    [mThread start];
    usleep(1000);
	return true;
}

- (void)ReleaseAudio
{
	if (_queue != NULL) {
		if (mAudioQueueStrar) {
            mAudioQueueStrar=false;
			AudioQueueStop(_queue, true);
		}
		
		AudioQueueDispose(_queue, true);
		_queue = NULL;
	}
    /*usleep(10000);
    if (mThreadRef){
        CFRunLoopStop(mThreadRef);
        mThreadRef = nil;
    }*/

    if (mThread){
        [mThread cancel];
        [mThread release];
        mThread = nil;
    }
    if (_audio_cb) {
        Block_release(_audio_cb);
        _audio_cb = nil;
    }
}

- (bool)IsInit
{
	return (_queue != NULL);
}

@end
