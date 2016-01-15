//
//  MyCollectionViewCell.m
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell
-(void)dealloc
{
    [_imageView release];
    [_label release];
    [super dealloc];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:2];
        UIVisualEffectView *effect = [[UIVisualEffectView alloc] initWithEffect:blur];
        effect.frame = self.contentView.frame;
        effect.alpha = 0.8;
        [self.contentView addSubview:effect];
        //初始化自定义的imageView和label
        self.contentView.backgroundColor=[UIColor whiteColor];
        self.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100*WIDTH/375, 80*HEIGHT/667)];
        self.imageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.imageView];
        [_imageView release];
        self.label=[[UILabel alloc]initWithFrame:CGRectMake(0,80*WIDTH/375,100*WIDTH/375,20*HEIGHT/667)];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:15];
        self.label.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
        [_label release];
        
        self.contentView.layer.cornerRadius = 3;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}
@end
