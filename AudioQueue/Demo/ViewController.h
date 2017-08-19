//
//  ViewController.h
//  Demo
//
//  Created by hu on 14-7-21.
//  Copyright (c) 2014年 jxj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AudioToolbox/AudioToolbox.h>

#define QUEUE_BUFFER_SIZE 16 //队列缓冲个数
#define MIN_SIZE_PER_FRAME 320 //每侦最小数据长度
#define FRAMES_PER_BLOCK   20   //每块有多少个音频帧;

@interface ViewController : UIViewController
{
    
    //音频 监听
    int m_stop;
    int m_start;
    AudioQueueBufferRef m_fillBuf;
    AudioQueueBufferRef m_audioQueueBuffers[QUEUE_BUFFER_SIZE];     //音频缓存
    int                 m_audioPutIndex;
    int                 m_AudioBuffsize;
    AudioStreamBasicDescription m_audioDescription;                 //音频参数
    bool                m_bUse[QUEUE_BUFFER_SIZE];  //标记是否使用
    AudioQueueRef       m_audioQueue;                             //音频播放队列
    pthread_mutex_t     m_queueBuffersMutex;			// a mutex to protect the inuse flags
	pthread_cond_t      m_queueBufferReadyCondition;	// a condition varable for handling the
    NSInteger           m_buffersUsed;
    int                 m_firstAudio;
    
    //音频 对讲
    long                m_handle_talk;
    AudioStreamBasicDescription m_audioDescription_talk;
    AudioQueueBufferRef         m_Buffers_talk[QUEUE_BUFFER_SIZE];
    unsigned long               m_talk_framesize;
    
    NSThread *m_stopStreamsThread;//关闭实时流
    
    UILabel *m_label;   //提示主次码流
    UILabel *m_labelError;//提示错误码
    
    UIScrollView *_scrollView;
    
    int tagTimer;
    
    
}

@property (nonatomic, assign) AudioQueueRef  m_queue_talk;

@end

