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
    
    [UIView animateWithDuration:1.5 animations:^{
        CGRect frame = self.ball.frame;
        frame.origin.y += 100 * flag;
        flag *= -1; //取反
        self.ball.frame = frame;
    } completion:^(BOOL finished) {
        NSLog(@"动画结束了。");
        [self viewAnimationDone];
    }];
    
}


- (void)viewAnimationDone {
    [UIView animateWithDuration:1. animations:^{
        [self.button setAlpha:1.0];
    }];
}
@end
