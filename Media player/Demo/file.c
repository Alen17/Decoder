//#include <unistd.h>
//#include <sys/types.h>
//#include <sys/stat.h>
//#include <fcntl.h>
//#include <stdio.h>
//#include "file.h"
//
//#include <stdlib.h>
//#include <string.h>
//
///*--------------- 720P ˝æ›÷°∏Ò Ω begin ---------------------*/
//typedef 	unsigned char BYTE;
//typedef 	unsigned short WORD;
//typedef 	unsigned int  DWORD;
//typedef		unsigned long long DWORD64;
//
//typedef struct _HI_VIDEO_INFO_S
//{
//	WORD				wImageWidth;	//ÕºœÒøÌ∂»
//	WORD				wImageHeight;	//ÕºœÒ∏ﬂ∂»
//	BYTE				byEncodeType;	// ”∆µ±‡¬Î∏Ò Ω0-h264 1-mjpeg 2-jpeg
//	BYTE				byFrameRate;	//÷°¬ (±£¡Ù)
//	BYTE				byPal;			//÷∆ Ω		0-n÷∆1-pal÷∆
//	BYTE				byRes[1];
//}HI_VIDEO_INFO_S,*LPHI_VIDEO_INFO_S;
//
//typedef struct _HI_AUDIO_INFO_S
//{
//	BYTE		byAudioSamples;			//≤…—˘¬ 	0--8k 1--16k 2-32k
//	BYTE		byEncodeType;			//“Ù∆µ±‡¬Î∏Ò Ω0--pcm 1-g711a 2-g711u 3--g726
//	BYTE		byAudioChannels;		//Õ®µ¿ ˝		‘›÷ª÷ß≥÷1	
//	BYTE		byAudioBits;			//Œª ˝			16bit
//	BYTE		byRes[4];
//}HI_AUDIO_INFO_S, *LPHI_AUDIO_INFO_S;
//
//typedef struct _HI_FRAME_HEAD_S
//{
//	WORD		wFrameFlag;				//0x3448 magic data
//	BYTE		wFrameType;				//I-0x7 p--0x8 b--0xb A--0xa
//	BYTE		byRsvd[1];				//±£¡Ù
//	DWORD		dwFrameNo;				//÷°∫≈
//	DWORD		dwTime;					//œµÕ≥ ±º‰
//	DWORD		dwFrameSize;			// ˝æ›¡˜≥§∂»
//	DWORD64		dw64TimeStamp;			// ±º‰¥¡ 
//	union
//	{
//		HI_VIDEO_INFO_S	unVideoInfo;
//		HI_AUDIO_INFO_S	unAudioInfo;
//	};
//}HI_FRAME_HEAD_S, *LPHI_FRAME_HEAD_S;
//
///*--------------- 720P ˝æ›÷°∏Ò Ω end ---------------------*/
//
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
//
////#if 0
////int file_read(int fd, char *buf, int size, int *fr_type)
////{
////
////    HI_FRAME_HEAD_S *fr_head = (HI_FRAME_HEAD_S*)buf;
////
////    int ret = -1;
////    int fr_size = 0;
////
////    ret = read(fd, fr_head, sizeof(HI_FRAME_HEAD_S));
////	if(ret != sizeof(HI_FRAME_HEAD_S))
////	{
////		if(lseek(fd, 0, SEEK_SET) < 0)
////        {
////            printf("err: lseek fd:%d\n", fd);
////        }
////        return (-1);
////	}
////
////    if((fr_head->dwFrameSize) && (fr_head->dwFrameSize < size))
////    {
////        fr_size = fr_head->dwFrameSize;
////        //I-0x7 p--0x8 b--0xb A--0xa
////        *fr_type = (fr_head->wFrameType == 0x7)?0x01:((fr_head->wFrameType == 0x8)?0x02:0x03);     
////        //printf("read: read fd:%d, size:%d\n", fd, fr_size);
////        
////        if(read(fd, buf + 0 /*sizeof(HI_FRAME_HEAD_S)*/, fr_size) != fr_size)
////        {
////            printf("err: read fd:%d, size:%d\n", fd, fr_size);
////            if(lseek(fd, 0, SEEK_SET) < 0)
////            {
////                printf("err: lseek fd:%d\n", fd);
////            }
////            return (-1);
////        }
////        else
////        {
////            return (fr_size);
////        }
////    }
////    return -1;
////}
////#else   // whl
//
////int file_open(char *file_name)
////{
////    FILE *fp = fopen(file_name, "r");
////    if(!fp)
////    {
////        printf("err: open file %s\n", file_name);
////    }
////    return 0;
////}
//
//int file_read(char* path, int fd, char *buf, int size, int *fr_type){
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
//    char frame[512 * 1024];
//    buf = frame;
//    
//    int i = 0;
//    int j = 0;
//
//    while (i < fileSize - 4){
//        if (data[i] == 0x00 && data[i + 1] == 0x00 && data[i + 2] == 0x01){
//            int nLen = GetLen(i + 3, fileSize, data);
//            memset(frame, 0x00, sizeof(frame));
//            memcpy(frame, &data[i], nLen + 3);
//            //printfH264(j, i, nLen, data[i + 3]);
//            printf("read a frame, index:%d, framesize:%d\n", j, nLen + 3);
//            j++;
//            i += 3;
//        }
//        else if (data[i] == 0x00 && data[i + 1] == 0x00 && data[i + 2] == 0x00 && data[i + 3] == 0x01){
//            int nLen = GetLen(i + 4, fileSize, data);
//            //printfH264(j, i, nLen, data[i + 4]);
//            memcpy(frame, &data[i], nLen + 4);
//            printf("read a frame, index:%d, framesize:%d\n", j, nLen + 4);
//            j++;
//            i += 4;
//        }
//        else{
//            i++;
//        }
//    }
//    if (data) {
//        free(data);
//    }
//    return -1;
//}
//
//int file_read2(int fd, char *buf, int size, int *fr_type)
//{
//    char *data = NULL;
//    int fileSize = 0;
//    FILE *fp = fopen("1.h264", "rb");
//    if (!fp){
//        printf("fopen file error\n");
//        return -1;
//    }
//    
//    printf("fopen file ok\n");
//    
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
//    int readLen = 0;
//    readLen = fread(data, fileSize,1, fp);
//    if (readLen < 0)
//    {
//        printf("fread file failed\n");
//        // error
//        fclose(fp);
//        return -1;
//    }
//    
//    printf("fread file ok, readLen:%d\n", readLen);
//    
//    fclose(fp);
//    
//    char frame[1024 * 1024] = {0};
//    
//    int j = 0;
//    int i = 0;
//    while (i < fileSize - 4){
//        if (data[i] == 0x00 && data[i + 1] == 0x00 && data[i + 2] == 0x01){
//            int nLen = GetLen(i + 3, fileSize, data);
//            memset(frame, 0x00, sizeof(frame));
//            memcpy(frame, &data[i], nLen + 3);
//            //printfH264(j, i, nLen, data[i + 3]);
//            printf("read a frame, index:%d, framesize:%d\n", j, nLen + 3);
//            j++;
//            i += 3;
//        }
//        else if (data[i] == 0x00 && data[i + 1] == 0x00 && data[i + 2] == 0x00 && data[i + 3] == 0x01){
//            int nLen = GetLen(i + 4, fileSize, data);
//            //printfH264(j, i, nLen, data[i + 4]);
//            memcpy(frame, &data[i], nLen + 4);
//            printf("read a frame, index:%d, framesize:%d\n", j, nLen + 4);
//            j++;
//            i += 4;
//        }
//        else{
//            i++;
//        }
//    }
//    
//    if (data){
//        free(data);
//    }
//    return -1;
//}
//
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
////#endif
//
//
//
//
//
//
//
