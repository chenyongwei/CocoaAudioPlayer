//
//  CocoaAudioPlayer.m
//  CocoaAudioPlayer
//
//  Created by Yongwei.Chen on 4/21/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "CocoaAudioPlayer.h"

@interface CocoaAudioPlayer() <AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSURL *url;

@end

@implementation CocoaAudioPlayer


-(void)dealloc
{
    //
}


+(instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance setupAudioSession];
    }
                  
                  
                  );
    
    return sharedInstance;
}

#pragma mark - Audio Session

-(void)setupAudioSession
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // Remove notification listener before reset
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionRouteChangeNotification object:session];
    
    // Set the audioSession category.
    // Needs to be Record or PlayAndRecord to use audioRouteOverride:
    NSError *error;
    
    [session setCategory:AVAudioSessionCategoryPlayAndRecord
             withOptions:AVAudioSessionCategoryOptionAllowBluetooth
                   error:&error];
    
    // Add notification listener
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onAudioSessionRouteChange:)
                                                 name:AVAudioSessionRouteChangeNotification
                                               object:session];
    
    // Force notification once for the first time coming
    [self onAudioSessionRouteChange:nil];
}


-(void)onAudioSessionRouteChange:(NSNotification *)notification
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    AVAudioSessionPortDescription *output = [[session.currentRoute.outputs count] ? session.currentRoute.outputs: nil firstObject];
    
    // Error handling
    BOOL success;
    NSError *error;
    
    // If port type is Receiver, it should be forward as speaker
    if ([output.portType isEqualToString:AVAudioSessionPortBuiltInReceiver])
    {
        // Set the audioSession override
        success = [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
        if (!success)
        {
            NSLog(@"!!!The new routing option was not set successfully");
        }
    }
}


#pragma mark - Audio Player

-(void)playUrl:(NSURL *)url
{
    if (![self.url.absoluteString isEqualToString:url.absoluteString])
    {
        self.url = url;
        NSError *activationError = nil;
        [[AVAudioSession sharedInstance] setActive:YES error:&activationError];
        
        if (self.audioPlayer && self.audioPlayer.isPlaying)
        {
            // stop the previous one first.
            [self stop];
        }
        
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer setVolume:1.0];
        [self.audioPlayer setDelegate:self];
    }
    
    [self.audioPlayer play];
//    // Notifiy others about the current playing url
//    [[NSNotificationCenter defaultCenter] postNotificationName:EFMediaDidStartPlayNotification object:url];
    if ([self.delegate respondsToSelector:@selector(audioPlayerDidStartPlaying:)]) {
       [self.delegate audioPlayerDidStartPlaying:self.audioPlayer];
    }
}


-(void)pause
{
    [self.audioPlayer pause];
    [self.delegate audioPlayerDidPausePlaying:self.audioPlayer];
}


-(void)stop
{
    [self.audioPlayer setCurrentTime:0];
    [self.audioPlayer stop];
    // manually stop will not fire the AVAudioPlayerDelegate "(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag"
    [self.delegate audioPlayerDidFinishPlaying:self.audioPlayer];
}




@end
