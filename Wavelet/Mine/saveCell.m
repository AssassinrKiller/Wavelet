//
//  saveCell.m
//  Wavelet
//
//  Created by dllo on 15/7/14.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "saveCell.h"

@implementation saveCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.mainView = [[UIView alloc] init];
        [self.contentView addSubview:self.mainView];
//        self.mainView.backgroundColor = [UIColor orangeColor];
        [self.mainView release];
        
        self.leftImageView = [[UIImageView alloc] init];
//        self.leftImageView.backgroundColor = [UIColor redColor];
        [self.mainView addSubview:self.leftImageView];
        [self.leftImageView release];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 0;
        
        [self.mainView addSubview:self.titleLabel];
//        self.titleLabel.backgroundColor = [UIColor redColor];
        [self.titleLabel  release];
        
        self.tracksLabel = [[UILabel alloc] init];
        [self.mainView addSubview:self.tracksLabel];
//        self.tracksLabel.backgroundColor = [UIColor blueColor];
        self.tracksLabel.font = [UIFont systemFontOfSize:13];
        [self.tracksLabel release];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.mainView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height-5);
    self.leftImageView.frame = CGRectMake(5, 5, self.contentView.frame.size.height-10, self.contentView.frame.size.height-10);
    self.titleLabel.frame = CGRectMake(75, 5, 250, 35);
    self.tracksLabel.frame = CGRectMake(75, 50, 200, 15);
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
