//
//  FindDetailCell.m
//  Wavelet
//
//  Created by dlios on 15-6-30.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "FindDetailCell.h"

@interface FindDetailCell()
@property(nonatomic, retain)UILabel *moreLabel;

@end

@implementation FindDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.findDetailCellBackView = [[UIView alloc] init];
        self.findDetailCellBackView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.findDetailCellBackView];
        [_findDetailCellBackView release];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:1];
        self.effect = [[UIVisualEffectView alloc] initWithEffect:blur];
        self.effect.alpha = 0.2;
        [self.findDetailCellBackView addSubview:self.effect];
        
        
        self.findDetailCellImage = [[UIImageView alloc] init];
        self.findDetailCellImage.backgroundColor = [UIColor clearColor];
        [self.findDetailCellBackView addSubview:self.findDetailCellImage];
        [_findDetailCellImage release];
        
        self.findDetailCellPlaycounts = [[UILabel alloc] init];
        self.findDetailCellPlaycounts.backgroundColor = [UIColor clearColor];
        [self.findDetailCellBackView addSubview:self.findDetailCellPlaycounts];
        [_findDetailCellPlaycounts release];
        
        self.findDetailCellTitleLabel = [[UILabel alloc] init];
        self.findDetailCellTitleLabel.backgroundColor = [UIColor clearColor];
        [self.findDetailCellBackView addSubview:self.findDetailCellTitleLabel];
        [_findDetailCellTitleLabel release];
        
        self.moreLabel = [[UILabel alloc] init];
        self.moreLabel.backgroundColor = [UIColor clearColor];
        [self.findDetailCellBackView addSubview:self.moreLabel];
        [_moreLabel release];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.findDetailCellBackView.frame = CGRectMake(10* WIDTH / 375, 0, WIDTH - ((10* WIDTH / 375) * 2), self.contentView.frame.size.height - 10 * HEIGHT / 667);
    NSLog(@"%g", 20* WIDTH / 375);
    NSLog(@"%g", WIDTH - (20* WIDTH / 375));
    NSLog(@"%g", WIDTH);
    
    self.effect.frame = CGRectMake(0, 0, WIDTH - ((10* WIDTH / 375) * 2), self.contentView.frame.size.height - 10 * HEIGHT / 667);
    
    self.findDetailCellImage.frame = CGRectMake(0, 0, self.findDetailCellBackView.frame.size.height, self.findDetailCellBackView.frame.size.height);
    
    self.findDetailCellTitleLabel.frame = CGRectMake(80* WIDTH / 375, 15 * HEIGHT / 667, 200* WIDTH / 375, 15 * HEIGHT / 667);
    self.findDetailCellTitleLabel.textColor = [UIColor whiteColor];
    
    self.findDetailCellPlaycounts.frame = CGRectMake(80* WIDTH / 375, 45 * HEIGHT / 667, 200* WIDTH / 375, 15 * HEIGHT / 667);
    self.findDetailCellPlaycounts.textColor = [UIColor whiteColor];
    self.findDetailCellPlaycounts.font = [UIFont systemFontOfSize:15];
    
    self.moreLabel.frame = CGRectMake(self.findDetailCellBackView.frame.size.width - 30* WIDTH / 375, 0, 30 * HEIGHT / 667, self.findDetailCellBackView.frame.size.height);
    self.moreLabel.text = @"〉";
    self.moreLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
