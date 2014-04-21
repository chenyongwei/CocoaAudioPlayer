//
//  CocoaAudioPlayerViewDelegate.h
//  CocoaAudioPlayer
//
//  Created by Yongwei.Chen on 4/21/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CocoaAudioPlayerViewDelegate <NSObject>

@optional

-(void)audioPlayerViewDidStartPlay;

-(void)audioPlayerViewDidFinishPlay;

@end
