//
//  GravityCollisionViewController.m
//  DynamicBehaviorSample
//
//  Created by tonyguan on 14-1-4.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "CollisionViewController.h"

@interface CollisionViewController ()


@property (nonatomic,strong) UIDynamicAnimator* animator;
@property (nonatomic,strong) UIGravityBehavior* gravity;
@property (nonatomic,strong) UICollisionBehavior* collision;


@end

@implementation CollisionViewController

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    //重力行为
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[_ballImageView]];
    //设置重力的方向
    CGVector gravityDirection = {0.0, 0.1};  // {x,y} 这里的单位g g=9.8m/s2 (像素/s2)
    [_gravity setGravityDirection:gravityDirection];
    [_animator addBehavior:_gravity];
    
    
    //碰撞行为
    _collision = [[UICollisionBehavior alloc]
                  initWithItems:@[_ballImageView]];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:_collision];
    
}

@end
