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
    
    UIButton *theButton = (UIButton *)sender;
    switch (theButton.tag) {
        case 1:
            [UIView transitionWithView:self.view duration:3.0f
                               options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionFlipFromLeft
                            animations:NULL completion:NULL];
            break;
        case 2:
            [UIView transitionWithView:self.view duration:3.0f
                               options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionFlipFromRight
                            animations:NULL completion:NULL];
            break;
        case 3:
            [UIView transitionWithView:self.view duration:3.0f
                               options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionCurlUp
                            animations:NULL completion:NULL];
            break;
        case 4:
            [UIView transitionWithView:self.view duration:3.0f
                               options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionCurlDown
                            animations:NULL completion:NULL];
            break;
    }
    
}
@end
