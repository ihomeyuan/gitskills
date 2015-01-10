//
//  ViewController.m
//  School
//
//  Created by mac on 14-1-16.
//  Copyright (c) 2014年 EOrient. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"Category1"
                                           ofType:@"plist"];
    self.datas = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    //自定义动画
    self.navigationController.delegate = self;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIButton* button = sender;
    NSInteger tag = button.tag;
    //    NSLog(@"tag = %i",tag);
    //tag是集合的索引
    NSDictionary* dict =  [self.datas objectAtIndex:tag];
    
    id obj = [dict objectForKey:@"id"];
    
    id objR = [dict objectForKey:@"r"];
    id objG = [dict objectForKey:@"g"];
    id objB = [dict objectForKey:@"b"];
    
    UIColor *color = [UIColor colorWithRed:[objR integerValue]/255.0f
                                     green:[objG integerValue]/255.0f
                                      blue:[objB integerValue]/255.0f alpha:1.0f];
    
    DetailViewController* destinationVC = (DetailViewController*)[segue destinationViewController];
    destinationVC.category1ID = [obj integerValue];
    destinationVC.category1Name = [dict objectForKey:@"name"];
    destinationVC.category1Icon = [dict objectForKey:@"icon"];
    destinationVC.color = color;
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    long count = [self.datas count] / COL_COUNT;
    
    if (([self.datas count] % COL_COUNT) != 0) {
        count++;
    }
    
    return count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return COL_COUNT;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    long index = indexPath.section * COL_COUNT + indexPath.row;
    
    if (index < [self.datas count]) {
        NSDictionary* dict =  [self.datas objectAtIndex:index];
        UIImage *image = [UIImage imageNamed:[dict objectForKey:@"image"]];
        
        [cell.button setImage:image forState:UIControlStateNormal];
        
        cell.button.tag = index;//集合索引
        cell.hidden = NO;
    } else {
        cell.hidden = YES;
    }
    return cell;
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    HUTransitionAnimator* animator;
    
    //    animator = [[HUTransitionGhostAnimator alloc] init];
    //    animator = [[HUTransitionVerticalLinesAnimator alloc] init];
    animator = [[HUTransitionHorizontalLinesAnimator alloc] init];
    
    return animator;
    
}


@end
