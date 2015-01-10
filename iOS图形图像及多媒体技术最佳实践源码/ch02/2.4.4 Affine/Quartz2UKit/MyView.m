//
//  DrawView.m
//  Quartz2UKit
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
    
	NSString *path = [[NSBundle mainBundle] pathForResource:@"cat" ofType:@"png"];
	UIImage *img = [UIImage imageWithContentsOfFile:path];
	CGImageRef image = img.CGImage;
    
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
    
    
    CGAffineTransform myAffine = CGAffineTransformMakeTranslation(0, img.size.height);
	myAffine = CGAffineTransformScale(myAffine, 1, -1);
	CGContextConcatCTM(context, myAffine);
    
    
	CGRect touchRect = CGRectMake(0, 0, img.size.width, img.size.height);
	CGContextDrawImage(context, touchRect, image);
    
	CGContextRestoreGState(context);
    
}
@end
