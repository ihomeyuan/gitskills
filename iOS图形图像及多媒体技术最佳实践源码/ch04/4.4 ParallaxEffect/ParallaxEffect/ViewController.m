//
//  ViewController.m
//  ParallaxEffect
//
//  Created by tonyguan on 14-1-4.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mountain;
@property (weak, nonatomic) IBOutlet UIImageView *tree;
@property (weak, nonatomic) IBOutlet UIImageView *cowboy;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    //设置山在X轴的偏移范围-50.0~50.0
    UIInterpolatingMotionEffect *mountainEffectX;
    mountainEffectX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                              type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    mountainEffectX.maximumRelativeValue = @50.0;
	mountainEffectX.minimumRelativeValue = @-50.0;
    [self.mountain addMotionEffect:mountainEffectX];
    
    //设置树在X轴的偏移范围-100.0~100.0
    UIInterpolatingMotionEffect *treeEffectX;
    treeEffectX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                      type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    treeEffectX.maximumRelativeValue = @100.0;
	treeEffectX.minimumRelativeValue = @-100.0;
    [self.tree addMotionEffect:treeEffectX];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
