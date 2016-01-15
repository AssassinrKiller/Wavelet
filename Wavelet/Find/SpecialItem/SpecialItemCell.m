//
//  SpecialItemCell.m
//  Wavelet
//
//  Created by dllo on 15/7/8.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "SpecialItemCell.h"

@implementation SpecialItemCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.mainView  = [[UIImageView alloc] init];
        [self.contentView addSubview:self.mainView];
        self.mainView.backgroundColor = [UIColor clearColor];
        [_mainView release];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.backgroundColor = [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        self.titleLabel.textAlignment = 1;
       
        [_titleLabel release];
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.mainView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height-10);
    
    self.titleLabel.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 20);
    self.titleLabel.center = CGPointMake(self.contentView.frame.size.width/2, self.mainView.frame.size.height - 10);
}










- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
