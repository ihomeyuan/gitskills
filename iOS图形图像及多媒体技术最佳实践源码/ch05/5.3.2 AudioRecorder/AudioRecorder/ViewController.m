//
//  ViewController.m
//  AudioRecorder
//
//  Created by tonyguan on 14-1-6.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVAudioRecorderDelegate>
{
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
}

@property (weak, nonatomic) IBOutlet UILabel *label;

- (IBAction)record:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)play:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.label.text = @"停止";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

- (IBAction)record:(id)sender {
    
    if (recorder == nil) {
        
        NSString *filePath =
        [NSString stringWithFormat:@"%@/rec_audio.caf", [self documentsDirectory]];
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        
        NSError *error = nil;
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord
                                               error:&error];
        [[AVAudioSession sharedInstance] setActive:YES error:&error];
        
        NSMutableDictionary *settings = [NSMutableDictionary dictionary];
        [settings setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM]
                    forKey:AVFormatIDKey];
        [settings setValue:[NSNumber numberWithFloat:44100.0]
                    forKey:AVSampleRateKey];
        [settings setValue:[NSNumber numberWithInt:1]
                    forKey:AVNumberOfChannelsKey];
        [settings setValue:[NSNumber numberWithInt:16]
                    forKey:AVLinearPCMBitDepthKey];
        [settings setValue:[NSNumber numberWithBool:NO]
                    forKey:AVLinearPCMIsBigEndianKey];
        [settings setValue:[NSNumber numberWithBool:NO]
                    forKey:AVLinearPCMIsFloatKey];
        
        recorder = [[AVAudioRecorder alloc]
                    initWithURL:fileUrl
                    settings:settings
                    error:&error];
        
        recorder.delegate = self;
    }
    
    
	if(recorder.isRecording) {
        return;
    }
    
    if(player && player.isPlaying) {
        [player stop];
    }
    
    [recorder record];
    
    self.label.text = @"录制中...";
}

- (IBAction)stop:(id)sender {
    self.label.text = @"停止...";
    
	if(recorder.isRecording) {
        [recorder stop];
        recorder.delegate = nil;
        recorder = nil;
    }
    if(player.isPlaying) {
        [player stop];
    }
}

- (IBAction)play:(id)sender {
    
	if(recorder.isRecording) {
        [recorder stop];
        recorder.delegate = nil;
        recorder = nil;
    }
    if(player.isPlaying) {
        [player stop];
    }
    
    NSString *filePath =
    [NSString stringWithFormat:@"%@/rec_audio.caf", [self documentsDirectory]];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback
                                           error:&error];
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&error];
    
    if(error) {
        NSLog(@"%@",[error description]);
    } else {
        [player play];
        self.label.text = @"播放...";
    }
    
}


#pragma mark--实现AVAudioRecorderDelegate协议方法

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSLog(@"录制完成。");
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    NSLog(@"录制错误发生: %@", [error localizedDescription]);
}


- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder
{
    NSLog(@"播放中断。");
}


- (void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder withOptions:(NSUInteger)flags
{
    NSLog(@"中断返回。");
}


@end
