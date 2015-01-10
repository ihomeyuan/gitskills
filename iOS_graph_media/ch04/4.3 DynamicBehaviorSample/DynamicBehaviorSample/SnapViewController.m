//
//  SnapViewController.m
//  DynamicBehaviorSample
//
//  Created by tonyguan on 14-1-4.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "SnapViewController.h"

@interface SnapViewController () <UICollisionBehaviorDelegate>
{
    BOOL _firstContact;
}

@property (weak, nonatomic) IBOutlet UIImageView *box;

@property (nonatomic,strong) UIDynamicAnimator* animator;
@property (nonatomic,strong) UISnapBehavior *snap;

- (IBAction)handleSnapGesture:(UITapGestureRecognizer*)gesture;

@end

@implementation SnapViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundTile"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

}

- (IBAction)handleSnapGesture:(UITapGestureRecognizer*)gesture
{
    CGPoint point = [gesture locationInView:self.view];
    
    // 移除甩行为
    [_animator removeBehavior:_snap];
    
    _snap = [[UISnapBehavior alloc] initWithItem:_box snapToPoint:point];
    [self.animator addBehavior:_snap];
}


@end
