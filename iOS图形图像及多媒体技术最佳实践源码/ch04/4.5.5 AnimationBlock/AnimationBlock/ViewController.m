//
//  ViewController.m
//  AnimationBlock
//
//  Created by tonyguan on 14-1-5.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    int flag ;
}

@property (weak, nonatomic) IBOutlet UIImageView *ball;
- (IBAction)click:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    flag = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)click:(id)sender {
    
    [self.button setAlpha:0.0];
    
    CGMutablePathRef starPath = CGPathCreateMutable();
    CGPathMoveToPoint(starPath,NULL,160.0f, 100.0f);
    CGPathAddLineToPoint(starPath, NULL, 100.0f, 280.0f);
    CGPathAddLineToPoint(starPath, NULL, 260.0, 170.0);
    CGPathAddLineToPoint(starPath, NULL, 60.0, 170.0);
    CGPathAddLineToPoint(starPath, NULL, 220.0, 280.0);
    CGPathCloseSubpath(starPath);
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation setDuration:10.0f];
    [animation setDelegate:self];
    [animation setPath:starPath];
    CFRelease(starPath);
    starPath = nil;
    [self.ball.layer addAnimation:animation forKey:@"position"];
}


- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    
    [UIView animateWithDuration:1. animations:^{
        [self.button setAlpha:1.0];
    }];
}



@end
