//
//  ViewController.m
//  MPMoviePlayerSample
//
//  Created by tonyguan on 14-1-7.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@property (nonatomic, strong) MPMoviePlayerViewController * moviePlayerView;
@property (nonatomic, strong) MPMoviePlayerController * moviePlayer;

- (IBAction)useMPMoviePlayerController:(id)sender;
- (IBAction)useMPMoviePlayerViewController:(id)sender;

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
}

-(NSURL *)movieURL
{
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *moviePath = [bundle pathForResource:@"YY"
                                           ofType:@"mp4"];
	if (moviePath) {
		return [NSURL fileURLWithPath:moviePath];
	} else {
		return nil;
	}
}

- (IBAction)useMPMoviePlayerController:(id)sender
{
    
    if (_moviePlayer == nil) {
        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[self movieURL]];
        _moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
        _moviePlayer.controlStyle = MPMovieControlStyleDefault;
        [self.view addSubview:_moviePlayer.view];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector: @selector(playbackFinished4MoviePlayerController:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(doneButtonClick:)
                                                     name:MPMoviePlayerWillExitFullscreenNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didActiveAirPlay:)
                                                     name:MPMoviePlayerIsAirPlayVideoActiveDidChangeNotification
                                                   object:nil];
    }
    
    [_moviePlayer play];
    [_moviePlayer setFullscreen:YES animated:YES];
    _moviePlayer.allowsAirPlay = YES;
}

- (IBAction)useMPMoviePlayerViewController:(id)sender
{
    if (_moviePlayerView == nil) {
        _moviePlayerView = [[MPMoviePlayerViewController alloc] initWithContentURL:[self movieURL]];
        _moviePlayerView.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
        _moviePlayerView.moviePlayer.controlStyle =	MPMovieControlStyleEmbedded;
        _moviePlayerView.moviePlayer.allowsAirPlay = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector: @selector(playbackFinished4MoviePlayerViewController:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
    }
    
    
    [self presentMoviePlayerViewControllerAnimated:_moviePlayerView];
}

- (void) playbackFinished4MoviePlayerController: (NSNotification*) notification
{
    NSLog(@"使用MPMoviePlayerController播放完成.");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_moviePlayer stop];
    [_moviePlayer.view removeFromSuperview];
    _moviePlayer = nil;
}

-(void)doneButtonClick:(NSNotification*)aNotification
{
    NSLog(@"退出全屏.");
    if (_moviePlayer.playbackState == MPMoviePlaybackStateStopped)
    {
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil;
    }
}

- (void) didActiveAirPlay: (NSNotification*) notification
{
    NSLog(@"AirPlay处于活动状态。");
}

- (void) playbackFinished4MoviePlayerViewController: (NSNotification*) notification
{
    NSLog(@"使用MPMoviePlayerViewController播放完成.");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_moviePlayerView dismissMoviePlayerViewControllerAnimated];
    _moviePlayerView = nil;
}

@end
