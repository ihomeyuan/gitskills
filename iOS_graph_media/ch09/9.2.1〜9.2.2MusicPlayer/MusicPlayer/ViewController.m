//
//  ViewController.m
//  MusicPlayer
//
//  Created by tonyguan on 14-1-10.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIButton *playButton;

@property (nonatomic, weak) IBOutlet UILabel *songTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *songArtistLabel;
@property (nonatomic, weak) IBOutlet UILabel *songAlbumLabel;
@property (nonatomic, weak) IBOutlet UIImageView *songArtworkView;

@property (strong,nonatomic) MPMusicPlayerController *iPodController;

- (IBAction)play:(id)sender;


- (IBAction)playPreviousSong:(id)sender;
- (IBAction)playNextSong:(id)sender;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    [self updateView:self.iPodController.nowPlayingItem];
}

- (IBAction)playNextSong:(id)sender {
    [self.iPodController skipToNextItem];
    [self updateView:self.iPodController.nowPlayingItem];
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

@end
