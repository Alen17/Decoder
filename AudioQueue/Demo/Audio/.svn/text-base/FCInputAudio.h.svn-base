//
//  FCInputAudio.h
//  plugin_test_1
//
//  Created by foscam on 11/11/11.
//  Copyright 2011 foscam. All rights reserved.
//

#define AUDIO_TALK_COUNT	10
#import <AudioToolbox/AudioToolbox.h>
//#import "FCDefine.h"
typedef void (^INPUT_AUDIO_CB)(const void *frame, int size, int index, const AudioTimeStamp *time, void *userdata);

@interface FCInputAudio : NSObject {
	AudioQueueRef		_queue;
	AudioQueueBufferRef	_buf[AUDIO_TALK_COUNT];
	
	bool		mAudioQueueStrar;
	int			_index;
	int			_length;
    AudioStreamBasicDescription* _fmt;
	
	INPUT_AUDIO_CB	_audio_cb;
	void			*_userdata;
    NSThread        *mThread;
    CFRunLoopRef    mThreadRef;
    
    NSTimer*        mTimer;
}

- (void)OnInput :(AudioQueueBufferRef)buf :(const AudioTimeStamp *)time;


/*****************************************************************
 * interface
 *****************************************************************/
- (bool)InitAudio:(AudioStreamBasicDescription *)fmt :(int)pack_len :(INPUT_AUDIO_CB)audio_cb :(void *)userdata;
- (void)ReleaseAudio;
- (bool)IsInit;
- (void)ThreadWork;

@end
