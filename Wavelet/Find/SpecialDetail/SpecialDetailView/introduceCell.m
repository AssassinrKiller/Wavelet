//
//  introduceCell.m
//  Wavelet
//
//  Created by dllo on 15/7/2.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "introduceCell.h"

@implementation introduceCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label1 = [[UILabel alloc] init];
        [self.contentView addSubview:self.label1];
        self.label1.backgroundColor = [UIColor clearColor];
        self.label1.textColor = [UIColor whiteColor];
        [self.label1 release];
        
        self.introduceLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.introduceLabel];
        self.introduceLabel.backgroundColor = [UIColor clearColor];
        self.introduceLabel.textColor = [UIColor whiteColor];
        [self.introduceLabel release];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
   
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.label1.frame = CGRectMake(20, 50, 40, 15);
    self.introduceLabel.frame = CGRectMake(20, 70, self.contentView.frame.size.width - 40, 20);
    self.introduceLabel.numberOfLines = 0;
    [self.introduceLabel sizeToFit];
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
