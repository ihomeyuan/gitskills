//
//  ViewController.m
//  SpeechSynthesis
//
//  Created by tonyguan on 14-1-6.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
    <AVSpeechSynthesizerDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (nonatomic, strong) AVSpeechSynthesizer *speechSynthesizer;

- (IBAction)speakButtonWasPressed:(id)sender;

- (IBAction)speechSpeedShouldChange:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //为TextView
    [self.textView.layer setBorderWidth:.5f];
    [self.textView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.textView setDelegate:self];
    
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    self.speechSynthesizer.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    BOOL retval = TRUE;
    
    if([text isEqualToString:@"\n"]){
        [self.textView resignFirstResponder];
        retval = FALSE;
    }
    
    return retval;
    
}

- (IBAction)speakButtonWasPressed:(id)sender {
    
    AVSpeechUtterance *utt = [AVSpeechUtterance speechUtteranceWithString:[self.textView text]];
    utt.rate = [self.slider value];
    [self.speechSynthesizer speakUtterance:utt];
}


- (IBAction)speechSpeedShouldChange:(id)sender {
    UISlider *slider = (UISlider *)sender;
    NSInteger val = round(slider.value);
    NSLog(@"%@",[NSString stringWithFormat:@"%ld",(long)val]);
}

#pragma mark--AVSpeechSynthesizerDelegate
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer
    didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"语音合成开始。");
}


- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer
    didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"语音合成完成。");
}



@end
