//
//  DrawView.m
//  BezierCurve
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
	CGContextRef cgContext = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(cgContext, 333, 0);
    CGContextAddCurveToPoint(cgContext, 333, 0, 332, 26, 330, 26);
    CGContextAddCurveToPoint(cgContext, 330, 26, 299, 20, 299, 17);
    CGContextAddLineToPoint(cgContext, 296, 17);
    CGContextAddCurveToPoint(cgContext, 296, 17, 296, 19, 291, 19);
    CGContextAddLineToPoint(cgContext, 250, 19);
    CGContextAddCurveToPoint(cgContext, 250, 19, 241, 24, 238, 19);
    CGContextAddCurveToPoint(cgContext, 236, 20, 234, 24, 227, 24);
    CGContextAddCurveToPoint(cgContext, 220, 24, 217, 19, 216, 19);
    CGContextAddCurveToPoint(cgContext, 214, 20, 211, 22, 207, 20);
    CGContextAddCurveToPoint(cgContext, 207, 20, 187, 20, 182, 21);
    CGContextAddLineToPoint(cgContext, 100, 45);
    CGContextAddLineToPoint(cgContext, 97, 46);
    CGContextAddCurveToPoint(cgContext, 97, 46, 86, 71, 64, 72);
    CGContextAddCurveToPoint(cgContext, 42, 74, 26, 56, 23, 48);
    CGContextAddLineToPoint(cgContext, 9, 47);
    CGContextAddCurveToPoint(cgContext, 9, 47, 0, 31, 0, 0);
    CGContextStrokePath(cgContext);

}

@end
