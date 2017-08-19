//
//  FCOutputAudio.h
//  fsIPCam
//
//  Created by foscam on 11/11/11.
//  Copyright 2011 foscam. All rights reserved.
//

#define AUDIO_BUFFER_COUNT	10
#import <AudioToolbox/AudioToolbox.h>
#import <pthread.h>
@interface FCOutputAudio : NSObject {
	AudioQueueRef		_queue;
	AudioQueueBufferRef	_buf[AUDIO_BUFFER_COUNT];
	
	double	_volume;
	
	bool	mbAudioQueueStart;
	bool	mbAudioQueuePause;
}

- (void)OnOutput :(AudioQueueBufferRef)buf;

/*****************************************************************
 * interface
 *****************************************************************/
- (bool)InitAudio:(AudioStreamBasicDescription *)fmt :(int)pack_len;
- (void)ReleaseAudio;
- (bool)WriteData :(const void *)data :(int)length;

- (bool)SetVolume:(double)volume;
- (double)GetVolume;

- (bool)IsInit;

- (void)AudioStart;
- (void)AudioStop;

@end
