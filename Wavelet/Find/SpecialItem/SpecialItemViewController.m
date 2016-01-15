//
//  SpecialItemViewController.m
//  Wavelet
//
//  Created by dlios on 15-7-8.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "SpecialItemViewController.h"
#import "AFNetworking.h"
#import "HTTPTool.h"
#import "SpecialItemModel.h"
#import "SpecialItemCell.h"
#import "MJRefresh.h"
#import "SpecialDetailItemVC.h"

@interface SpecialItemViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *ItemArr;
@property(nonatomic,assign)NSInteger page;
@end

@implementation SpecialItemViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self= [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.ItemArr = [NSMutableArray array];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"专题";
    self.view.backgroundColor = [UIColor clearColor];
    [self createView];
    [self creatData];
    self.page = 1;
    [self.tableView addHeaderWithCallback:^{
        [self creatData];
        
    }];
    [self.tableView headerBeginRefreshing];
    
    [self.tableView addFooterWithCallback:^{
        
        [self didfootRefresh];
        
    }];
    
    
}

-(void)didfootRefresh{
    self.page ++;
    NSString *strUrl = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/subject_list?device=iPhone&page=%ld&per_page=20&scale=2",(long)self.page];
    [HTTPTool get:strUrl body:nil httpResult:JSON success:^(id result) {
        NSDictionary *dic = result;
        NSArray *listArr = dic[@"list"];
        NSNumber *maxPage =dic[@"maxPageId"];
        for (NSDictionary *tempDic in listArr) {
            SpecialItemModel *speModel = [[SpecialItemModel alloc] initWithDic:tempDic];
            [self.ItemArr addObject:speModel];
        }
        if (self.page == [maxPage integerValue]) {
            self.tableView.footerHidden = YES;
        }
        
        
        
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
        
    } failure:^(NSError *error) {
        
        NSLog(@"解析失败");
    }];
}



-(void)createView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-49) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = 0;
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate =self;
    self.tableView.rowHeight = 150;
    [self.tableView release];
    
}

-(void)creatData{
    NSString *strUrl = @"http://mobile.ximalaya.com/m/subject_list?device=iPhone&page=1&per_page=20&scale=2";
    
    [HTTPTool get:strUrl body:nil httpResult:JSON success:^(id result) {
        [self.ItemArr removeAllObjects];
        NSDictionary *dic = result;
//        NSLog(@"%@",dic);
        NSArray *listArr = dic [@"list"];
        for (NSDictionary *tempDic in listArr) {
            SpecialItemModel *speItem = [[SpecialItemModel alloc] initWithDic:tempDic];
            [self.ItemArr addObject:speItem];
        }
        [self.tableView reloadData];
        [self.tableView  headerEndRefreshing];
    } failure:^(NSError *error) {
        
        NSLog(@"解析失败");
    }];
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ItemArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse = @"ruese";
    SpecialItemCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[[SpecialItemCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse] autorelease];
    }
    SpecialItemModel *speItem  = self.ItemArr [indexPath.row];
    [cell.mainView sd_setImageWithURL:[NSURL URLWithString:speItem.coverPathBig]];
    cell.titleLabel.text = speItem.title;
    cell.selectionStyle = 0;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SpecialDetailItemVC *speDetailItem = [[SpecialDetailItemVC alloc] init];
    SpecialItemModel *speItem = self.ItemArr[indexPath.row];
    speDetailItem.DetailItemID  = speItem.specialId;
    [self.navigationController pushViewController:speDetailItem animated:YES];
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
