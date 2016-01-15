//
//  specialDetailCell.h
//  Wavelet
//
//  Created by dllo on 15/7/1.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface specialDetailCell : UITableViewCell
@property(nonatomic, retain)UIVisualEffectView *effect;
@property(nonatomic,retain)UIView *backView;
@property(nonatomic,retain)UIImageView *leftImageView;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *midLabel;
@property(nonatomic,retain)UILabel *playCountLabel;
@property(nonatomic,retain)UILabel *likeLavel;
@property(nonatomic,retain)UIImageView *comImageView;
@property(nonatomic,retain)UILabel *commentsLabel;
@property(nonatomic,retain)UIButton *downLoadView;

@end
