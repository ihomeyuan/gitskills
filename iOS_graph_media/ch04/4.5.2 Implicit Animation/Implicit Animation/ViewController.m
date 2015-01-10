//
//  ViewController.m
//  Implicit Animation
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
    
    CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(180, 200);
    [_plane.layer setAffineTransform:moveTransform];
    _plane.layer.opacity = 1;
}

@end
