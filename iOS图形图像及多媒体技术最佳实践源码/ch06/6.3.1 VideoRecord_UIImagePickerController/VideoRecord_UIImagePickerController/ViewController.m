//
//  ViewController.m
//  VideoRecord_UIImagePickerController
//
//  Created by tonyguan on 14-1-9.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (IBAction)videoRecod:(id)sender;


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

- (IBAction)videoRecod:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;

        imagePickerController.mediaTypes = [[NSArray alloc]
                                            initWithObjects:(NSString *)kUTTypeMovie, nil];
        
        
        //录制质量设定
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
        
        //只允许最多录制30秒时间
        imagePickerController.videoMaximumDuration = 30.0f;
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    } else {
        NSLog(@"摄像头不可用。");
    }
}


- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerController: (UIImagePickerController *) picker
            didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
    NSString *tempFilePath = [url path];
    
    if ( UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(tempFilePath) ) {
        UISaveVideoAtPathToSavedPhotosAlbum( tempFilePath,
                                            self,
                                            @selector(video:didFinishSavingWithError:contextInfo:),
                                            (__bridge void *)(tempFilePath));
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(NSString *)contextInfo {
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


- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    NSLog(@"选择器将要显示。");
}


- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    NSLog(@"选择器显示结束。");
}

@end
