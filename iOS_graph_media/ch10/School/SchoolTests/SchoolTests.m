//
//  SchoolTests.m
//  SchoolTests
//
//  Created by mac on 14-1-16.
//  Copyright (c) 2014年 EOrient. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BusinessLogicStub.h"

////定义 根据类别1查询类别2 通知
//#define	Category2ByCategory1Notification      @"Category2ByCategory1"
////定义 根据类别2查询课程 通知
//#define	CourseByCategory2Notification         @"CourseByCategory2"
////定义 根据类别1查询课程 通知
//#define	CourseByCategory1Notification         @"CourseByCategory1"

@interface SchoolTests : XCTestCase

@end

@implementation SchoolTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_FindCategory2ByCategory1
{

//    BusinessLogicStub *stub = [BusinessLogicStub sharedManager];
//    [stub findCategory2ByCategory1:@"6"];
}

@end
