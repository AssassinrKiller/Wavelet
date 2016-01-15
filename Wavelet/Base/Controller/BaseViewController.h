//
//  BaseViewController.h
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "HTTPTool.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "QCRound.h"
#import "TabBaseView.h"
#import "PlayView.h"
#import "AFNetworking.h"
@interface BaseViewController : UIViewController
@property(nonatomic, retain)TabBaseView *tabView;
@end
