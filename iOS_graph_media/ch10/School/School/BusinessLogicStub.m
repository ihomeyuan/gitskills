//
//  BusinessLogicStub.m
//  School
//
//  Created by mac on 14-1-16.
//  Copyright (c) 2014年 EOrient. All rights reserved.
//

#import "BusinessLogicStub.h"

@implementation BusinessLogicStub

static BusinessLogicStub *sharedManager = nil;

+ (BusinessLogicStub*)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}


#pragma mark --根据类别1查询类别2
-(void) findCategory2ByCategory1:(int)cid1
{
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@/BusinessLogicSkeleton.php?action=q1&cid1=%i",Webservice_URL_BASE,cid1];
	NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    __weak ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        
        NSData *data  = [request responseData];
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"解析完成...");
        [[NSNotificationCenter defaultCenter] postNotificationName:Category2ByCategory1Notification object:resDict userInfo:nil];

    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"%@", [error localizedDescription]);
        
    }];
    [request startAsynchronous];
    
}

#pragma mark --根据类别2查询课程
-(void) findCourseByCategory2:(int)cid2
{
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@/BusinessLogicSkeleton.php?action=q2&cid2=%i",Webservice_URL_BASE,cid2];
	NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    __weak ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        
        NSData *data  = [request responseData];
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"解析完成...");
        [[NSNotificationCenter defaultCenter] postNotificationName:CourseByCategory2Notification object:resDict userInfo:nil];
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"%@", [error localizedDescription]);
        
    }];
    [request startAsynchronous];
}

#pragma mark --根据类别1查询课程
-(void) findCourseByCategory1:(int)cid1
{
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@/BusinessLogicSkeleton.php?action=q3&cid1=%i",Webservice_URL_BASE,cid1];
	NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    __weak ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        
        NSData *data  = [request responseData];
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"解析完成...");
        [[NSNotificationCenter defaultCenter] postNotificationName:CourseByCategory1Notification object:resDict userInfo:nil];
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"%@", [error localizedDescription]);
        
    }];
    [request startAsynchronous];
}


@end
