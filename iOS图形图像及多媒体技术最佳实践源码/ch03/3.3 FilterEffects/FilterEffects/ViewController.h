//
//  ViewController.h
//  FilterEffects
//
//  Created by tonyguan on 14-1-4.
//  本书网站：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  智捷iOS课堂微信公共账号：智捷iOS课堂
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    int flag;  // 0 为CISepiaTone 1 为CIGaussianBlur
}

@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@property (retain, nonatomic) IBOutlet UISlider *slider;

@property (retain, nonatomic) UIImage *image;

@property (retain, nonatomic) IBOutlet UILabel *label;


- (IBAction)changeValue:(id)sender;

- (IBAction)segmentSelected:(id)sender;

@end
