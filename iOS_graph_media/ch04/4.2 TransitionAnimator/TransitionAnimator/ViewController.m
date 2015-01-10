//
//  ViewController.m
//  TransitionAnimator
//
//  Created by tonyguan on 14-1-5.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () 

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"TransitionGhost"]) {
        self.transitionType = TransitionGhost;
    } else if ([[segue identifier] isEqualToString:@"TransitionVerticalLines"]) {
        self.transitionType = TransitionVerticalLines;
    }  else if ([[segue identifier] isEqualToString:@"TransitionHorizontalLines"]) {
        self.transitionType = TransitionHorizontalLines;
    }  else if ([[segue identifier] isEqualToString:@"Transition6Style"]) {
        self.transitionType = Transition6Style;
    } else {
        UIViewController* destinationViewController = [segue destinationViewController];
        destinationViewController.transitioningDelegate = self;
    }
}


#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    HUTransitionAnimator *animator;
    
    switch (self.transitionType) {
        case TransitionGhost:
            animator = [[HUTransitionGhostAnimator alloc] init];
            break;
        case TransitionVerticalLines:
            animator = [[HUTransitionVerticalLinesAnimator alloc] init];
            break;
        case TransitionHorizontalLines:
            animator = [[HUTransitionHorizontalLinesAnimator alloc] init];
            break;
        default:
            animator = [[HUTransitionAnimator alloc] init];
            break;
    }
    animator.presenting = (operation == UINavigationControllerOperationPop)?NO:YES;
    return animator;
    
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    id transitioning = [[HUTransitionVerticalLinesAnimator alloc] init];
    return transitioning;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    id transitioning = [[HUTransitionHorizontalLinesAnimator alloc] init];
    return transitioning;
}



@end
