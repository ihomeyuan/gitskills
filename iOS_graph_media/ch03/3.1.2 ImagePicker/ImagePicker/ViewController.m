//
//  ViewController.m
//  ImagePicker
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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_imageView release];
    [super dealloc];
}

- (IBAction)pickPhotoLibrary:(id)sender {
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
    }
    _imagePicker.delegate = self;
    _imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

- (IBAction)pickPhotoCamera:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        if (_imagePicker == nil) {
            _imagePicker = [[UIImagePickerController alloc] init];
        }
        _imagePicker.delegate = self;
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:_imagePicker animated:YES completion:nil];
    } else {
        
        NSLog(@"照相机不可用。");
    }
}


- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    _imagePicker.delegate = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    UIImage *originalImage = (UIImage *) [info objectForKey:
                                          UIImagePickerControllerOriginalImage];
    
    self.imageView.image = originalImage;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _imagePicker.delegate = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
