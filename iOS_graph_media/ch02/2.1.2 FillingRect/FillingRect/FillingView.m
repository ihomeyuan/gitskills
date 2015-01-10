//
//  FillingView.m
//  FillingRect
//
//  Created by tonyguan on 14-1-3.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "FillingView.h"

@implementation FillingView

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
    [[UIColor brownColor] setFill];//设置当前填充颜色为receiver代表的颜色
    [[UIColor whiteColor] setStroke];//设置当前描边颜色为receiver代表的颜色
    UIRectFill(rect);
    
    CGRect frame = CGRectMake(20, 30, 100, 300);
    UIRectFrame(frame);
    
    
    
}


@end
