//
//  CocoaAudioPlayerView.h
//  CocoaAudioPlayer
//
//  Created by Yongwei.Chen on 4/21/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CocoaAudioPlayerViewDelegate.h"

@interface CocoaAudioPlayerView : UIView

@property (nonatomic, weak) id <CocoaAudioPlayerViewDelegate> delegate;

@property (nonatomic, strong) NSURL *url;

-(void)play;

-(void)pause;

-(void)stop;

@end
