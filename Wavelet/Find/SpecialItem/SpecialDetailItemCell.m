//
//  SpecialDetailItemCell.m
//  Wavelet
//
//  Created by dllo on 15/7/8.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "SpecialDetailItemCell.h"

@implementation SpecialDetailItemCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.mainView = [[UIView alloc] init];
        [self.contentView addSubview:self.mainView];
        self.mainView.backgroundColor = [UIColor clearColor];
        [_mainView release];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:1];
        self.effect = [[UIVisualEffectView alloc] initWithEffect:blur];
        self.effect.alpha = 0.3;
        [self.mainView addSubview:self.effect];
        [_effect release];
        
        
        self.leftImageView = [[UIImageView alloc] init];
        [self.mainView addSubview:self.leftImageView];
        self.leftImageView.backgroundColor = [UIColor clearColor];
        [_leftImageView release];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.mainView addSubview:self.titleLabel];
        self.titleLabel.numberOfLines = 0;
        [self.titleLabel sizeToFit];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [_titleLabel release];
        
        self.playCountLabel = [[UILabel alloc] init];
        [self.mainView addSubview:self.playCountLabel];
        self.playCountLabel.textColor = [UIColor whiteColor];
        self.playCountLabel.backgroundColor = [UIColor clearColor];
        [_playCountLabel release];
        
        self.savebutton = [[UIButton alloc] init];
        self.savebutton.layer.borderWidth = 1;
        self.savebutton.layer.borderColor = [[UIColor orangeColor] CGColor];
        self.savebutton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.savebutton setTitle:@"☆收藏" forState: UIControlStateNormal];
        self.savebutton.tintColor = [UIColor orangeColor];
        [self.mainView addSubview:self.savebutton];
        [self.savebutton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//        self.savebutton.backgroundColor = [UIColor clearColor];
        

        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.mainView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height-15);
    self.effect.frame = self.mainView.frame;
    self.leftImageView.frame = CGRectMake(0, 0, self.mainView.frame.size.height, self.mainView.frame.size.height);
    self.titleLabel.frame =CGRectMake(self.mainView.frame.size.height+5, 5, self.contentView.frame.size.width-self.contentView.frame.size.height-7+5, 60);
    self.playCountLabel.frame = CGRectMake(self.mainView.frame.size.height +10 , self.mainView.frame.size.height-35, 120, 20);
    self.savebutton.frame = CGRectMake(self.contentView.frame.size.width-55, self.mainView.frame.size.height-30, 50, 20);
}

-(void)click:(UIButton *)button{
    NSLog(@"收藏");
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
