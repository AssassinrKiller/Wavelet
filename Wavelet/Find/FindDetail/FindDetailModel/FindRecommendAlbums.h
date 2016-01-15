//
//  FindRecommendAlbums.h
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BaseModel.h"

@interface FindRecommendAlbums : BaseModel
@property(nonatomic, copy)NSString *bId;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *coverSmall;
@property(nonatomic, copy)NSNumber *playsCounts;
@end
