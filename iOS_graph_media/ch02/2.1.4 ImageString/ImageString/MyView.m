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
	
	[myImageObj drawInRect:CGRectMake(0, 40, 320, 400)];// [myImageObj drawAsPatternInRect:CGRectMake(0, 0, 320, 400)];

    
	NSString *s = @"我的小狗";
    
    UIFont *font = [UIFont systemFontOfSize:34];
    NSDictionary *attr = @{NSFontAttributeName:font};
	[s drawAtPoint:CGPointMake(100, 20) withAttributes:attr];
    
}

@end