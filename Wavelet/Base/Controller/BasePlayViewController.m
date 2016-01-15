//
//  BasePlayViewController.m
//  Wavelet
//
//  Created by dlios on 15-7-7.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BasePlayViewController.h"

@interface BasePlayViewController ()



@end

@implementation BasePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
#pragma mark tab
    UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - 49, WIDTH, 49)];
    [self.view addSubview:tabView];
    [tabView release];
    self.navigationController.navigationBar.hidden=YES;
    tabView.backgroundColor = [UIColor clearColor];
    UIButton *backBu = [UIButton buttonWithType:UIButtonTypeSystem];
    backBu.frame = CGRectMake(0, 0, 100, 49);
    [backBu setTitle:@"返回" forState:UIControlStateNormal];
    backBu.titleLabel.textColor = [UIColor blackColor];
    backBu.backgroundColor = [UIColor clearColor];
    [backBu addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [tabView addSubview:backBu];
    
//    UIButton *homeBu = [UIButton buttonWithType:UIButtonTypeSystem];
//    homeBu.frame = CGRectMake(tabView.frame.size.width - 100, 0, 100, 49);
//    [homeBu setTitle:@"主页" forState:UIControlStateNormal];
//    homeBu.titleLabel.textColor = [UIColor blackColor];
//    homeBu.backgroundColor = [UIColor clearColor];
//    [homeBu addTarget:self action:@selector(clickHomeBu) forControlEvents:UIControlEventTouchUpInside];
//    [tabView addSubview:homeBu];
}

- (void)click
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)clickHomeBu
{
//    [self.viewC popToRootViewControllerAnimated:YES];
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
