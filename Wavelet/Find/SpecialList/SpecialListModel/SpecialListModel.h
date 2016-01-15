//
//  SpecialListModel.h
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BaseModel.h"

@interface SpecialListModel : BaseModel

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *coverMiddle;
@property(nonatomic,copy)NSString *playsCounts;
@property(nonatomic,copy)NSString *bId;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *albumId;
@property(nonatomic,copy)NSString *intro;
@property(nonatomic,copy)NSString *tags;
@property(nonatomic,copy)NSString *coverSmall;
@property(nonatomic,assign)NSInteger tracks;




@end
