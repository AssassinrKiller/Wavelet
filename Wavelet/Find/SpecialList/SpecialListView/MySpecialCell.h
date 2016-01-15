//
//  MySpecialCell.h
//  Wavelet
//
//  Created by dllo on 15/6/29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MySpecialCell : BaseTableViewCell

//左图片
@property(nonatomic,retain)UIImageView *leftImageView;
//标题 Label
@property(nonatomic,retain)UILabel *titleLabel;
//观看人数 Label
@property(nonatomic,retain)UILabel *playCountLabel;
//当前时间
@property(nonatomic,retain)UILabel *TimeLabel;
//收藏 BUtton
@property(nonatomic,retain)UIButton *saveButton;

@property(nonatomic,retain)UIView *mainView;

@property(nonatomic, retain)UIVisualEffectView *effect;




@end
