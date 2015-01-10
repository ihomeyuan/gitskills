//
//  DrawView.m
//  StrokedFilledTriangle
//
//  Created by tonyguan on 14-1-3.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

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
    
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextMoveToPoint (context, 75, 10);
	CGContextAddLineToPoint (context, 10, 150);
	CGContextAddLineToPoint (context, 160, 150);
	CGContextClosePath(context);
    
	// 设置黑色描边参数
	[[UIColor blackColor] setStroke];
    // 设置红色条填充参数
	[[UIColor redColor] setFill];
	//绘制路径
	CGContextDrawPath(context, kCGPathFillStroke);
    
}

@end
