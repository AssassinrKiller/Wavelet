//
//  SpecialDetailModel.h
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BaseModel.h"

@interface SpecialDetailModel : BaseModel
//headview 小图片
@property(nonatomic,copy)NSString *avatarPath;
@property(nonatomic,copy)NSString *coverSmall;
@property(nonatomic,copy)NSString *coverLarge;
@property(nonatomic,copy)NSString *tracks;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *playUrl64;
@property(nonatomic,copy)NSString *tags;
@property(nonatomic,copy)NSString *playtimes;
@property(nonatomic,copy)NSString *likes;
@property(nonatomic,copy)NSString *comments;
@property(nonatomic,copy)NSString *smallLogo;
@property(nonatomic,copy)NSString *albumId;
@property(nonatomic,copy)NSString *downloadUrl;
@property(nonatomic,copy)NSString *downloadAacUrl;
@property(nonatomic,copy)NSNumber *downloadSize;
@property(nonatomic,copy)NSNumber *downloadAacSize;
@end
