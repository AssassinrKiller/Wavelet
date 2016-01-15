//
//  albumTableViewCell.m
//  Wavelet
//
//  Created by dlios on 15-7-8.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "albumTableViewCell.h"

@implementation albumTableViewCell
-(void)dealloc
{
    [_delectButton release];
    [_detailLabel release];
    [_titleLabel release];
    [_imageview release];
    [super dealloc];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageview=[[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
        [_imageview release];
        self.detailLabel=[[UILabel alloc] init];
        [self.contentView addSubview:self.detailLabel];
        [_detailLabel release];
        self.titleLabel=[[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        [_titleLabel release];
        self.delectButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.delectButton];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageview.frame=CGRectMake(10, 5,40, self.contentView.frame.size.height-10);
    self.imageview.layer.borderWidth=1;
    self.detailLabel.layer.borderWidth=1;
    self.titleLabel.layer.borderWidth=1;
    self.delectButton.layer.borderWidth=1;
    self.titleLabel.frame=CGRectMake(60, 5, self.contentView.frame.size.width/2, 30);
    self.detailLabel.frame=CGRectMake(60, 40, 100, 20);
    self.delectButton.frame=CGRectMake(0, 0, 25, 25);
    self.delectButton.center=CGPointMake(self.contentView.frame.size.width*5/6, self.contentView.frame.size.height/2);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
