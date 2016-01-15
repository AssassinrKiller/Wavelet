//
//  SpecialListViewController.h
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BaseViewController.h"

@interface SpecialListViewController : BaseViewController

@property(nonatomic, copy)NSString *category_name;
@property(nonatomic, copy)NSString *ag_name;
@property(nonatomic,retain)NSArray *conditionArr;
@property(nonatomic,retain)NSArray *condNameArr;
@property(nonatomic, retain)NSString *titleName;
@end
