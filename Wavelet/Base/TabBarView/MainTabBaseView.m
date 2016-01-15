//
//  MainTabBaseView.m
//  Wavelet
//
//  Created by dlios on 15-7-13.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MainTabBaseView.h"
#import "collocViewController.h"
#import "MineViewController.h"
#import "DownLoadViewController.h"

@interface MainTabBaseView()

@property(nonatomic, retain)UINavigationController *viewC;

@end

@implementation MainTabBaseView

- (instancetype)initWithFrame:(CGRect)frame
                       withVC:(UINavigationController *)VC
{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewC = VC;
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        UIButton *findBu = [UIButton buttonWithType:UIButtonTypeSystem];
        findBu.frame = CGRectMake(0, 0, 50, 49);
        [findBu setTitle:@"发现" forState:UIControlStateNormal];
        findBu.titleLabel.textColor = [UIColor blackColor];
        findBu.backgroundColor = [UIColor clearColor];
        [findBu addTarget:self action:@selector(clickFindBu) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:findBu];
        
        UIButton *collecBu = [UIButton buttonWithType:UIButtonTypeSystem];
        collecBu.frame = CGRectMake(50, 0, 50, 49);
        [collecBu setTitle:@"收藏" forState:UIControlStateNormal];
        collecBu.titleLabel.textColor = [UIColor blackColor];
        collecBu.backgroundColor = [UIColor clearColor];
        [collecBu addTarget:self action:@selector(clickCollecBu) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:collecBu];
        
        UIButton *downLoadBu = [UIButton buttonWithType:UIButtonTypeSystem];
        downLoadBu.frame = CGRectMake(self.frame.size.width - 100, 0, 50, 49);
        [downLoadBu setTitle:@"下载" forState:UIControlStateNormal];
        downLoadBu.titleLabel.textColor = [UIColor blackColor];
        downLoadBu.backgroundColor = [UIColor clearColor];
        [downLoadBu addTarget:self action:@selector(clickDownLoadBu) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:downLoadBu];
        
        UIButton *mineBu = [UIButton buttonWithType:UIButtonTypeSystem];
        mineBu.frame = CGRectMake(self.frame.size.width - 50, 0, 50, 49);
        [mineBu setTitle:@"我的" forState:UIControlStateNormal];
        mineBu.titleLabel.textColor = [UIColor blackColor];
        mineBu.backgroundColor = [UIColor clearColor];
        [mineBu addTarget:self action:@selector(clickMineBu) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:mineBu];
        
        [[PlayView sharePlayView] addButtonWithCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height - 30) rad:35];
        
        [self addSubview:[PlayView sharePlayView]];
        
    }
    return self;
}
- (void)clickFindBu
{
    [self.viewC popToRootViewControllerAnimated:YES];
}
- (void)clickCollecBu
{
    collocViewController *speVC = [[collocViewController alloc] init];
    [self.viewC pushViewController:speVC animated:YES];
    [speVC release];
}
- (void)clickDownLoadBu
{
    DownLoadViewController *downVC = [[DownLoadViewController alloc] init];
    [self.viewC pushViewController:downVC animated:YES];
    [downVC release];
}
- (void)clickMineBu
{
    MineViewController *mineVC = [[MineViewController alloc] init];
    [self.viewC pushViewController:mineVC animated:YES];
    [mineVC release];
}


@end
