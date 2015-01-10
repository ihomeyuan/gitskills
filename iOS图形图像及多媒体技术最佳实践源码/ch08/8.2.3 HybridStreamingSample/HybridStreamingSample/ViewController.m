//
//  ViewController.m
//  HybridStreamingSample
//
//  Created by tonyguan on 14-1-10.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.mediaPlaybackAllowsAirPlay = YES;
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"html"];
	NSURL *bundleUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSError *error = nil;
    
	NSString *html = [[NSString alloc] initWithContentsOfFile:htmlPath encoding: NSUTF8StringEncoding error:&error];
    
    if (error == nil) {//数据加载没有错误情况下
        [self.webView loadHTMLString:html baseURL:bundleUrl];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
