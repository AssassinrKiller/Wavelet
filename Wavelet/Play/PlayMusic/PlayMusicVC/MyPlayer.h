//
//  MyPlayer.h
//  Wavelet
//
//  Created by dlios on 15-7-3.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPlayer : AVPlayer

+(MyPlayer *)sharePlayer;

-(void)playMusicWithURL:(NSString *)url;
@end
