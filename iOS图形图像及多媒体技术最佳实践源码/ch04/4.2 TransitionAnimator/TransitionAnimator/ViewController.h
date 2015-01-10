//
//  ViewController.h
//  TransitionAnimator
//
//  Created by tonyguan on 14-1-5.
//  本书网站：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  智捷iOS课堂微信公共账号：智捷iOS课堂
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import <UIKit/UIKit.h>
#import "HUTransitionAnimator.h"

typedef NS_ENUM(NSInteger, HUTransitionType) {
    Transition6Style,
    TransitionGhost,
    TransitionVerticalLines,
    TransitionHorizontalLines,
};


@interface ViewController : UITableViewController <UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>

@property HUTransitionType transitionType;

@end

