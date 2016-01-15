//
//  RightTableCell.m
//  Wavelet
//
//  Created by dlios on 15-7-2.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "RightTableCell.h"

@implementation RightTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.button=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.button];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.button.frame=CGRectMake(self.contentView.frame.size.width-60, 0, 50, 20);
    self.button.layer.borderWidth=1;
    self.button.center=CGPointMake(self.contentView.frame.size.width-60 ,self.contentView.frame.size.height/2);
    [self.button setTitle:@"☆收藏" forState:UIControlStateNormal];
    self.button.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
