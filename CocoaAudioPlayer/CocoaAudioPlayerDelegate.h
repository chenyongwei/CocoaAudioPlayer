//
//  CocoaAudioPlayerDelegate.h
//  CocoaAudioPlayer
//
//  Created by Yongwei.Chen on 4/21/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AVAudioPlayer;

@protocol CocoaAudioPlayerDelegate <NSObject>

@optional

-(void)audioPlayerDidStartPlaying:(AVAudioPlayer *)player;

-(void)audioPlayerDidPausePlaying:(AVAudioPlayer *)player;

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player;

@end
