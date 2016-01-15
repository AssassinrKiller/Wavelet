//
//  playTableCell.m
//  Wavelet
//
//  Created by dlios on 15-7-2.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "playTableCell.h"

@implementation playTableCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.logoView=[[UIImageView alloc] init];
        [self.contentView addSubview:self.logoView];
        [_logoView release];
        self.focusButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.focusButton];
        self.nikname=[[UILabel alloc] init];
        [self.contentView addSubview:self.nikname];
        [_nikname release];
        self.personAndTitle=[[UILabel alloc] init];
        [self.contentView addSubview:self.personAndTitle];
        [_personAndTitle release];
        self.soundAndfans=[[UILabel alloc] init];
        [self.contentView addSubview:self.soundAndfans];
        [_soundAndfans release];
    }
    return self;

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.logoView.frame=CGRectMake(10,5,90, self.contentView.frame.size.height-10);
    self.logoView.layer.borderWidth=1;
    self.logoView.layer.cornerRadius=45;
    self.nikname.frame=CGRectMake(100, 5, 100, 30);
    self.soundAndfans.frame=CGRectMake(100, 35, 150, 30);
    self.personAndTitle.frame=CGRectMake(100, 70, 150, 30);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
