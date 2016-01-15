//
//  MyItemModel.h
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BaseModel.h"

@interface MyItemModel : BaseModel
@property(nonatomic,copy)NSString * tname;
@property(nonatomic,copy)NSString * cover_path;
@property(nonatomic,copy)NSNumber * category_id;
@end
