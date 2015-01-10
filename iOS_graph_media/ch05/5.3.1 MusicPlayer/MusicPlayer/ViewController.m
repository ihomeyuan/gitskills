//
//  ViewController.m
//  MusicPlayer
//
//  Created by tonyguan on 14-1-6.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () <AVAudioPlayerDelegate>
{
    AVAudioPlayer *player;
}

@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UILabel *label;

- (IBAction)play:(id)sender;
- (IBAction)stop:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)play:(id)sender {
    
    NSError *error = nil;
    if (player == nil) {
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:
                  [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                          pathForResource:@"test" ofType:@"caf"]] error:&error];
        if(error) {
            NSLog(@"%@",[error description]);
            self.label.text = @"播放错误。";
            return;
        }
        player.delegate = self;
    }
    
    if (player.isPlaying == NO) {
        [player play];
        self.label.text = @"播放中...";
        UIImage *pauseImage = [UIImage imageNamed:@"pause"];
        [self.btnPlay setImage:pauseImage forState:UIControlStateNormal];
    } else if (player.isPlaying == YES){
        [player pause];
        self.label.text = @"播放暂停。";
        UIImage *playImage = [UIImage imageNamed:@"play"];
        [self.btnPlay setImage:playImage forState:UIControlStateNormal];
    }
    
    
}

- (IBAction)stop:(id)sender {
    if (player) {
        [player stop];
        player.delegate = nil;
        player = nil;
        self.label.text = @"播放停止。";
        UIImage *playImage = [UIImage imageNamed:@"play"];
        [self.btnPlay setImage:playImage forState:UIControlStateNormal];
    }
}

#pragma mark--实现AVAudioPlayerDelegate协议方法

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
	NSLog(@"播放完成。");
    self.label.text = @"播放完成。";
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
	NSLog(@"播放错误发生: %@", [error localizedDescription]);
    self.label.text = @"播放错误。";
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags
{
    NSLog(@"中断返回。");
    self.label.text = @"中断返回。";
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
    NSLog(@"播放中断。");
    self.label.text = @"播放中断。";
}

@end
