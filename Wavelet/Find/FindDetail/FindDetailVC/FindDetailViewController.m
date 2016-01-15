//
//  FindDetailViewController.m
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "FindDetailViewController.h"
#import "FindDetailView.h"
#import "FindFocusImages.h"
#import "FindCategories.h"
#import "FindRecommendAlbums.h"
#import "FindDetailCell.h"
#import "FindDetailSecondCell.h"
#import "ClassDetailViewController.h"
#import "SpecialDetailViewController.h"
#import "SpecialItemViewController.h"
#import "SpecialListViewController.h"
#import "SearchViewController.h"
#import "PlayMusicViewController.h"
#import "MyPlayer.h"
@interface FindDetailViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, QCRoundDelegate>
//顶端视图
@property(nonatomic, retain)FindDetailView *findHeadView;
//主界面
@property(nonatomic, retain)UIScrollView *mainfindDetailScroll;
//左面tabelView
@property(nonatomic, retain)UITableView *findDetailFirstTableView;
//右边tabelView
@property(nonatomic, retain)UITableView *findDetailSecondTableView;
//轮播图数组, 分类数组, 专辑数组, 分类图片
@property(nonatomic, retain)NSMutableArray *focusImagesArr;
@property(nonatomic, retain)NSMutableArray *categoriesArr;
@property(nonatomic, retain)NSMutableArray *recommendAlbumsArr;
@property(nonatomic, retain)NSMutableArray *picArr;
//轮播图
@property(nonatomic, retain)QCRound *round;
@property(nonatomic, retain)UIImageView *roundImage;
@property(nonatomic, retain)UIView *myView;
@end

@implementation FindDetailViewController
- (void)dealloc
{
    [_findHeadView release];
    [_mainfindDetailScroll release];
    [_findDetailFirstTableView release];
    [_findDetailSecondTableView release];
    [_focusImagesArr release];
    [_categoriesArr release];
    [_recommendAlbumsArr release];
    [_picArr release];
    [_round release];
    [_roundImage release];
    [_myView release];
    [super dealloc];
}
#pragma mark 初始化数组
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.focusImagesArr = [NSMutableArray array];
        self.categoriesArr = [NSMutableArray array];
        self.recommendAlbumsArr = [NSMutableArray array];
        self.picArr = [NSMutableArray array];
        self.roundImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, WIDTH - 20, 0)];
        for (NSInteger i = 0; i < 24; i++) {
            [self.picArr addObject:[NSString stringWithFormat:@"focusImage%ld.jpg", (long)i]];
        }
    }
    return self;
}
#pragma mark 隐藏navigationbar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"发现";
    if (self.mainfindDetailScroll.contentOffset.x > 100) {
        self.mainfindDetailScroll.contentOffset = CGPointMake(0, 0);
        if (self.mainfindDetailScroll.contentOffset.x == 0) {
            [self.round addTimer];
            [self.roundImage removeFromSuperview];
            self.round.hidden = NO;
            self.findDetailFirstTableView.hidden = NO;
        }
    }
//    self.tabBarController.tabBar.hidden = YES;

    [[PlayView sharePlayView] addButtonWithCenter:CGPointMake(WIDTH / 2, 20) rad:35];
        [self.tabBarController.tabBar addSubview:[PlayView sharePlayView]];
    [[PlayView sharePlayView]->button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
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
#pragma mark 下拉刷新
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(click)];

    //--------------

    //--------------
        
    // Do any additional setup after loading the view.
    [self createFindDetailView];
    [self.findDetailFirstTableView addHeaderWithCallback:^{
        [self createData];
    }];
    [self.findDetailFirstTableView headerBeginRefreshing];
    
}
- (void)click
{
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
    [searchVC release];
}
#pragma 铺设界面
- (void)createFindDetailView
{
    //主滑动界面
    self.mainfindDetailScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    self.mainfindDetailScroll.backgroundColor = [UIColor clearColor];
    self.mainfindDetailScroll.delegate = self;
    self.mainfindDetailScroll.contentSize = CGSizeMake((375 + 300) * WIDTH / 375, 0);
    self.mainfindDetailScroll.pagingEnabled = YES;
    self.mainfindDetailScroll.showsHorizontalScrollIndicator = NO;
    self.mainfindDetailScroll.bounces = NO;
    [self.view addSubview:self.mainfindDetailScroll];
    [_mainfindDetailScroll release];
    //第一个tableview
    self.findDetailFirstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, (667 - 113) * HEIGHT / 667) style:UITableViewStylePlain];
    self.findDetailFirstTableView.backgroundColor = [UIColor clearColor];
    self.findDetailFirstTableView.delegate = self;
    self.findDetailFirstTableView.dataSource = self;
    self.findDetailFirstTableView.rowHeight = 80 * HEIGHT / 667;
    self.findDetailFirstTableView.separatorStyle = 0;
    self.findDetailFirstTableView.showsVerticalScrollIndicator = NO;
    [self.mainfindDetailScroll addSubview:self.findDetailFirstTableView];
    [_findDetailFirstTableView release];
    //第二个tableview
    self.findDetailSecondTableView = [[UITableView alloc] initWithFrame:CGRectMake((375 + 50)* WIDTH / 375, 0, 200* WIDTH / 375, (667 - 113) * HEIGHT / 667) style:UITableViewStylePlain];
    self.findDetailSecondTableView.backgroundColor = [UIColor clearColor];
    self.findDetailSecondTableView.delegate = self;
    self.findDetailSecondTableView.dataSource = self;
    self.findDetailSecondTableView.rowHeight = 100 * HEIGHT / 667;
    self.findDetailSecondTableView.separatorStyle = 0;
    self.findDetailSecondTableView.showsVerticalScrollIndicator = NO;
    [self.mainfindDetailScroll addSubview:self.findDetailSecondTableView];
    [_findDetailSecondTableView release];
    //头视图, 轮播图
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(10* WIDTH / 375, 0, (375 - 20)* WIDTH / 375, 300 * HEIGHT / 667)];
    self.round = [[QCRound alloc] initWithFrame:CGRectMake(10* WIDTH / 375, 10 * HEIGHT / 667, (375 - 20)* WIDTH / 375, 160 * HEIGHT / 667)];
    self.round.delegate = self;
    self.round.imageArr = [NSMutableArray arrayWithObjects:@"zhanweitu", nil];
    [self.myView addSubview:self.round];
    
    self.findDetailFirstTableView.tableHeaderView = self.myView;
    
    
    
}
- (void)clickUpButton
{
    SpecialListViewController *specialVc = [[SpecialListViewController alloc] init];
    specialVc.ag_name = @"all";
    specialVc.category_name = @"";
    specialVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:specialVc animated:YES];
    [specialVc release];
}
- (void)clickDownButton
{
    NSLog(@"11");
    SpecialItemViewController *itemVC = [[SpecialItemViewController alloc] init];
    itemVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:itemVC animated:YES];
    [itemVC release];
    
}





#pragma mark 数据解析
- (void)createData
{
    [HTTPTool get: @"http://mobile.ximalaya.com/m/super_explore_index2?channel=ios-b1&device=iPhone&includeActivity=true&picVersion=9&scale=2&version=3.1.43" body:nil httpResult:JSON success:^(id result) {
        [self.focusImagesArr removeAllObjects];
        [self.categoriesArr removeAllObjects];
        [self.recommendAlbumsArr removeAllObjects];
        [self.round.imageArr removeAllObjects];
#pragma mark 轮播图
        for (NSDictionary *dic in result[@"focusImages"][@"list"]) {
            FindFocusImages *model = [[FindFocusImages alloc] initWithDic:dic];
            [self.focusImagesArr addObject:model];
        }
        self.round.imageArr = self.focusImagesArr;
        [self.round configureCellBlock:^(QCRoundCell *cell, id model) {
            FindFocusImages *focus = model;
            cell.imageUrl = focus.pic;
        }];
        //分类
        for (NSDictionary *dic in result[@"categories"][@"data"]) {
            FindCategories *model = [[FindCategories alloc] initWithDic:dic];
            [self.categoriesArr addObject:model];
        }
        //推荐列表
        for (NSDictionary *dic in result[@"recommendAlbums"][@"list"]) {
            FindRecommendAlbums *model = [[FindRecommendAlbums alloc] initWithDic:dic];
            [self.recommendAlbumsArr addObject:model];
        }
        [self.findDetailFirstTableView reloadData];
        [self.findDetailSecondTableView reloadData];
        [self.findDetailFirstTableView headerEndRefreshing];
        [self.findDetailSecondTableView headerEndRefreshing];
        
        UILabel *mylabel = [[UILabel alloc] initWithFrame:CGRectMake(10* WIDTH / 375, 270 * HEIGHT / 667, (375 - 20)* WIDTH / 375, 20 * HEIGHT / 667)];
        mylabel.backgroundColor = [UIColor clearColor];
        mylabel.textColor = [UIColor whiteColor];
        mylabel.text = @"推荐专辑";
        [self.myView addSubview:mylabel];
        [mylabel release];
        
        UIImageView *upView = [[UIImageView alloc] initWithFrame:CGRectMake(15* WIDTH / 375, 180 * HEIGHT / 667, (375 / 2 - 20)* WIDTH / 375, 80 * HEIGHT / 667)];
        upView.image = [UIImage imageNamed:@"focusImage2.jpg"];
        upView.userInteractionEnabled = YES;
        [self.myView addSubview:upView];
        [upView release];
        
        UIImageView *downView = [[UIImageView alloc] initWithFrame:CGRectMake((375 / 2 + 5)* WIDTH / 375, 180 * HEIGHT / 667, (375 / 2 - 20)* WIDTH / 375, 80 * HEIGHT / 667)];
        downView.image = [UIImage imageNamed:@"focusImage14.jpg"];
        downView.userInteractionEnabled = YES;
        [self.myView addSubview:downView];
        [downView release];
        
        UIButton *upButton = [UIButton buttonWithType:UIButtonTypeCustom];
        upButton.frame = CGRectMake(0, 0, (375 / 2 - 20)* WIDTH / 375, 80 * HEIGHT / 667);
        [upButton setTitle:@"热播" forState:UIControlStateNormal];
        upButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        upButton.backgroundColor = [UIColor clearColor];
        [upButton addTarget:self action:@selector(clickUpButton) forControlEvents:UIControlEventTouchUpInside];
        [upView addSubview:upButton];
        
        UIButton *downButton = [UIButton buttonWithType:UIButtonTypeCustom];
        downButton.frame = CGRectMake(0, 0, (375 / 2 - 20)* WIDTH / 375, 80 * HEIGHT / 667);
        [downButton setTitle:@"专题" forState:UIControlStateNormal];
        downButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        downButton.backgroundColor = [UIColor clearColor];
        [downButton addTarget:self action:@selector(clickDownButton) forControlEvents:UIControlEventTouchUpInside];
        [downView addSubview:downButton];
        
       
        
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark tabelView的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.findDetailFirstTableView) {
        return self.recommendAlbumsArr.count;
    }else{
        return self.categoriesArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.findDetailFirstTableView) {
        static NSString *findReuse = @"findReuse";
        FindDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:findReuse];
        if (!cell) {
            cell = [[FindDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:findReuse];
        }
        FindRecommendAlbums *model = self.recommendAlbumsArr[indexPath.row];
        [cell.findDetailCellImage sd_setImageWithURL:[NSURL URLWithString:model.coverSmall]];
        cell.findDetailCellTitleLabel.text = model.title;
        cell.findDetailCellTitleLabel.textColor = [UIColor whiteColor];
        CGFloat count = [model.playsCounts floatValue];
        cell.findDetailCellPlaycounts.text = [NSString stringWithFormat:@"%.1f万", count / 10000];
        cell.selectionStyle = 0;
        return cell;
    }else{
        static NSString *secondReuse = @"secondReuse";
        FindDetailSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:secondReuse];
        if (!cell) {
            cell = [[FindDetailSecondCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:secondReuse];
        }
        FindCategories *model = self.categoriesArr[indexPath.row];
        [cell.secondBackView setImage:[UIImage imageNamed:self.picArr[indexPath.row]]];
//        [cell.secondSmallView sd_setImageWithURL:[NSURL URLWithString:model.coverPath]];
        cell.secondTitleLabel.text = model.title;
        cell.selectionStyle = 0;
        return cell;
    }
}
#pragma mark 点击跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.findDetailSecondTableView) {
        ClassDetailViewController *classDetail = [[ClassDetailViewController alloc] init];
        FindCategories *model = self.categoriesArr[indexPath.row];
        classDetail.category = model.name;
        classDetail.categoryId = model.bId;
        classDetail.name = model.title;
        classDetail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:classDetail animated:YES];
        [classDetail release];        
    }else if(tableView == self.findDetailFirstTableView){
        SpecialDetailViewController *speVC = [[SpecialDetailViewController alloc] init];
        FindRecommendAlbums *model = self.recommendAlbumsArr[indexPath.row];
        speVC.bId = model.bId;
        speVC.hidesBottomBarWhenPushed = YES;
        speVC.title = model.title;
        [self.navigationController pushViewController:speVC animated:YES];
        [speVC release];
    }
}
#pragma mark 轮播图截屏
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
        if (scrollView == self.mainfindDetailScroll && self.mainfindDetailScroll.contentOffset.x == 0) {
            UIGraphicsBeginImageContext(self.mainfindDetailScroll.frame.size);
            [self.mainfindDetailScroll.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            self.roundImage.image = aImage;
            [self.mainfindDetailScroll addSubview:self.roundImage];
            self.round.hidden = YES;
            self.findDetailFirstTableView.hidden = YES;
            [self.round removeTimer];
        }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.mainfindDetailScroll) {
        CGFloat newY = HEIGHT - scrollView.contentOffset.x * 0.4 * HEIGHT / 667;
        CGFloat oldY = HEIGHT;
        self.roundImage.frame = CGRectMake(WIDTH - WIDTH * newY / oldY, (oldY - newY) / 2, WIDTH * newY / oldY, newY);
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.mainfindDetailScroll) {
        if (self.mainfindDetailScroll.contentOffset.x == 0) {
            
            [self.round addTimer];
            
            [self.roundImage removeFromSuperview];
            self.round.hidden = NO;
            self.findDetailFirstTableView.hidden = NO;
        }
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
