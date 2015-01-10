//
//  ViewController.m
//  VideoRecord_AVFoundation
//
//  Created by tonyguan on 14-1-9.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()
    <AVCaptureFileOutputRecordingDelegate>
{
    BOOL isRecording;
}

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureMovieFileOutput *output;

- (IBAction)recordPressed:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.session =  [[AVCaptureSession alloc] init];
    self.session.sessionPreset = AVCaptureSessionPresetMedium;
    
    AVCaptureDevice *cameraDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    AVCaptureDeviceInput *camera = [AVCaptureDeviceInput deviceInputWithDevice:cameraDevice error:&error];
    
    AVCaptureDevice *micDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput *mic = [AVCaptureDeviceInput deviceInputWithDevice:micDevice error:&error];
    
    if (error || !camera || !mic) {
        NSLog(@"Input Error");
    } else {
        [self.session addInput:camera];
        [self.session addInput:mic];
    }
    
    self.output = [[AVCaptureMovieFileOutput alloc] init];
    
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    previewLayer.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    
    
    [self.session startRunning];
    isRecording = NO;
    self.label.text = @"";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self.session isRunning])
    {
        [self.session startRunning];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.session isRunning])
    {
        [self.session stopRunning];
    }
}


- (IBAction)recordPressed:(id)sender {
    if (!isRecording)
    {
        [self.button setTitle:@"停止" forState:UIControlStateNormal];
        self.label.text = @"录制中...";
        isRecording = YES;
        NSURL *fileURL = [self fileURL];
        [self.output startRecordingToOutputFileURL:fileURL recordingDelegate:self];
    }
    else
    {
        [self.button setTitle:@"录制" forState:UIControlStateNormal];
        self.label.text = @"停止";
        [self.output stopRecording];
        isRecording = NO;
    }
}

- (NSURL *) fileURL
{
    NSString *outputPath = [[NSString alloc] initWithFormat:@"%@%@", NSTemporaryDirectory(), @"movie.mov"];
    NSURL *outputURL = [[NSURL alloc] initFileURLWithPath:outputPath];
    
    NSFileManager *manager = [[NSFileManager alloc] init];
    if ([manager fileExistsAtPath:outputPath])
    {
        [manager removeItemAtPath:outputPath error:nil];
    }
    
    return outputURL;
}

#pragma  mark-- AVCaptureFileOutputRecordingDelegate委托协议实现方法

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput
    didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL
    fromConnections:(NSArray *)connections error:(NSError *)error
{
    
    if (error == nil) {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        
        [library writeVideoAtPathToSavedPhotosAlbum:outputFileURL
                                    completionBlock:^(NSURL *assetURL, NSError *error)
         {
             if (error)
             {
                 NSLog(@"写入错误。") ;
             }
             
         }];
    }
    
}

@end
