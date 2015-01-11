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
    
	CGContextRef context = UIGraphicsGetCurrentContext();//获得当前的Graphics Context
	CGContextMoveToPoint (context, 75, 10);//设置新subpath起点位置
	CGContextAddLineToPoint (context, 10, 150);//增加一个从当前点到目标点的线段，并设置目标点为新的当前点
	CGContextAddLineToPoint (context, 160, 150);
	CGContextClosePath(context);//闭合并结束当前path的subpath（画一条从当前点到subpath起点的线段）
    
	// 设置黑色描边参数
	[[UIColor blackColor] setStroke];
    // 设置红色条填充参数
	[[UIColor redColor] setFill];
    
    CGContextSaveGState(context);//每一个graphics context 维护一个graphics states栈。这个函数将当前的state压入这个栈
    
    [[UIColor greenColor] setFill];
    
    CGContextRestoreGState(context);//出栈，并设置当前state为出栈的state
	//绘制路径
	CGContextDrawPath(context, kCGPathFillStroke);//使用给定的模式绘制并清除当前path
    
    //当前path是什么？path 是一系列图形或线段的数学描述。个人猜测UIGraphicsGetCurrentContext或者UIView在drawRect的时候，给我们准备了一个当前的path (也许可以用数组来描述path)
    
//    CGContextMoveToPoint(context,160,150);
//    CGContextAddLineToPoint(context, 225,10);
//    CGContextAddLineToPoint(context, 310,150);
//    CGContextClosePath(context);
//    CGContextDrawPath(context, kCGPathFillStroke);
    
    
}

@end
