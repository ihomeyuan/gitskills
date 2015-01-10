//
//  ViewController.m
//  Layers
//
//  Created by tonyguan on 14-1-5.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, retain) CALayer *ballLayer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIImage *image = [UIImage imageNamed:@"ball.png"];
    self.ballLayer = [CALayer layer];
    self.ballLayer.contents = (id)[image CGImage];
    self.ballLayer.bounds = CGRectMake(0.0f, 0.0f, 125.0f, 125.0f); //174 × 172
    self.ballLayer.contentsGravity = kCAGravityResizeAspect;
    self.ballLayer.position = CGPointMake(CGRectGetMidX(self.view.bounds),
                                          CGRectGetMidY(self.view.bounds));
    [self.view.layer addSublayer:self.ballLayer];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
