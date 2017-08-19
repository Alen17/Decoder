//
//  FCOutputAudio.m
//  fsIPCam
//
//  Created by foscam on 11/11/11.
//  Copyright 2011 foscam. All rights reserved.
//

#import "FCOutputAudio.h"

void output_callback(void *data, AudioQueueRef aq, AudioQueueBufferRef buf)
{
	[(FCOutputAudio *)CFBridgingRelease(data) OnOutput:buf];
}


@implementation FCOutputAudio

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
		_volume = 1.0;
		mbAudioQueueStart = false;
		mbAudioQueuePause = false;
	}
	
	return self;
}

- (void)dealloc
{
	//NSLog(@"FCOutputAudio dealloc--- %d", [self retainCount]);
	if (_queue != NULL) {
		[self ReleaseAudio];
	}
}

- (bool)InitAudio:(AudioStreamBasicDescription *)fmt :(int)pack_len
{
	OSStatus err = noErr;
	err = AudioQueueNewOutput(fmt, output_callback, CFBridgingRetain(self), NULL, NULL, 0, &_queue);
	if (err != noErr) {
		_queue = NULL;
		return false;
	}
	for (int i = 0; i < AUDIO_BUFFER_COUNT; i++) {
		AudioQueueAllocateBuffer(_queue, pack_len, &_buf[i]);
		_buf[i]->mAudioDataByteSize = 0;
		_buf[i]->mUserData = (void*)-1;
	}
	
	//AudioQueueSetParameter(_queue, kAudioQueueParam_Volume, _volume);
	
	
	return true;	
}

- (void)AudioStart
{
	if (_queue) {
		mbAudioQueuePause = true;
		mbAudioQueueStart = true;
		//AudioQueueStart(_queue, NULL);
	}
}

- (void)AudioStop
{
	if (_queue) {
		mbAudioQueueStart = false;
		mbAudioQueuePause = false;
		AudioQueueReset(_queue);
		AudioQueueStop(_queue, true);
		for (int i=0; i<AUDIO_BUFFER_COUNT; i++){
			_buf[i]->mAudioDataByteSize = 0;
			_buf[i]->mUserData = (void*)-1;
		}
	}
}

- (void)ReleaseAudio
{
	if (_queue != NULL) {
		if (mbAudioQueueStart) {
            mbAudioQueueStart = false;
            mbAudioQueuePause = false;
			AudioQueueStop(_queue, true);
		}
		
		AudioQueueDispose(_queue, true);
		_queue = NULL;
	}
}

- (bool)WriteData :(const void *)data :(int)length
{
    if (!mbAudioQueueStart) {
        return false;
    }
	int i=0;
	for (; i<AUDIO_BUFFER_COUNT; i++) {
		if (_buf[i]->mUserData == (void*)-1) {
			memcpy(_buf[i]->mAudioData, data , length);
			_buf[i]->mAudioDataByteSize = length;
			_buf[i]->mUserData = (void*)0;
			AudioQueueEnqueueBuffer(_queue, _buf[i], 0, NULL);
			break;
		}
	}
	if (i != AUDIO_BUFFER_COUNT && mbAudioQueuePause) {	//需要重起
		printf("restart -- \n");
		AudioQueueStart(_queue, NULL);
		mbAudioQueuePause = false;
	}
	return true;
}

- (void)OnOutput :(AudioQueueBufferRef)buf
{
    if (!mbAudioQueueStart) {
        return;
    }
	//printf("%d\n",(int)buf->mUserData);
	buf->mAudioDataByteSize = 0;
	buf->mUserData = (void*)-1;
	
	for (int i=0; i<AUDIO_BUFFER_COUNT; i++) {
		if (_buf[i]->mUserData == (void*)0) {
			mbAudioQueuePause = false;
			return;
		}
	}
	mbAudioQueuePause = true;
	AudioQueuePause(_queue);
}

- (bool)SetVolume:(double)volume
{
	if (volume > 1) {
		volume = 1;
	}
	if (volume < 0) {
		volume = 0;
	}
	
	_volume = volume;
	AudioQueueSetParameter(_queue, kAudioQueueParam_Volume, _volume);
	
	return true;
}

- (double)GetVolume
{
	return _volume;
}

- (bool)IsInit
{
	return (_queue != NULL);
}


@end
