//
//  ViewController.m
//  OpenALPlayer
//
//  Created by tonyguan on 14-1-6.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"

#import <AudioToolbox/AudioFile.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>

@interface ViewController ()
{
    ALCcontext* mContext;
    ALCdevice* mDevice;
    NSUInteger sourceID;
    NSUInteger bufferID;
    BOOL isPlaying;
    BOOL isLoop;
}

@property (retain, nonatomic) IBOutlet UIButton *btnPlay;

- (IBAction)play:(id)sender;
- (IBAction)switchLoop:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isPlaying = NO;		// init playing status
	
	[self initOpenAL];
    
    [self initBuffer];
    
    // 从OpenAL中获得声源id
	alGenSources(1, &sourceID);
	
	// 将缓冲区和声源绑定
	alSourcei(sourceID, AL_BUFFER, bufferID);
	// 设置基本声源基本属性
	alSourcef(sourceID, AL_PITCH, 1.0f); //设置音高
	alSourcef(sourceID, AL_GAIN, 1.0f);  //设置音量
    
}


- (void)dealloc {
    // 释放内存
    [self cleanUpOpenAL];
}


- (IBAction)play:(id)sender {
    
	if(!isPlaying)
	{
        alSourcePlay(sourceID);
        if (isLoop) {
            isPlaying = YES;
            [_btnPlay setTitle:@"停止" forState:UIControlStateNormal];
        }
	} else {
		alSourceStop(sourceID);
		isPlaying = NO;
		[_btnPlay setTitle:@"播放" forState:UIControlStateNormal];
	}
    
}

- (IBAction)switchLoop:(id)sender {
    UISwitch* sw = (UISwitch*) sender;
    isLoop = sw.on;
    if (isLoop) {
        alSourcei(sourceID, AL_LOOPING, AL_TRUE);
    } else {
        alSourcei(sourceID, AL_LOOPING, AL_FALSE);
        alSourceStop(sourceID);
		isPlaying = NO;
		[_btnPlay setTitle:@"播放" forState:UIControlStateNormal];
    }
    
}

//初始化OpenAL
-(void)initOpenAL
{
    // 获得设备
    mDevice = alcOpenDevice(NULL);
    if (mDevice) {
        // 使用设备创建一个环境对象
        mContext=alcCreateContext(mDevice,NULL);
        // set my context to the currently active one
        alcMakeContextCurrent(mContext);
    }
}

//初始化缓冲区
-(void)initBuffer
{
    // 获得文件的完整路径
    NSString* fileName = [[NSBundle mainBundle] pathForResource:@"BeepGMC500" ofType:@"wav"];
    // 打开文件
    AudioFileID fileID = [self openAudioFile:fileName];
    
    // 获得实际音频文件大小
    UInt32 fileSize = [self audioFileSize:fileID];
    
    // 开辟音频内存数据空间
    unsigned char * outData = malloc(fileSize);
    
    // 读取文件到内存中
    OSStatus result = noErr;
    result = AudioFileReadBytes(fileID, false, 0, &fileSize, outData);
    //关闭文件
    AudioFileClose(fileID);
    //返回结果为 0 说明成功
    if (result != 0) {
        NSLog(@"cannot load effect: %@", fileName);
    }
    
    // 从OpenAL中获得缓冲区id
    alGenBuffers(1, &bufferID);
    
    // 内存中音频数据复制到缓冲区
    alBufferData(bufferID, AL_FORMAT_STEREO16, outData, fileSize, 44100);
    
    // 清除内存中音频数据
    if (outData) {
        free(outData);
        outData = NULL;
    }
}

//打开一个声音文件，并且得到了它的id
-(AudioFileID)openAudioFile:(NSString*)filePath
{
    AudioFileID outAFID;
    NSURL * afUrl = [NSURL fileURLWithPath:filePath];
    
    OSStatus result = AudioFileOpenURL((CFURLRef)CFBridgingRetain(afUrl),
                                       kAudioFileReadPermission, 0, &outAFID);
    if (result != 0) NSLog(@"cannot openf file: %@",filePath);
    return outAFID;
}

//计算数据的大小
-(UInt32)audioFileSize:(AudioFileID)fileDescriptor
{
    UInt64 outDataSize = 0;
    UInt32 thePropSize = sizeof(UInt64);
    OSStatus result = AudioFileGetProperty(fileDescriptor,
                                           kAudioFilePropertyAudioDataByteCount, &thePropSize, &outDataSize);
    if(result != 0) NSLog(@"cannot find file size");
    return (UInt32)outDataSize;
}

//释放内存
-(void)cleanUpOpenAL
{
	// 释放声源
	alDeleteSources(1, &sourceID);
    
	// 释放缓存
	alDeleteBuffers(1, &bufferID);
    
	// 释放环境
	alcDestroyContext(mContext);
	
	// 关闭设备
	alcCloseDevice(mDevice);
}

@end
