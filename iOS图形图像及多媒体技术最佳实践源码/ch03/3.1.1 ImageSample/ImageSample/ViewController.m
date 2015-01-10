//
//  ViewController.m
//  ImageSample
//
//  Created by tonyguan on 14-1-4.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //复制图片到沙箱目录下
    [self createEditableCopyOfDatabaseIfNeeded];
    
    _imageView.image = [UIImage imageNamed:@"SkyDrive340.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)createEditableCopyOfDatabaseIfNeeded {
	
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *writableDBPath = [self applicationDocumentsDirectoryFile];
	
	BOOL dbexits = [fileManager fileExistsAtPath:writableDBPath];
	if (!dbexits) {
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:FILE_NAME];
		
		NSError *error;
		BOOL success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
		if (!success) {
			NSAssert1(0, @"错误写入文件：'%@'。", [error localizedDescription]);
		}
	}
}

- (NSString *)applicationDocumentsDirectoryFile {
    
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:FILE_NAME];
	return path;
}

- (IBAction)loadBundle:(id)sender {
    _imageView.image = [UIImage imageNamed:@"SkyDrive340.png"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SkyDrive340" ofType:@"png"];
    UIImage* image = [[UIImage alloc] initWithContentsOfFile:path];
    _imageView.image = [UIImage imageNamed:@"SkyDrive340.png"];
    [image release];
    
}

- (IBAction)loadSandbox:(id)sender {
    
    NSString *path = [self applicationDocumentsDirectoryFile];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    _imageView.image = image;
    
}

- (IBAction)loadWebService:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://iosbook3.com/service/download.php?email=<您的http://iosbook3.com网站注册邮箱>&FileName=2004-2OH.jpg"];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    UIImage* image = [[UIImage alloc] initWithData:data];
    _imageView.image = image;
    
    [data release];
    [image release];
}


- (void)dealloc {
    [_imageView release];
    [super dealloc];
}

@end
