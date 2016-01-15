//
//  FindDetailSecondCell.m
//  Wavelet
//
//  Created by dlios on 15-6-30.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "FindDetailSecondCell.h"

@implementation FindDetailSecondCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.secondBackView = [[UIImageView alloc] init];
        self.secondBackView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.secondBackView];
        [_secondBackView release];
        

        
        self.secondTitleLabel = [[UILabel alloc] init];
        self.secondTitleLabel.textAlignment = 1;
        self.secondTitleLabel.backgroundColor = [UIColor blackColor];
        self.secondTitleLabel.alpha = 0.8;
        self.secondTitleLabel.textColor = [UIColor whiteColor];
        [self.secondBackView addSubview:self.secondTitleLabel];
        [_secondTitleLabel release];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.secondBackView.frame = CGRectMake(WIDTH / 375, 20 * HEIGHT / 667, self.contentView.frame.size.width, self.contentView.frame.size.height - 20 * HEIGHT / 667);
    self.secondBackView.layer.cornerRadius = 15 * HEIGHT / 667;
    self.secondBackView.layer.masksToBounds = YES;
    self.secondTitleLabel.frame = CGRectMake(0, self.secondBackView.frame.size.height - 35 * HEIGHT / 667, self.secondBackView.frame.size.width, 35 * HEIGHT / 667);
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
