//
//  ViewController.m
//  EditVideoSample
//
//  Created by tonyguan on 14-1-9.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
<UIVideoEditorControllerDelegate,UINavigationControllerDelegate>

- (IBAction)editButtonPress:(id)sender;

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

- (IBAction)editButtonPress:(id)sender {
    
    NSBundle *bundle = [NSBundle mainBundle];
	NSString *moviePath = [bundle pathForResource:@"YY"
                                           ofType:@"mp4"];
    
    //判断设备是否支持编辑视频
    if ([UIVideoEditorController canEditVideoAtPath:moviePath]){
        
        
        UIVideoEditorController *videoEditor =
        [[UIVideoEditorController alloc] init];
        
        videoEditor.delegate = self;
        videoEditor.videoPath = moviePath;
        
        [self presentViewController:videoEditor animated:YES completion:NULL];
        
        
    } else {
        NSLog(@"不能编辑这个视频");
    }
    
}


- (void)videoEditorController:(UIVideoEditorController *)editor
     didSaveEditedVideoToPath:(NSString *)editedVideoPath{
    
    [editor dismissViewControllerAnimated:YES completion:NULL];
    
    
    if ( UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(editedVideoPath) ) {
        UISaveVideoAtPathToSavedPhotosAlbum(editedVideoPath, self,
                                            @selector(video:didFinishSavingWithError:contextInfo:),
                                            (__bridge void *)(editedVideoPath));
    }
}

- (void)videoEditorController:(UIVideoEditorController *)editor
             didFailWithError:(NSError *)error{
    NSLog(@"编辑视频出错");
    NSLog(@"Video editor error occurred = %@", error);
    [editor dismissViewControllerAnimated:YES completion:NULL];
}

- (void)videoEditorControllerDidCancel:(UIVideoEditorController *)editor{
    NSLog(@"视频编辑取消");
    [editor dismissViewControllerAnimated:YES completion:NULL];
}


- (void)video:(NSString *)videoPath
didFinishSavingWithError:(NSError *)error
  contextInfo:(NSString *)contextInfo {
    
    NSString *title; NSString *message;
    if (!error) {
        title = @"视频保存";
        message = @"视频已经保存到设备的相机胶卷中";
    } else {
        title =  @"视频失败";
        message = [error description];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
