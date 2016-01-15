//
//  BaseTabbarViewController.h
//  Wavelet
//
//  Created by dlios on 15-7-3.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPTool.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "QCRound.h"
#import "PlayView.h"
#import "MainTabBaseView.h"
@interface BaseTabbarViewController : UIViewController
@property(nonatomic, retain)MainTabBaseView *tabView;
@end
