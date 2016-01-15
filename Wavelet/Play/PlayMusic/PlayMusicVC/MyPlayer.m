//
//  MyPlayer.m
//  Wavelet
//
//  Created by dlios on 15-7-3.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "MyPlayer.h"

@implementation MyPlayer

+(MyPlayer *)sharePlayer
{
    static MyPlayer * myplayer=nil;
    if (myplayer==nil) {
        myplayer=[[MyPlayer alloc] init];
    }
    return myplayer;
}
-(void)playMusicWithURL:(NSString *)url
{
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:url]];
    [self replaceCurrentItemWithPlayerItem:item];
    [self play];
}
@end
