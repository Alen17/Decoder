//
//  FileFrame.m
//  Demo
//
//  Created by Foscam on 2017/7/4.
//  Copyright © 2017年 jxj. All rights reserved.
//

#import "FileFrame.h"

#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include "file.h"

#include <stdlib.h>
#include <string.h>

typedef enum {
    NALU_TYPE_SLICE    = 1,
    NALU_TYPE_DPA      = 2,
    NALU_TYPE_DPB      = 3,
    NALU_TYPE_DPC      = 4,
    NALU_TYPE_IDR      = 5,
    NALU_TYPE_SEI      = 6,
    NALU_TYPE_SPS      = 7,
    NALU_TYPE_PPS      = 8,
    NALU_TYPE_AUD      = 9,
    NALU_TYPE_EOSEQ    = 10,
    NALU_TYPE_EOSTREAM = 11,
    NALU_TYPE_FILL     = 12,
} NaluType;

typedef enum {
    NALU_PRIORITY_DISPOSABLE = 0,
    NALU_PRIRITY_LOW         = 1,
    NALU_PRIORITY_HIGH       = 2,
    NALU_PRIORITY_HIGHEST    = 3
} NaluPriority;

typedef enum {
    I_START = 0,
    I_STOP         = 1,
    P_START       = 2,
    P_STOP    = 3
} Naluhaha;

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

int file_read(char* path, int fd,  char *buf, int size, int *fr_type){
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
    unsigned char frame[512 * 1024];
    buf = frame;
    
    int i = 0;
    int j = 0;
    int frameType = 0;
    int frameLen = 0;
    int tmpFrameLen = 0;
    
    while (i < fileSize - 4){

        if (data[i] == 0x00 && data[i + 1] == 0x00 && data[i + 2] == 0x01){
            int nLen = GetLen(i + 3, fileSize, data);
            memset(frame, 0x00, sizeof(frame));
            memcpy(frame, &data[i], nLen + 3);
            //printfH264(j, i, nLen, data[i + 3]);
            printf("read a frame, index:%d, framesize:%d\n", j, nLen + 3);
            j++;
            i += 3;
            
            [obj setFrame:frame Len:(nLen + 3)];
            usleep(66000);

        }
//        else if (data[i] == 0x00 && data[i + 1] == 0x00 && data[i + 2] == 0x00 && data[i + 3] == 0x01){
//            int nLen = GetLen(i + 4, fileSize, data);
//            memset(frame, 0x00, sizeof(frame));
//            memcpy(frame, &data[i], nLen + 4);
//            //printfH264(j, i, nLen, data[i + 3]);
//            printf("read a frame, index:%d, framesize:%d\n", j, nLen + 4);
//            
//            [obj setFrame:frame Len:(nLen + 4)];
//            
//            usleep(660000);
//            
//            j++;
//            i += 4;
//        }

        else if (data[i] == 0x00 && data[i + 1] == 0x00 && data[i + 2] == 0x00 && data[i + 3] == 0x01){
            int nLen = GetLen(i + 4, fileSize, data);
            //int type = printfH264(j, i, nLen, data[i + 4]);
            int type = data[i + 4] & 0x1f;
            //memset(frame, 0x00, sizeof(frame));
            switch(type)
            {
                case NALU_TYPE_SLICE:
                {
                    memcpy(&frame[tmpFrameLen], &data[i], nLen + 4);
                    frameLen = tmpFrameLen + nLen +4;
                    tmpFrameLen = 0;
                    frameType = P_STOP;
                }
                    break;
                case NALU_TYPE_IDR:
                {
                    memcpy(&frame[tmpFrameLen], &data[i], nLen + 4);
                    frameLen = tmpFrameLen + nLen +4;
                    tmpFrameLen = 0;
                    frameType = I_STOP;
                }
                    break;
                case NALU_TYPE_SEI:
                {
                    if (I_START == frameType)
                    {
                        memcpy(&frame[tmpFrameLen], &data[i], nLen + 4);
                        tmpFrameLen += nLen + 4;
                    }
                    else
                    {
                        frameType = P_START;
                        memcpy(frame, &data[i], nLen + 4);
                        tmpFrameLen = nLen + 4;

                    }
                }
                    break;
                case NALU_TYPE_SPS:
                {
                    frameType = I_START;
                    memcpy(frame, &data[i], nLen + 4);
                    tmpFrameLen = nLen + 4;
                }
                    break;
                case NALU_TYPE_PPS:
                {
                    memcpy(&frame[tmpFrameLen], &data[i], nLen + 4);
                    tmpFrameLen += nLen + 4;
                }
                    break;
                default:
                    break;
            }
            //if (NALU_TYPE_SPS == type || NALU_TYPE_PPS == type|| NALU_TYPE_SEI == type)
            //memcpy(frame, &data[i], nLen + 4);
            if (I_STOP == frameType || P_STOP == frameType)
            {
                printf("read a frame, index:%d, framesize:%d\n", j, frameLen);
                [obj setFrame:frame Len:frameLen];
                usleep(33000);
            }
            j++;
            i += 4;
            

        }
        else{
            i++;
        }
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

int printfH264(int j, int i, int nLen, int nFrameType)
{
    printf("%d  %d", j, i);
    int nForbiddenBit = (nFrameType>>7) & 0x1;//第1位禁止位，值为1表示语法出错
    int nReference_idc = (nFrameType>>5) & 0x03;//第2~3位为参考级别
    int nType = nFrameType & 0x1f;//第4~8为是nal单元类型
    
    
    printf("  ");
    switch(nReference_idc){
        case NALU_PRIORITY_DISPOSABLE:
            printf("DISPOS");
            break;
        case NALU_PRIRITY_LOW:
            printf("LOW");
            break;
        case NALU_PRIORITY_HIGH:
            printf("HIGH");
            break;
        case NALU_PRIORITY_HIGHEST:
            printf("HIGHEST");
            break;
    }
    
    printf("  ");
    switch(nType){
        case NALU_TYPE_SLICE:
            printf("SLICE");
            break;
        case NALU_TYPE_DPA:
            printf("DPA");
            break;
        case NALU_TYPE_DPB:
            printf("DPB");
            break;
        case NALU_TYPE_DPC:
            printf("DPC");
            break;
        case NALU_TYPE_IDR:
            printf("IDR");
            break;
        case NALU_TYPE_SEI:
            printf("SEI");
            break;
        case NALU_TYPE_SPS:
            printf("SPS");
            break;
        case NALU_TYPE_PPS:
            printf("PPS");
            break;  
        case NALU_TYPE_AUD:  
            printf("AUD");  
            break;  
        case NALU_TYPE_EOSEQ:  
            printf("EOSEQ");  
            break;  
        case NALU_TYPE_EOSTREAM:  
            printf("EOSTREAM");  
            break;  
        case NALU_TYPE_FILL:  
            printf("FILL");  
            break;  
    }  
    
    printf("  %d\r\n", nLen);
    
    return nType;
}

- (void)setFrame:(unsigned char *)buf Len:(int)len{
    [_delegate callBackFrame:buf Len:len];
}


@end
