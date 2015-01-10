//
//  ViewController.m
//  MusicPlayer
//
//  Created by tonyguan on 14-1-10.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController () <MPMediaPickerControllerDelegate>

@property (nonatomic, weak) IBOutlet UIButton *playButton;

@property (nonatomic, weak) IBOutlet UILabel *songTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *songArtistLabel;
@property (nonatomic, weak) IBOutlet UILabel *songAlbumLabel;
@property (nonatomic, weak) IBOutlet UIImageView *songArtworkView;

@property (strong,nonatomic) MPMusicPlayerController *iPodController;

@property (nonatomic, strong) MPMediaItemCollection *itemCollection;

- (IBAction)selectSong:(id)sender;


- (IBAction)play:(id)sender;


- (IBAction)playPreviousSong:(id)sender;
- (IBAction)playNextSong:(id)sender;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.iPodController setQueueWithItemCollection:self.itemCollection];
    
    self.songArtworkView.image = [UIImage imageNamed:@"cover.png"];
    self.iPodController = [MPMusicPlayerController iPodMusicPlayer];
}



-(void)viewWillAppear:(BOOL)animated
{
	
    if (self.iPodController.playbackState == MPMusicPlaybackStatePlaying) {
        [self.playButton setTitle:@"暂停" forState:UIControlStateNormal];
	} else {
        [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
	}
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(musicPlayerStateChanged:)
     name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
     object:self.iPodController];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(nowPlayingItemIsChanged:)
     name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
     object:self.iPodController];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(volumeChanged:)
     name:MPMusicPlayerControllerVolumeDidChangeNotification
     object:self.iPodController];
    
    [self.iPodController beginGeneratingPlaybackNotifications];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
     object:self.iPodController];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
     object:self.iPodController];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMusicPlayerControllerVolumeDidChangeNotification
     object:self.iPodController];
    
    [self.iPodController endGeneratingPlaybackNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (IBAction)play:(id)sender {
    
	MPMediaItem *nowPlayingItem= [self.iPodController nowPlayingItem];
	NSLog (@"%@", nowPlayingItem);
    if (nowPlayingItem == nil) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请先在音乐应用中选择播放一首曲目。"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles: nil];
        [alertView show];
        return;
    } else {
        [self updateView:nowPlayingItem];
    }
    
    [self.iPodController setQueueWithItemCollection:self.itemCollection];
    
    if (self.iPodController.playbackState == MPMusicPlaybackStatePlaying) {
		[self.iPodController pause];
        [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
        
	} else {
		[self.iPodController play];
        [self.playButton setTitle:@"暂停" forState:UIControlStateNormal];
        
	}
}

- (IBAction)playPreviousSong:(id)sender {
    [self.iPodController skipToPreviousItem];
}

- (IBAction)playNextSong:(id)sender {
    [self.iPodController skipToNextItem];
}

-(void) updateView:(MPMediaItem*)nowPlayingItem{
    
    self.songTitleLabel.text = [nowPlayingItem valueForProperty:MPMediaItemPropertyTitle];
    self.songArtistLabel.text = [nowPlayingItem valueForProperty:MPMediaItemPropertyArtist];
    self.songAlbumLabel.text = [nowPlayingItem valueForProperty:MPMediaItemPropertyAlbumTitle];
    MPMediaItemArtwork *coverArt = [nowPlayingItem valueForProperty:MPMediaItemPropertyArtwork];
    
    self.songArtworkView.image = [UIImage imageNamed:@"cover.png"];
    
    
    if (coverArt) {
        CGSize imageSize = {100.0, 100.0};
        UIImage *image = [coverArt imageWithSize:imageSize];
        if (image) {
            self.songArtworkView.image = image ;
        }
    }
}

#pragma mark --通知方法

- (void) musicPlayerStateChanged:(NSNotification *)paramNotification{
    
    NSLog(@"播放状态变化。");
    
    //获得播放状态
    NSNumber *stateAsObject = [paramNotification.userInfo
                               objectForKey:@"MPMusicPlayerControllerPlaybackStateKey"];
    
    NSInteger state = [stateAsObject integerValue];
    
    switch (state){
        case MPMusicPlaybackStateStopped:{
            NSLog(@"MPMusicPlaybackStateStopped");
            break;
        }
        case MPMusicPlaybackStatePlaying:{
            NSLog(@"MPMusicPlaybackStatePlaying");
            break;
        }
        case MPMusicPlaybackStatePaused:{
            NSLog(@"MPMusicPlaybackStatePaused");
            break;
        }
        case MPMusicPlaybackStateInterrupted:{
            NSLog(@"MPMusicPlaybackStateInterrupted");
            break;
        }
        case MPMusicPlaybackStateSeekingForward:{
            NSLog(@"MPMusicPlaybackStateSeekingForward");
            break;
        }
        case MPMusicPlaybackStateSeekingBackward:{
            NSLog(@"MPMusicPlaybackStateSeekingBackward");
            break;
        }
    }
    
}
- (void) nowPlayingItemIsChanged:(NSNotification *)paramNotification{
    [self updateView:self.iPodController.nowPlayingItem];
}

- (void) volumeChanged:(NSNotification *)paramNotification{
    NSLog(@"音量变化。");
}


- (IBAction)selectSong:(id)sender {
    
    MPMediaPickerController *picker = [[MPMediaPickerController alloc]
                                       initWithMediaTypes:MPMediaTypeMusic];
    picker.delegate = self;
    [picker setAllowsPickingMultipleItems:YES];
    picker.prompt = @"请选择播放歌曲列表。";
    [self presentViewController:picker animated:YES completion:NULL];
}


#pragma mark --MPMediaPickerControllerDelegate委托方法实现
- (void)mediaPicker: (MPMediaPickerController *)mediaPicker
  didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    self.itemCollection = mediaItemCollection;
    if ([mediaItemCollection count] > 0) {
        self.playButton.enabled = YES;
    } else {
        self.playButton.enabled = NO;
    }
}


- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
