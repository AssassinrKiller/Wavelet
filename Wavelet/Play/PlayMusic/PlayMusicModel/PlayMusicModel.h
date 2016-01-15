//
//  PlayMusicModel.h
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BaseModel.h"

@interface PlayMusicModel : BaseModel

@property(nonatomic,copy)NSNumber * uid;
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString * smallLogo;
@property(nonatomic,copy)NSNumber * followers;
@property(nonatomic,copy)NSNumber * followings;
@property(nonatomic,copy)NSNumber * tracks;
@property(nonatomic,copy)NSNumber * albums;
@property(nonatomic,copy)NSString * ptitle;
@property(nonatomic,copy)NSString * personDescribe;

@end
