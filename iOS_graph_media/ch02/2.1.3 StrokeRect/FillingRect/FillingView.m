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
    [[UIColor brownColor] setFill];
    UIRectFill(rect);
    
    [[UIColor whiteColor] setStroke];
    CGRect frame = CGRectMake(20, 30, 100, 300);
    UIRectFrame(frame);
}


@end
