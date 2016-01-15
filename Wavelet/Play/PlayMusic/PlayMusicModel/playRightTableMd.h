//
//  playRightTableMd.h
//  Wavelet
//
//  Created by dlios on 15-7-2.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BaseModel.h"

@interface playRightTableMd : BaseModel
@property(nonatomic,copy)NSNumber * albumId;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * coverSmall;
@property(nonatomic,copy)NSString * coverMiddle;
@property(nonatomic,copy)NSNumber * updatedAt;
@property(nonatomic,copy)NSNumber * playsCounts;
@property(nonatomic,copy)NSNumber * tracks;
@property(nonatomic,copy)NSNumber * uid;
@property(nonatomic,copy)NSString * recSrc;
@property(nonatomic,copy)NSString * recTrack;
@property(nonatomic,copy)NSString * intro;
@end
