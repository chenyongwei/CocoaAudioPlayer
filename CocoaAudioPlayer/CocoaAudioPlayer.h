//
//  CocoaAudioPlayer.h
//  CocoaAudioPlayer
//
//  Created by Yongwei.Chen on 4/21/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CocoaAudioPlayerDelegate.h"

@class AVAudioPlayer;

@interface CocoaAudioPlayer : NSObject

@property (nonatomic, weak) id <CocoaAudioPlayerDelegate> delegate;

+(instancetype)sharedInstance;

-(void)playUrl:(NSURL *)url;

-(void)pause;

-(void)stop;

@end
