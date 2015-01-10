//
//  ViewController.h
//  School
//
//  Created by mac on 14-1-16.
//  本书网站：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  智捷iOS课堂微信公共账号：智捷iOS课堂
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import <UIKit/UIKit.h>
#import "HomeCollectionViewCell.h"
#import "HUTransitionAnimator.h"

//一行中列数
#define COL_COUNT 3

@interface ViewController : UIViewController
    <UICollectionViewDelegate, UICollectionViewDataSource,
    UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) NSArray * datas;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
