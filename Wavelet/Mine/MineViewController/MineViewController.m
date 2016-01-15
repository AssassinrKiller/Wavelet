//
//  MineViewController.m
//  Wavelet
//
//  Created by dlios on 15-7-3.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MineViewController.h"
#import "MineCell.h"
#import "SaveViewController.h"
@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, retain)UITableView *mainTableView;
@property(nonatomic, retain)NSArray *sectionOneArr;
@property(nonatomic, retain)NSArray *sectionTwoArr;
@property(nonatomic, retain)UIImageView *headPic;
@property(nonatomic, retain)UIView *headView;
@property(nonatomic, retain)UIVisualEffectView *effectView;

@end

@implementation MineViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.sectionOneArr = [NSArray arrayWithObjects:@"申请认证", @"小浪大学", nil];
        self.sectionTwoArr = [NSArray arrayWithObjects:@"免流量试听", @"意见反馈", @"设置", nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.title = @"我的";
    [self createView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[PlayView sharePlayView] addButtonWithCenter:CGPointMake(WIDTH / 2, 20) rad:35];
    [self.tabBarController.tabBar addSubview:[PlayView sharePlayView]];
}
- (void)createView
{
#pragma mark tableView
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 113) style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.rowHeight = 50;
    [self.view addSubview:self.mainTableView];
    [_mainTableView release];
#pragma mark tableview头视图
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 240 * HEIGHT / 667)];
    self.headPic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT / 3 )];
    [self.headPic setImage:[UIImage imageNamed:@"focusImage6.jpg"]];
    [self.view addSubview:self.headPic];
    [self.headPic release];
#pragma mark 毛玻璃
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:0];
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    self.effectView.frame = CGRectMake(0, 0, self.headPic.frame.size.width, self.headPic.frame.size.height + 2);
    self.effectView.alpha = 0.7;
    [self.headPic addSubview:self.effectView];
    [self.effectView release];
    
//    UIButton *headBu = [UIButton buttonWithType:UIButtonTypeSystem];
//    headBu.backgroundColor = [UIColor orangeColor];
//    [headBu setTitle:@"录音" forState:UIControlStateNormal];
//    headBu.frame = CGRectMake(30, HEIGHT / 3 - 5, WIDTH - 60, HEIGHT / 9 - 30);
//    [self.headView addSubview:headBu];
    self.mainTableView.separatorStyle = 0;
    self.mainTableView.tableHeaderView = self.headView;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y< 0) {
        self.headPic.frame = CGRectMake( -((HEIGHT / 3 - scrollView.contentOffset.y) * 3/ HEIGHT * WIDTH - WIDTH) /2, 0, (HEIGHT / 3 - scrollView.contentOffset.y)* WIDTH * 3/ HEIGHT , HEIGHT / 3 - scrollView.contentOffset.y);
        self.effectView.frame = CGRectMake(0, 0, self.headPic.frame.size.width, self.headPic.frame.size.height + 2);
        self.effectView.alpha = 0.7 + (scrollView.contentOffset.y) / 70;
    }else{
        self.headPic.frame = CGRectMake(0, -scrollView.contentOffset.y, WIDTH, HEIGHT / 3);
        self.effectView.frame = CGRectMake(0, 0, self.headPic.frame.size.width, self.headPic.frame.size.height + 2);
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else if(section == 1){
        return 20  * HEIGHT / 667;
    }else if(section == 2){
        return 20  * HEIGHT / 667;
    }else{
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    aview.backgroundColor = [UIColor clearColor];
    return aview;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 3;
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *reuse = @"section1";
        MineCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        if (!cell) {
            cell = [[[MineCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse] autorelease];
        }
        cell.mineLabel.text = @"播放历史";
        cell.mineDetailLabel.text = @">";
        cell.selectionStyle = 0;
        return cell;
    }else if (indexPath.section == 1) {
        static NSString *reuse = @"section2";
        MineCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        if (!cell) {
            cell = [[[MineCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse] autorelease];
        }
        cell.mineLabel.text = self.sectionOneArr[indexPath.row];
        cell.mineDetailLabel.text = @">";
        cell.selectionStyle = 0;
        return cell;
    }else if (indexPath.section == 2){
        static NSString *reuse = @"section3";
        MineCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        if (!cell) {
            cell = [[[MineCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse] autorelease];
        }
        cell.mineLabel.text = self.sectionTwoArr[indexPath.row];
        cell.mineDetailLabel.text = @">";
        cell.selectionStyle = 0;
        
        return cell;
    }else{
        return nil;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        SaveViewController *saveVC = [[SaveViewController alloc] init];
        
        [self.navigationController pushViewController:saveVC animated:YES];
    }
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
