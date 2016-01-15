//
//  PlayMusicViewController.h
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BasePlayViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface PlayMusicViewController : BasePlayViewController

@property(nonatomic, copy)NSString *playAlbumId;

+(PlayMusicViewController *)sharePlayMusicVC;

//给AVPlayerItem添加播放完成的通知



-(void)addObserverToPlayerItem:(AVPlayerItem *)playerItem;
-(void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem;
@end
