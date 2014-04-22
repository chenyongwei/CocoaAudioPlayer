//
//  ViewController.m
//  CocoaAudioPlayerDemo
//
//  Created by Yongwei.Chen on 4/21/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import "ViewController.h"
#import "CocoaAudioPlayerView.h"

@interface ViewController () <CocoaAudioPlayerViewDelegate>

@property (nonatomic, strong) IBOutlet CocoaAudioPlayerView *audioPlayer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.audioPlayer.backgroundColor = [UIColor clearColor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"audio1" ofType:@"mp3" inDirectory:@"content"];
    self.audioPlayer.delegate = self;
    [self.audioPlayer setUrl:[NSURL fileURLWithPath:path]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)audioPlayerViewDidStartPlay
{
    NSLog(@"audioPlayerViewDidStartPlay");
}

-(void)audioPlayerViewDidFinishPlay
{
    NSLog(@"audioPlayerViewDidFinishPlay");
}


@end
