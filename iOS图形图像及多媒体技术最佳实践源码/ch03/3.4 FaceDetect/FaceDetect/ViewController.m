//
//  ViewController.m
//  FaceDetect
//
//  Created by tonyguan on 14-1-4.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"faces1.png"];
    _inputImageView.image = image;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    [_inputImageView release];
    [_outputImageView release];
    [_button release];
    [super dealloc];
}

- (IBAction)detect:(id)sender {
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    UIImage *imageInput = [_inputImageView image];
    CIImage *image = [CIImage imageWithCGImage:imageInput.CGImage];
    
    //设置识别参数
    NSDictionary *param = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh
                                                      forKey:CIDetectorAccuracy];
    //声明一个CIDetector，并设定识别类型
    CIDetector* faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace
                                                  context:context options:param];
    
    //取得识别结果
    NSArray *detectResult = [faceDetector featuresInImage:image];
    
    UIView *resultView = [[UIView alloc] initWithFrame:_inputImageView.frame];
    
    [self.view addSubview:resultView];
    
    
    for(CIFaceFeature* faceFeature in detectResult) {
        
        //脸部
        UIView* faceView = [[UIView alloc] initWithFrame:faceFeature.bounds];
        faceView.layer.borderWidth = 1;
        faceView.layer.borderColor = [UIColor orangeColor].CGColor;
        [resultView addSubview:faceView];
        [faceView release];
        
        //左眼
        if (faceFeature.hasLeftEyePosition) {
            UIView* leftEyeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
            [leftEyeView setCenter:faceFeature.leftEyePosition];
            leftEyeView.layer.borderWidth = 1;
            leftEyeView.layer.borderColor = [UIColor redColor].CGColor;
            [resultView addSubview:leftEyeView];
            [leftEyeView release];
        }
        
        //右眼
        if (faceFeature.hasRightEyePosition) {
            UIView* rightEyeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
            [rightEyeView setCenter:faceFeature.rightEyePosition];
            rightEyeView.layer.borderWidth = 1;
            rightEyeView.layer.borderColor = [UIColor redColor].CGColor;
            [resultView addSubview:rightEyeView];
            [rightEyeView release];
        }
        
        //嘴巴
        if (faceFeature.hasMouthPosition) {
            UIView* mouthView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
            [mouthView setCenter:faceFeature.mouthPosition];
            mouthView.layer.borderWidth = 1;
            mouthView.layer.borderColor = [UIColor redColor].CGColor;
            [resultView addSubview:mouthView];
            [mouthView release];
        }
        
    }
    
    [resultView setTransform:CGAffineTransformMakeScale(1, -1)];
    
    [resultView release];
    
    if ([detectResult count] > 0)
    {
        CIImage *faceImage = [image imageByCroppingToRect:[[detectResult objectAtIndex:0] bounds]];
        
        UIImage *face = [UIImage imageWithCGImage:[context createCGImage:faceImage fromRect:faceImage.extent]];
        self.outputImageView.image = face;
        
        [self.button setTitle:[NSString stringWithFormat:@"识别 人脸数 %i",
                               [detectResult count]] forState:UIControlStateNormal];
    }
    
}

@end
