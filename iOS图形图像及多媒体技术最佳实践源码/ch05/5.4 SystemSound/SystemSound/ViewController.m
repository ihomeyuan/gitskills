//
//  ViewController.m
//  SystemSound
//
//  Created by tonyguan on 14-1-6.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

- (IBAction)playSystemSound:(id)sender;

- (IBAction)vibrate:(id)sender;

- (IBAction)alert:(id)sender;

@end


//定义一个回调函数，用于当声音播放完成之后回调。
void SoundFinishedPlayingCallback(SystemSoundID sound_id, void* user_data)
{
    //注销声音播放完成事件回调函数。
    AudioServicesRemoveSystemSoundCompletion(sound_id);
    //释放SystemSoundID
	AudioServicesDisposeSystemSoundID(sound_id);
}



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


- (IBAction)playSystemSound:(id)sender {
    NSURL* system_sound_url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                      pathForResource:@"AlertChordStroke" ofType:@"wav"]];
    
	SystemSoundID system_sound_id;
    
    //创建SystemSoundID
	AudioServicesCreateSystemSoundID(
                                     (CFURLRef)CFBridgingRetain(system_sound_url),
                                     &system_sound_id
                                     );
	
    //注销声音播放完成事件回调函数。
    AudioServicesAddSystemSoundCompletion(
                                          system_sound_id,
                                          NULL,
                                          NULL,
                                          SoundFinishedPlayingCallback,
                                          NULL
                                          );
    
	//播放系统声音
    AudioServicesPlaySystemSound(system_sound_id);
    
}

- (IBAction)alert:(id)sender {
    NSURL* system_sound_url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                      pathForResource:@"BeepGMC500" ofType:@"wav"]];
    
	SystemSoundID system_sound_id;
    //创建SystemSoundID
	AudioServicesCreateSystemSoundID(
                                     (CFURLRef)CFBridgingRetain(system_sound_url),
                                     &system_sound_id
                                     );
	
    // 注册声音播放完成事件回调函数。
    AudioServicesAddSystemSoundCompletion(
                                          system_sound_id,
                                          NULL,
                                          NULL,
                                          SoundFinishedPlayingCallback,
                                          NULL
                                          );
    
	// 发出警告
    AudioServicesPlayAlertSound(system_sound_id);
}

- (IBAction)vibrate:(id)sender {
    
    NSString * deviceModel = [[UIDevice currentDevice] model];
    NSLog(@"设备：%@",deviceModel);
    
    if ([deviceModel isEqualToString:@"iPhone"]) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"设备不支持"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles: nil];
        [alertView show];
    }
}



@end
