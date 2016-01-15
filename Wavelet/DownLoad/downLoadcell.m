//
//  downLoadcell.m
//  Wavelet
//
//  Created by dlios on 15-7-8.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "downLoadcell.h"

@implementation downLoadcell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.downLoad=[[UIView alloc] init];
        [self.backView addSubview:self.downLoad];
        [_downLoad release];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.downLoad.frame=CGRectMake(0, 110, self.contentView.frame.size.width, 20);
}
-(void)dealloc
{
    [_downLoad release];
    [super dealloc];
}



@end
