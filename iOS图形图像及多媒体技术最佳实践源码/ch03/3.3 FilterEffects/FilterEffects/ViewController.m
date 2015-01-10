//
//  ViewController.m
//  FilterEffects
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
    _image = [UIImage imageNamed:@"SkyDrive340.png"];
    _imageView.image = _image;
    
    flag  = 0;
    
    _label.text = @"";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_imageView release];
    [_slider release];
    [_label release];
    [super dealloc];
}


- (IBAction)changeValue:(id)sender {
    if (flag == 0) {
        [self filterSepiaTone];
    } else if (flag == 1) {
        [self filterGaussianBlur];
    }
}

- (IBAction)segmentSelected:(id)sender {
    
    UISegmentedControl * seg = (UISegmentedControl*)sender;
    
    if (seg.selectedSegmentIndex == 0) {//旧色调
        flag = 0;
    } else { //高斯模糊
        flag = 1;
    }
    
}

- (void)filterSepiaTone {
    
    CIContext *context = [CIContext contextWithOptions:nil];
	CIImage *cImage = [CIImage imageWithCGImage:[_image CGImage]];
	CIImage *result;
    
    CIFilter *sepiaTone = [CIFilter filterWithName: @"CISepiaTone"];
    [sepiaTone setValue: cImage forKey: @"inputImage"];
    double value  = [_slider value];
    
    NSString *text =[[NSString alloc] initWithFormat:@"旧色调 Intensity : %.2f",value];
    _label.text = text;
    [text release];
    
    [sepiaTone setValue: [NSNumber numberWithFloat: value]
                 forKey: @"inputIntensity"];
    
    result = [sepiaTone valueForKey:@"outputImage"];
    
    CGImageRef imageRef = [context createCGImage:result fromRect:CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height)];
    UIImage *image =  [[UIImage alloc] initWithCGImage:imageRef];
    
    _imageView.image = image;
    
    CFRelease(imageRef);
    [image release];
    
    flag = 0;
}

- (void)filterGaussianBlur {
    
    CIContext *context = [CIContext contextWithOptions:nil];
	CIImage *cImage = [CIImage imageWithCGImage:[_image CGImage]];
	CIImage *result;
    
    CIFilter *gaussianBlur = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlur setValue: cImage forKey: @"inputImage"];
    double value  = [_slider value];
    value *=10;
    
    //NSLog(@"高斯模糊 Radius : %.2f",value);
    NSString *text =[[NSString alloc] initWithFormat:@"高斯模糊 Radius : %.2f",value];
    _label.text = text;
    [text release];
    
    [gaussianBlur setValue: [NSNumber numberWithFloat: value] //250
                    forKey: @"inputRadius"];
    
    result = [gaussianBlur valueForKey:@"outputImage"];
    
    CGImageRef imageRef = [context createCGImage:result fromRect:CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height)];
    UIImage *image =  [[UIImage alloc] initWithCGImage:imageRef];
    
    _imageView.image = image;
    
    CFRelease(imageRef);
    [image release];
    
    flag = 1;
}

@end
