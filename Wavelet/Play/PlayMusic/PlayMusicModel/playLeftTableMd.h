//
//  playLeftTableMd.h
//  Wavelet
//
//  Created by dlios on 15-7-1.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BaseModel.h"

@interface playLeftTableMd : BaseModel

@property(nonatomic,copy)NSString * trackId;
@property(nonatomic,copy)NSString * playUrl64;
@property(nonatomic,copy)NSString * playUrl32;
@property(nonatomic,copy)NSString * downloadUrl;
@property(nonatomic,copy)NSString * playPathAacv164;
@property(nonatomic,copy)NSString * playPathAacv224;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSNumber * duration;

@end
