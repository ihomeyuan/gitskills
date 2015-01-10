//
//  MyView.m
//  ImageString
//
//  Created by 关东升 on 13-1-6.
//  本书网站：http://www.iosbook3.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//
//

#import "MyView.h"

@implementation MyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{    
	
	NSString* imagePath = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"png"]; //rabbit
	UIImage* myImageObj = [[UIImage alloc] initWithContentsOfFile:imagePath];
    //[myImageObj drawAtPoint:CGPointMake(0, 40)];//dog.png == 512*512 pixel 在iPhone5上最多只能显示320*568
	//[myImageObj drawInRect:CGRectMake(0, 40, 320, 500)];//将整个图片绘制到指定区域，根据区域拉伸图像
    [myImageObj drawAsPatternInRect:CGRectMake(0, 0, 320, 400)];//将图片平铺到指定区域。（按图片原始大小，在指定区域绘制，没有绘制满区域就再绘制一行或一列）

    
	NSString *s = @"我的小狗说的分手的";
    
    UIFont *font = [UIFont systemFontOfSize:34];
    NSDictionary *attr = @{NSFontAttributeName:font};
	//[s drawAtPoint:CGPointMake(100, 20) withAttributes:attr];//默认绘制一行，如果receiver中有换行符，那就在正下方再起一行
    [s drawInRect:CGRectMake(0, 0, 200, 400) withAttributes:attr];//这个方法绘制指定区域能绘制的尽可能多的字符，如果绘制不下了，裁去剩下的字符。
}

@end