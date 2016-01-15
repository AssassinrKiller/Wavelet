//
//  releteDeCell.m
//  Wavelet
//
//  Created by dllo on 15/7/2.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "releteDeCell.h"

@implementation releteDeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor =[UIColor clearColor];
        self.mainView = [[UIView alloc] init];
        [self.contentView addSubview:self.mainView];
        self.mainView.backgroundColor = [UIColor clearColor];
        [self.mainView release];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:1];
        self.effect = [[UIVisualEffectView alloc] initWithEffect:blur];
        self.effect.alpha = 0.3;
        [self.mainView addSubview:self.effect];
        
        
        
        self.leftImageView = [[UIImageView alloc] init];
        [self.mainView addSubview:self.leftImageView];
        self.leftImageView.backgroundColor = [UIColor clearColor];
        [self.leftImageView release];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.mainView addSubview:self.titleLabel];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.backgroundColor  =[UIColor clearColor];
        [self.titleLabel release];
        
        
        self.chanelLabel = [[UILabel alloc] init];
        [self.mainView addSubview:self.chanelLabel];
        self.chanelLabel.textColor = [UIColor whiteColor];
        self.chanelLabel.font = [UIFont systemFontOfSize:13];
        self.chanelLabel.backgroundColor = [UIColor clearColor];
        [self.chanelLabel release];
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.mainView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height-10);
    self.effect.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
    self.leftImageView .frame = CGRectMake(10, 10, 50, 50);
    self.titleLabel.frame = CGRectMake(70, 10, 200, 20);
    self.chanelLabel.frame = CGRectMake(70, 40, 100, 15);
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
