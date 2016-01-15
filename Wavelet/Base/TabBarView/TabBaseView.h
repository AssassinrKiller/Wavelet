//
//  TabBaseView.h
//  Wavelet
//
//  Created by dlios on 15-7-2.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayView.h"
@interface TabBaseView : UIView
- (instancetype)initWithFrame:(CGRect)frame
                       withVC:(UINavigationController *)VC;
@end
