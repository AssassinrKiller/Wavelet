//
//  SpecialDetailViewController.h
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BaseViewController.h"
#import "SpecialListModel.h"

@interface SpecialDetailViewController : BaseViewController

@property(nonatomic,retain)SpecialListModel *specialMD;
@property(nonatomic, copy)NSString *bId;

@end
