//
//  File.h
//  Demo
//
//  Created by hu on 2017/8/11.
//  Copyright © 2017年 jxj. All rights reserved.
//

#import <Foundation/Foundation.h>

static id obj;

@protocol FrameDelegate <NSObject>

- (void)callBackFrame:(char *)buf Len:(int)len;

@end

@interface FileFrame : NSObject

- (void)initOBJ:(id)objc;

@property (nonatomic, weak) id<FrameDelegate> delegate;

int file_open(char *file_name);
int file_close(int fd);

int file_read(char* path, int fd);


@end
