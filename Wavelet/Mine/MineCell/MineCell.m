//
//  MineCell.m
//  Wavelet
//
//  Created by dlios on 15-7-3.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//
#define CellWidth self.frame.size.width
#define CellHeight self.frame.size.height
#import "MineCell.h"

@implementation MineCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.picView = [[UIImageView alloc] init];
        [self addSubview:self.picView];
        [_picView release];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:1];
        self.effect = [[UIVisualEffectView alloc] initWithEffect:blur];
        self.effect.alpha = 0.2;
        [self addSubview:self.effect];
        
        self.mineLabel = [[UILabel alloc] init];
        self.mineLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.mineLabel];
        [_mineLabel release];
        
        self.mineDetailLabel = [[UILabel alloc] init];
        self.mineDetailLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.mineDetailLabel];
        [_mineDetailLabel release];
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return  self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.picView.frame = CGRectMake(CellHeight / 4, CellHeight / 4, CellHeight / 2, CellHeight / 2);
    self.effect.frame = CGRectMake(0, 5, self.frame.size.width, self.frame.size.height - 5);
    
    self.mineLabel.frame = CGRectMake(CellHeight, CellHeight / 3, 0, CellHeight / 3);
    [self.mineLabel sizeToFit];
    
    self.mineDetailLabel.frame = CGRectMake(CellWidth - CellHeight / 2, 0, CellHeight / 2, CellHeight);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
