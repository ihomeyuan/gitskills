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
    /*
     [UIView beginAnimations:@"animations" context:nil];
     
     [UIView setAnimationDuration:1.5];
     
     CGRect frame = self.ball.frame;
     frame.origin.y += 100 * flag;
     flag *= -1; //取反
     self.ball.frame = frame;
     
     [UIView commitAnimations];
     
     */
    
    
    [UIView animateWithDuration:1.5 animations:^{
        CGRect frame = self.ball.frame;
        frame.origin.y += 100 * flag;
        flag *= -1; //取反
        self.ball.frame = frame;
    }];
}

@end
