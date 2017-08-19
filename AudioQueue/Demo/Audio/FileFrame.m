//G726 Decode
//
//  File.m
//  Demo
//
//  Created by hu on 2017/8/11.
//  Copyright © 2017年 jxj. All rights reserved.
//

#import "FileFrame.h"

#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>

#include <stdlib.h>
#include <string.h>
#import "g726.h"


@implementation FileFrame

- (void)initOBJ:(id)objc{
    obj = objc;
}

int file_open(char *file_name)
{
    int fd;
    if((fd = open(file_name, O_RDONLY)) < 0)
    {
        printf("err: open file %s\n", file_name);
    }
    return fd;
}

int file_close(int fd)
{
    if(fd) close(fd);
    return 0;
}

int file_read(char* path, int fd){
    char *data = NULL;
    int fileSize = 0;
    FILE *fp = fopen(path, "rb");
    if (!fp){
        printf("fopen file error\n");
        return -1;
    }
    printf("fopen file ok\n");
    fseek(fp, 0L, SEEK_END);
    printf("fseek file ok\n");
    
    fileSize = ftell(fp);
    printf("ftell file ok, fileSize:%d\n", fileSize);
    
    fseek(fp, 0L, SEEK_SET);
    data = (char *)malloc(fileSize + 1);
    memset(data, 0x00, fileSize + 1);
    
    
    int readLen = 0;
    readLen = fread(data, fileSize,1, fp);
    if (readLen < 0){
        printf("fread file failed\n");
        // error
        fclose(fp);
        return -1;
    }
    
    printf("fread file ok, readLen:%d\n", readLen);
    
    fclose(fp);
    unsigned char frame[1024];
    unsigned char debuf[1024];
    
    int i = 0;
    int j = 0;
    int frameLen = 120;
    while (i < fileSize){
        
        memset(frame, 0x00, sizeof(frame));
        memcpy(frame, &data[i], frameLen);
        
        printf("read a frame, index:%d, i = %d, framesize:%d\n", j, i, frameLen);
        
        g726_Decode((char*)frame, (char*)(debuf));
        
        [obj setFrame:debuf Len:frameLen*8];
        usleep(50000);
        
        i = i + frameLen;
        j++;
    }
    if (data) {
        free(data);
    }
    return -1;
    
}

int GetLen(int nPos, int nTotalSize, char* data)
{
    int nStart = nPos;
    while (nStart < nTotalSize){
        if (data[nStart] == 0x00 && data[nStart + 1] == 0x00 && data[nStart + 2] == 0x01){
            return nStart - nPos;
        }
        else if (data[nStart] == 0x00 && data[nStart + 1] == 0x00 && data[nStart + 2] == 0x00 && data[nStart + 3] == 0x01){
            return nStart - nPos;
        }
        else{
            nStart++;
        }
    }
    return nTotalSize - nPos;//最后一帧。
}

- (void)setFrame:(unsigned char *)buf Len:(int)len{
    NSLog(@"TIME");
    [_delegate callBackFrame:buf Len:len];
}


@end

//PCM Decode
////
////  File.m
////  Demo
////
////  Created by hu on 2017/8/11.
////  Copyright © 2017年 jxj. All rights reserved.
////
//
//#import "FileFrame.h"
//
//#include <unistd.h>
//#include <sys/types.h>
//#include <sys/stat.h>
//#include <fcntl.h>
//#include <stdio.h>
//
//#include <stdlib.h>
//#include <string.h>
//
//
//@implementation FileFrame
//
//- (void)initOBJ:(id)objc{
//    obj = objc;
//}
//
//int file_open(char *file_name)
//{
//    int fd;
//    if((fd = open(file_name, O_RDONLY)) < 0)
//    {
//        printf("err: open file %s\n", file_name);
//    }
//    return fd;
//}
//
//int file_close(int fd)
//{
//    if(fd) close(fd);
//    return 0;
//}
//
//int file_read(char* path, int fd,  char *buf, int size, int *fr_type){
//    char *data = NULL;
//    int fileSize = 0;
//    FILE *fp = fopen(path, "rb");
//    if (!fp){
//        printf("fopen file error\n");
//        return -1;
//    }
//    printf("fopen file ok\n");
//    fseek(fp, 0L, SEEK_END);
//    printf("fseek file ok\n");
//    
//    fileSize = ftell(fp);
//    printf("ftell file ok, fileSize:%d\n", fileSize);
//    
//    fseek(fp, 0L, SEEK_SET);
//    data = (char *)malloc(fileSize + 1);
//    memset(data, 0x00, fileSize + 1);
//    
//    
//    int readLen = 0;
//    readLen = fread(data, fileSize,1, fp);
//    if (readLen < 0){
//        printf("fread file failed\n");
//        // error
//        fclose(fp);
//        return -1;
//    }
//    
//    printf("fread file ok, readLen:%d\n", readLen);
//    
//    fclose(fp);
//    unsigned char frame[512 * 1024];
//    buf = frame;
//    
//    int i = 0;
//    int j = 0;
//    int frameLen = 2500;
//    while (i < fileSize){
//        
//        memset(frame, 0x00, sizeof(frame));
//        memcpy(frame, &data[i], frameLen);
//        
//        printf("read a frame, index:%d, i = %d, framesize:%d\n", j, i, frameLen);
//
//        [obj setFrame:frame Len:frameLen];
//        usleep(12000);
//        
//        i = i + frameLen;
//        j++;
//    }
//    if (data) {
//        free(data);
//    }
//    return -1;
//    
//}
//
//int GetLen(int nPos, int nTotalSize, char* data)
//{
//    int nStart = nPos;
//    while (nStart < nTotalSize){
//        if (data[nStart] == 0x00 && data[nStart + 1] == 0x00 && data[nStart + 2] == 0x01){
//            return nStart - nPos;
//        }
//        else if (data[nStart] == 0x00 && data[nStart + 1] == 0x00 && data[nStart + 2] == 0x00 && data[nStart + 3] == 0x01){
//            return nStart - nPos;
//        }
//        else{
//            nStart++;
//        }
//    }
//    return nTotalSize - nPos;//最后一帧。
//}
//
//- (void)setFrame:(unsigned char *)buf Len:(int)len{
//    NSLog(@"TIME");
//    [_delegate callBackFrame:buf Len:len];
//}
//
//
//@end
