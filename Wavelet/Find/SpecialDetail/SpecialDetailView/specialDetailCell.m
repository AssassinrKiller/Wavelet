//
//  specialDetailCell.m
//  Wavelet
//
//  Created by dllo on 15/7/1.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "specialDetailCell.h"

@implementation specialDetailCell

-(void)dealloc{
    [_leftImageView release];
    [_midLabel release];
    [_titleLabel release];
    [_playCountLabel release];
    [_likeLavel release];
    [_commentsLabel release];
    [_downLoadView release];
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
        self.backView = [[UIView alloc] init];
        self.backView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.backView];
        [_backView release];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:1];
        self.effect = [[UIVisualEffectView alloc] initWithEffect:blur];
        self.effect.alpha = 0.3;
        [self.backView addSubview:self.effect];
        
        self.leftImageView = [[UIImageView alloc] init];
        [self.backView addSubview:self.leftImageView];
        self.leftImageView.backgroundColor = [UIColor clearColor];
        self.leftImageView.layer.cornerRadius = 40;
        self.leftImageView.layer.masksToBounds = YES;
        
        [_leftImageView release];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.backView addSubview:self.titleLabel];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        [_titleLabel release];
        
        self.midLabel = [[UILabel alloc] init];
        [self.backView addSubview:self.midLabel];
        self.midLabel.backgroundColor = [UIColor clearColor];
        self.midLabel.textColor = [UIColor whiteColor];
        [_midLabel release];
        
        self.playCountLabel = [[UILabel alloc] init];
        [self.backView addSubview:self.playCountLabel];
        self.playCountLabel.backgroundColor = [UIColor clearColor];
        self.playCountLabel.textColor = [UIColor whiteColor];
        self.playCountLabel.font = [UIFont systemFontOfSize:12];
        [_playCountLabel release];
        
        self.likeLavel = [[UILabel alloc] init];
        [self.backView addSubview:self.likeLavel];
        self.likeLavel.backgroundColor = [UIColor clearColor];
        self.likeLavel.textColor = [UIColor whiteColor];
        self.likeLavel.font = [UIFont systemFontOfSize:12];
        [_likeLavel release];
        
        self.comImageView = [[UIImageView alloc] init];
        [self.backView addSubview:self.comImageView];
        self.comImageView.backgroundColor = [UIColor clearColor];
        [_comImageView release];
        
        
        self.commentsLabel = [[UILabel alloc] init];
        [self.backView addSubview:self.commentsLabel];
        self.commentsLabel.backgroundColor = [UIColor clearColor];
        self.commentsLabel.textColor = [UIColor whiteColor];
        self.commentsLabel.font = [UIFont systemFontOfSize:12];
        [_commentsLabel release];
        
        self.downLoadView = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.backView addSubview:self.downLoadView];
        
        self.backView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.backView.frame = CGRectMake(0, 10, self.contentView.frame.size.width, 100);
    self.effect.frame = CGRectMake(0, 0, self.backView.frame.size.width, self.backView.frame.size.height);
    
    self.leftImageView.frame = CGRectMake(10, 10, self.backView.frame.size.height - 20, self.backView.frame.size.height-20);
    self.titleLabel.frame = CGRectMake(95, 15, 250, 30);
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.numberOfLines = 2;
    [self.titleLabel sizeToFit];
    
    self.midLabel.frame = CGRectMake(97, self.titleLabel.frame.size.height + 15, 170, 20);
    self.midLabel.font = [UIFont systemFontOfSize:12];
    
    
    self.playCountLabel.frame = CGRectMake(95, 70, 60, 20);
    
    self.likeLavel.frame = CGRectMake(160, 70, 60, 20);
    
    self.comImageView.frame =CGRectMake(230, 73, 15, 15);
    self.commentsLabel.frame = CGRectMake(250, 70, 40, 20);
    self.downLoadView.frame = CGRectMake(340, 55, 20, 20);
    [self.downLoadView setImage:[UIImage imageNamed:@"iconfont-xiazai-2.png"] forState:UIControlStateNormal];
}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
