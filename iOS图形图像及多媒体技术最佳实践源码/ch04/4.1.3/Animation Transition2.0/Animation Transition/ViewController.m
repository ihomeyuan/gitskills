//
//  ViewController.m
//  Animation Transition
//
//  Created by tonyguan on 14-1-5.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)doUIViewAnimation:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doUIViewAnimation:(id)sender {
    
    [UIView beginAnimations:@"animationID" context:nil];
	[UIView setAnimationDuration:3.0f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationRepeatAutoreverses:NO];
    
	UIButton *theButton = (UIButton *)sender;
	switch (theButton.tag) {
		case 1:
			[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
			break;
		case 2:
			[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
			break;
		case 3:
			[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
			break;
		case 4:
			[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
			break;
		default:
			break;
	}
	[UIView commitAnimations];
    
}
@end
