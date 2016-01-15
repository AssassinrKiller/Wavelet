//
//  TabBaseView.m
//  Wavelet
//
//  Created by dlios on 15-7-2.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "TabBaseView.h"

@interface TabBaseView()
@property(nonatomic, retain)UINavigationController *viewC;
@end

@implementation TabBaseView


- (instancetype)initWithFrame:(CGRect)frame
                       withVC:(UINavigationController *)VC
{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewC = VC;
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        UIButton *backBu = [UIButton buttonWithType:UIButtonTypeSystem];
        backBu.frame = CGRectMake(0, 0, 100, 49);
        [backBu setTitle:@"返回" forState:UIControlStateNormal];
        backBu.titleLabel.textColor = [UIColor blackColor];
        backBu.backgroundColor = [UIColor clearColor];
        [backBu addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBu];
        
        UIButton *homeBu = [UIButton buttonWithType:UIButtonTypeSystem];
        homeBu.frame = CGRectMake(self.frame.size.width - 100, 0, 100, 49);
        [homeBu setTitle:@"主页" forState:UIControlStateNormal];
        homeBu.titleLabel.textColor = [UIColor blackColor];
        homeBu.backgroundColor = [UIColor clearColor];
        [homeBu addTarget:self action:@selector(clickHomeBu) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:homeBu];
        
        [[PlayView sharePlayView] addButtonWithCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height - 30) rad:35];
        
        [self addSubview:[PlayView sharePlayView]];
        
    }
    return self;
}
- (void)click
{
    [self.viewC popViewControllerAnimated:YES];
}
- (void)clickHomeBu
{
    [self.viewC popToRootViewControllerAnimated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
