//
//  TModalViewController.m
//  TransitionAnimator
//
//  Created by tonyguan on 14-1-5.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "TModalViewController.h"

@interface TModalViewController ()
- (IBAction)click:(id)sender;

@end

@implementation TModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
