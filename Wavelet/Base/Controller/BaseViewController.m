//
//  BaseViewController.m
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BaseViewController.h"
#import "PlayMusicViewController.h"
#import "MyPlayer.h"
#import "SearchViewController.h"
@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    
    
    self.tabView = [[TabBaseView alloc] initWithFrame:CGRectMake(0, HEIGHT - 49 - 64, WIDTH, 49) withVC:self.navigationController];
    [self.view addSubview:self.tabView];
    [self.tabView release];
    
    [[PlayView sharePlayView]->button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clickSearch)];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    

}
#pragma mark tab
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backImage.jpg"]]];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self.tabView addSubview:[PlayView sharePlayView]];
    [self.view bringSubviewToFront:self.tabView];
    
    if ([MyPlayer sharePlayer].rate==1) {
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue=[NSNumber numberWithFloat:0.0];
        animation.toValue=[NSNumber numberWithFloat:2 *M_PI];
        animation.duration=10;
        animation.repeatCount=HUGE_VALF;
        NSArray *arr = [[PlayView sharePlayView] subviews];
        UIButton *bu = arr[0];
        [bu.layer addAnimation:animation forKey:@"rotation"];
        [PlayView sharePlayView]->isPlay = YES;
    }else{
        NSArray *arr = [[PlayView sharePlayView] subviews];
        UIButton *bu = arr[0];
        [bu.layer removeAnimationForKey:@"rotation"];
        [PlayView sharePlayView]->isPlay = NO;
    }
}
- (void)clickButton
{
    PlayMusicViewController *playVC = [[PlayMusicViewController alloc] init];
    [playVC setModalTransitionStyle:0];
    playVC.playAlbumId = [PlayView sharePlayView]->playAlbumId;
    
    [self presentViewController:playVC animated:YES completion:^{
    }];
}

- (void)clickSearch
{
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
    [searchVC release];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
