//
//  MySpecialCell.m
//  Wavelet
//
//  Created by dllo on 15/6/29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MySpecialCell.h"

@implementation MySpecialCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.mainView = [[UIView alloc] init];
        [self.mainView release];
        [self.contentView addSubview:self.mainView];
        self.mainView.backgroundColor = [UIColor clearColor];
        [self.mainView release];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:1];
        self.effect = [[UIVisualEffectView alloc] initWithEffect:blur];
        self.effect.alpha = 0.2;
        [self.mainView addSubview:self.effect];
        
        self.leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhanweitu"]];
        [self.mainView addSubview:self.leftImageView];
        [self.leftImageView release];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica- Bold" size:15];
        [self.mainView addSubview:self.titleLabel];
        [_titleLabel release];
        
        self.playCountLabel = [[UILabel alloc] init];
        self.playCountLabel.backgroundColor = [UIColor clearColor];
        self.playCountLabel.textColor = [UIColor whiteColor];
        self.playCountLabel.font = [UIFont systemFontOfSize:13];
        [self.mainView addSubview:self.playCountLabel];
        [_playCountLabel release];
        
        self.TimeLabel = [[UILabel alloc] init];
        self.TimeLabel.backgroundColor = [UIColor clearColor];
        self.TimeLabel.textColor = [UIColor whiteColor];
        [self.mainView addSubview:self.TimeLabel];
        self.TimeLabel.font = [UIFont systemFontOfSize:6];
        [_TimeLabel release];
        
        self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.mainView addSubview:self.saveButton];
        self.saveButton.layer.borderWidth = 1;
        self.saveButton.tintColor = [UIColor orangeColor];
        self.saveButton.layer.borderColor = [[UIColor orangeColor] CGColor];
        self.saveButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.saveButton setTitle:@"☆收藏" forState: UIControlStateNormal];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
     self.mainView.frame = CGRectMake(10, 0, self.contentView.frame.size.width - 20, self.contentView.frame.size.height-20);
    self.leftImageView.frame = CGRectMake(0, 0, self.mainView.frame.size.height, self.mainView.frame.size.height);
    self.titleLabel.frame = CGRectMake(self.mainView.frame.size.height + 10, 10, self.mainView.frame.size.width-self.mainView.frame.size.height - 10, 30);
    self.playCountLabel.frame = CGRectMake(self.mainView.frame.size.height + 10, self.mainView.frame.size.height / 2 + 10, 120, 25);
//    self.TimeLabel.frame =CGRectMake(130, 100, 200, 20);
    self.saveButton.frame = CGRectMake(self.mainView.frame.size.width - 70, self.mainView.frame.size.height / 2 + 13, 50, 20);
    self.effect.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
}








- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
