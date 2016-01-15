//
//  FindFocusImages.h
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BaseModel.h"

@interface FindFocusImages : BaseModel
@property(nonatomic, copy)NSString *bId;
@property(nonatomic, copy)NSString *longTitle;
@property(nonatomic, retain)NSString *pic;
@property(nonatomic, copy)NSNumber *type;
@property(nonatomic, copy)NSNumber *trackId;
@property(nonatomic, copy)NSNumber *uid;
@end
