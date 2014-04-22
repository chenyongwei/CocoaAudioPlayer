//
//  CocoaAudioPlayerView.m
//  CocoaAudioPlayer
//
//  Created by Yongwei.Chen on 4/21/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import "CocoaAudioPlayerView.h"
#import "CocoaAudioPlayer.h"
#import "CocoaAudioPlayerDelegate.h"
#import "CocoaAudioPlayerViewState.h"
#import "FAKFontAwesome.h"

@interface CocoaAudioPlayerView() <CocoaAudioPlayerDelegate>

@property (nonatomic, strong) CocoaAudioPlayer *audioPlayer;

@property (nonatomic, strong) UIButton *defaultButton;
@property (nonatomic, strong) UIButton *playingButton;

@property (nonatomic) CocoaAudioPlayerViewState viewState;

@end

@implementation CocoaAudioPlayerView

#pragma mark - Setup

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.audioPlayer = [CocoaAudioPlayer sharedInstance];
        [self setupPlayerUI:CocoaAudioPlayerViewStateDefault];
    }
    
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.audioPlayer = [CocoaAudioPlayer sharedInstance];
        [self setupPlayerUI:CocoaAudioPlayerViewStateDefault];
    }
    
    return self;
}


#pragma mark - Audio handling

-(void)play
{
    [self.audioPlayer playUrl:self.url];
    [self setupPlayerUI:CocoaAudioPlayerViewStatePlaying];
    [self.audioPlayer setDelegate:self];
    if ([self.delegate respondsToSelector:@selector(audioPlayerViewDidStartPlay)])
    {
        [self.delegate audioPlayerViewDidStartPlay];
    }
}


-(void)pause
{
    [self.audioPlayer pause];
}


-(void)stop
{
    [self.audioPlayer stop];
}


-(void)setupPlayerUI:(CocoaAudioPlayerViewState)playViewState
{
    if (self.viewState == 0)
    {
        self.defaultButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        FAKFontAwesome *playIcon = [FAKFontAwesome playIconWithSize:35];
        [playIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];
        UIImage *playIconImage = [playIcon imageWithSize:CGSizeMake(35, 35)];
        [self.defaultButton setImage:playIconImage forState:UIControlStateNormal];
        [self addSubview:self.defaultButton];
        
        self.playingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        FAKFontAwesome *stopIcon = [FAKFontAwesome pauseIconWithSize:35];
        [stopIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];
        UIImage *stopIconImage = [stopIcon imageWithSize:CGSizeMake(35, 35)];
        [self.playingButton setImage:stopIconImage forState:UIControlStateNormal];
        [self addSubview:self.playingButton];
    }
    
    if (self.viewState == playViewState)
    {
        return;
    }
    
    [self.defaultButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
    [self.playingButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
    
    switch (playViewState)
    {
        case CocoaAudioPlayerViewStateDefault:
            [self.defaultButton setHidden:NO];
            [self.defaultButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
            [self.playingButton setHidden:YES];
            break;
            
        case CocoaAudioPlayerViewStatePlaying:
            [self.defaultButton setHidden:YES];
            [self.playingButton setHidden:NO];
            [self.playingButton addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        default:
            break;
    }
    
    self.viewState = playViewState;
}



#pragma mark - Delegate

-(void)audioPlayerDidPausePlaying:(AVAudioPlayer *)player
{
    [self setupPlayerUI:CocoaAudioPlayerViewStateDefault];
}


-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
{
    [self setupPlayerUI:CocoaAudioPlayerViewStateDefault];
    
    if ([self.delegate respondsToSelector:@selector(audioPlayerViewDidFinishPlay)])
    {
        [self.delegate audioPlayerViewDidFinishPlay];
    }
}


@end
