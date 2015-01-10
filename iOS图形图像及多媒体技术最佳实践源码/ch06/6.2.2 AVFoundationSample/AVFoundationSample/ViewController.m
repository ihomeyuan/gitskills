//
//  ViewController.m
//  AVFoundationSample
//
//  Created by tonyguan on 14-1-8.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
{
    id timeObserver;
    BOOL isPlaying;
    
}

- (IBAction)play:(id)sender;
- (IBAction)seek:(id)sender;

@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@property (nonatomic,weak) AVPlayer *avPlayer;
@property (nonatomic,weak) AVPlayerLayer *layer;
@property (nonatomic,strong) AVPlayerItem *playerItem;

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"YY" ofType:@"mp4"];
    NSURL *fileURL = [NSURL fileURLWithPath:filepath];
    
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
    self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
    
    self.avPlayer = [AVPlayer playerWithPlayerItem: self.playerItem ];

    self.layer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    
    float scale = 1.776;
    
    self.layer.frame = CGRectMake(0, -350,
                                  self.view.frame.size.width * scale,
                                  self.view.frame.size.height * scale);
    
    [self.view.layer insertSublayer:self.layer atIndex:0];
    
    double duration = CMTimeGetSeconds(asset.duration);
    
    self.slider.maximumValue =  duration;
    self.slider.minimumValue  = 0.0;
    
    isPlaying = NO;
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)play:(id)sender {
    
    UIBarButtonItem *item1;
    
    if (!isPlaying) {
        
        [self addObserver];
        [self.avPlayer seekToTime:kCMTimeZero];
        [self.avPlayer play];
        
        isPlaying = YES;
        item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause
                                                              target:self
                                                              action:@selector(play:)];
        
        
    } else  {
        isPlaying = NO;
        item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                              target:self
                                                              action:@selector(play:)];
        
        [self.avPlayer pause];
    }
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:[self.toolBar items]];
    [items replaceObjectAtIndex:0 withObject:item1];
    
    [self.toolBar setItems:items];

    
}

- (IBAction)seek:(id)sender {
    float value = [self.slider value];
    [self.avPlayer seekToTime:CMTimeMakeWithSeconds(value, 10)];
}


-(void)addObserver{
    
    if (timeObserver == nil) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerItemDidReachEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:self.playerItem];
        
        timeObserver = [self.avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 10)
                                                                   queue:dispatch_get_main_queue()
                                                              usingBlock:^(CMTime time) {
                                                                  float duration = CMTimeGetSeconds(self.avPlayer.currentTime);
                                                                  NSLog(@"duration = %f",duration);
                                                                  self.slider.value = duration;
                                                              }
                        ];
        
    }
    
}


- (void) playerItemDidReachEnd:(NSNotification*) aNotification
{
    NSLog(@"播放完成");
    if (timeObserver) {
        [self.avPlayer removeTimeObserver:timeObserver];
        
        timeObserver = nil;
        self.slider.value = 0.0;
        isPlaying = NO;
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AVPlayerItemDidPlayToEndTimeNotification
                                                      object:nil];
        
        
        UIBarButtonItem* item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                                               target:self
                                                                               action:@selector(play:)];
        
        
        
        
        
        
        NSMutableArray *items = [[NSMutableArray alloc] initWithArray:[self.toolBar items]];
        [items replaceObjectAtIndex:0 withObject:item1];
        
        [self.toolBar setItems:items];
    }
    
}


@end
