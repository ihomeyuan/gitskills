//
//  ViewController.m
//  Keyframe Animation
//
//  Created by tonyguan on 14-1-5.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,retain) IBOutlet UIImageView *plane;

-(IBAction)movePlane:(id)sender;

@end

@implementation ViewController


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _plane.layer.opacity = 0.25;
    
}

-(IBAction)movePlane:(id)sender {
    
    CAKeyframeAnimation *opAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
	opAnim.duration = 6.0;
	opAnim.values =[NSArray arrayWithObjects:
					[NSNumber numberWithFloat:0.25],
					[NSNumber numberWithFloat:0.75],
					[NSNumber numberWithFloat:1.0],
					nil];
	opAnim.keyTimes = [NSArray arrayWithObjects:
					   [NSNumber numberWithFloat:0.0],
					   [NSNumber numberWithFloat:0.5],
					   [NSNumber numberWithFloat:1.0], nil];
    
    opAnim.fillMode = kCAFillModeForwards;
    opAnim.removedOnCompletion = NO;
    
	
	[_plane.layer addAnimation:opAnim forKey:@"animateOpacity"];
    
    
	
	CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(180, 200);
	CABasicAnimation *moveAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
	moveAnim.duration = 6.0;
	moveAnim.toValue= [NSValue valueWithCATransform3D:
					   CATransform3DMakeAffineTransform(moveTransform)];
    
    moveAnim.fillMode = kCAFillModeForwards;
    moveAnim.removedOnCompletion = NO;
    
	[_plane.layer addAnimation:moveAnim forKey:@"animateTransform"];
    
}

@end
