//
//  SpecialListViewController.m
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "SpecialListViewController.h"
#import "HTTPTool.h"
#import "MySpecialCell.h"
#import "SpecialListModel.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "SpecialDetailViewController.h"
#import "SaveDataBase.h"

@interface SpecialListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)UITableView *tableView;
//headView
@property(nonatomic,retain)UIView *headView;
@property(nonatomic,retain)UISegmentedControl *seg;
@property(nonatomic,retain)NSMutableArray *specialListArr;

@property(nonatomic,assign)NSInteger number;
@property(nonatomic, copy)NSString *strUrl;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, copy)NSNumber *maxPageId;
@property(nonatomic,assign)BOOL isOk;
@property(nonatomic,retain)NSMutableArray *dataArr;
@end

@implementation SpecialListViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.specialListArr = [NSMutableArray array];
        self.conditionArr = @[@"hot", @"recent", @"classic"];
        self.strUrl = [NSString string];
        self.dataArr = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArr = [[SaveDataBase shareSaveDataBase] selectspecialList];
    
    
    //搜索栏
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(leftBarButtonAction:)];
    self.title = self.titleName;
    //tableView
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 49) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = 0;
    [self.view addSubview:self.tableView];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    [self.tableView release];
    //下拉刷新
    self.number = 0;
    self.isOk = YES;
    [self.tableView addHeaderWithCallback:^{
        [self createData];
    }];
    //上拉加载
    [self.tableView addFooterWithCallback:^{
        if (self.page < [self.maxPageId integerValue]) {
            [self footerRefreshing];
           
        }else{
            [self.tableView footerEndRefreshing];
        }
    }];
    [self.tableView headerBeginRefreshing];
}
//搜索栏的点击方法
-(void)leftBarButtonAction:(UIButton *)button{
    
}
//tableview section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}

//section 重铺
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *sectionBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    sectionBackView.backgroundColor = [UIColor clearColor];
    
    UIView *sectionView  =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 50)];
    sectionView.backgroundColor  = [UIColor colorWithRed:8 / 255.0 green:19 / 255.0 blue:31 / 255.0 alpha:1];
    
    self.seg = [[UISegmentedControl alloc] initWithItems:@[@"最火",@"最近更新",@"经典"]];
    [sectionView addSubview:self.seg];
    self.seg.frame =CGRectMake(10,10 , self.view.frame.size.width-20,30);
    [self.seg addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    self.seg.selectedSegmentIndex = self.number;
    
    self.seg.tintColor = [UIColor clearColor];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName,  [UIColor whiteColor], NSForegroundColorAttributeName,nil];
    [self.seg setTitleTextAttributes:dic forState:UIControlStateNormal];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:17],NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName,nil];
    [self.seg setTitleTextAttributes:dic1 forState:UIControlStateSelected];
    
    [sectionBackView addSubview:sectionView];
    return sectionBackView;
}


#pragma mark 两个协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.specialListArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse = @"reuse";
    MySpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[[MySpecialCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse] autorelease];
        
    }
    SpecialListModel *specialList = self.specialListArr[indexPath.row];
    [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:specialList.coverMiddle]];
    cell.titleLabel.text = specialList.title;
    CGFloat a = [specialList.playsCounts floatValue];
    a/=10000;
    cell.playCountLabel.text = [NSString stringWithFormat:@"▷%.1f万",a];
    cell.selectionStyle = 0;
    [cell.saveButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.saveButton.tag = indexPath.row;
   
    for (NSString  *str3 in self.dataArr) {
        NSString *str = [NSString stringWithFormat:@"%@", specialList.bId];
//        NSString *str2 = [NSString stringWithFormat:@"%@", model.bId];
//        NSLog(@"%ld", str.length);
//        NSLog(@"%ld", str2.length);
        if ([str3 isEqualToString:str]) {
            [cell.saveButton setTitle:@"已收藏" forState: UIControlStateNormal];
            break;
        }
    }
   
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SpecialDetailViewController *specialDetailVC = [[SpecialDetailViewController alloc] init];
    SpecialListModel *specialList = self.specialListArr[indexPath.row];
    specialDetailVC.bId = specialList.bId;
    specialDetailVC.title = specialList.title;
    [self.navigationController pushViewController:specialDetailVC animated:YES];
    
}




//segment 点击方法

- (void)click:(UIButton *)button
{
   
    SpecialListModel *model = self.specialListArr[button.tag];
    NSLog(@"%@", model.bId);
    [[SaveDataBase shareSaveDataBase] openDB];
    [[SaveDataBase shareSaveDataBase] createTable];
    
    if ([[SaveDataBase shareSaveDataBase] insertSpecialListModel:model.bId]) {
        NSLog(@"已添加");
        [button setTitle:@"已收藏" forState:UIControlStateNormal];
     }else{
         [[SaveDataBase shareSaveDataBase] deleteSpecialList:model.bId];
         [button setTitle:@"☆收藏" forState:UIControlStateNormal];
    }
    
}

#pragma mark 点击方法

-(void)segAction:(UISegmentedControl *)seg {
    if (self.seg.selectedSegmentIndex == 0) {
        self.number = 0;
    }else if (self.seg.selectedSegmentIndex ==1){
        self.number = 1;
    }else if (self.seg.selectedSegmentIndex == 2){
        self.number = 2;
    }
    [self.tableView headerBeginRefreshing];
    
}
#pragma mark 下拉刷新
-(void)createData{
    self.strUrl = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_album_list?category_name=%@&condition=%@&device=android&page=1&per_page=20&status=0&tag_name=%@",self.ag_name , self.conditionArr[self.number], self.category_name];
    NSString *strurl = [self.strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [HTTPTool get:strurl body:nil httpResult:JSON success:^(id result) {
        [self.specialListArr removeAllObjects];
        NSDictionary *dic = result;
        self.maxPageId = dic[@"maxPageId"];
        NSArray *ListArr = dic[@"list"];
        for (NSDictionary *tempDic in ListArr) {
            SpecialListModel *listModel = [[SpecialListModel alloc] initWithDic:tempDic];
            [self.specialListArr addObject:listModel];
        }

//        NSLog(@"%@",self.specialListArr);

        self.page = 1;
        if (self.page == [self.maxPageId integerValue]) {
            [self.tableView setFooterHidden:YES];
        }else{
            [self.tableView setFooterHidden:NO];
        }

        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];        
    } failure:^(NSError *error) {
    }];
}
#pragma mark 上拉加载
- (void)footerRefreshing
{
    self.page++;
     NSString *str = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_album_list?category_name=%@&condition=%@&device=android&page=%ld&per_page=20&status=0&tag_name=%@",self.ag_name , self.conditionArr[self.number], (long)self.page, self.category_name];
    NSString *strurl = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [HTTPTool get:strurl body:nil httpResult:JSON success:^(id result) {
        NSDictionary *dic = result;
        NSArray *ListArr = dic[@"list"];
        for (NSDictionary *tempDic in ListArr) {
            SpecialListModel *listModel = [[SpecialListModel alloc] initWithDic:tempDic];
            [self.specialListArr addObject:listModel];
        }
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
        if (self.page == [self.maxPageId integerValue]) {
            [self.tableView setFooterHidden:YES];
        }
        
    } failure:^(NSError *error) {
        
    }];
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
