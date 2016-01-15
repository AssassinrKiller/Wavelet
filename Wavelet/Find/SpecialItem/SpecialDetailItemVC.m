//
//  SpecialDetailItemVC.m
//  Wavelet
//
//  Created by dllo on 15/7/8.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "SpecialDetailItemVC.h"
#import "SpecialDetailItemModel.h"
#import "SpecialDetailItemCell.h"
#import "SpecialDetailViewController.h"
@interface SpecialDetailItemVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *speDetailArr;
@property(nonatomic,retain)UIView *headView;
@property(nonatomic,retain)UIImageView *headImageView;
@property(nonatomic,retain)UILabel *headLabel;
@property(nonatomic,retain)UILabel *upLabel;

@end

@implementation SpecialDetailItemVC

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.speDetailArr = [NSMutableArray array];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    [self createView];
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData{
    NSString *strUrl = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/subject_detail?device=android&id=%ld",(long)self.DetailItemID];
    [HTTPTool get:strUrl body:nil httpResult:JSON success:^(id result) {
        NSDictionary *dic = result;
      NSDictionary *infoDic =dic[@"info"];
      NSArray *listArr = dic[@"list"];
        for (NSDictionary *tempDic in listArr) {
            SpecialDetailItemModel *speDetailItem = [[SpecialDetailItemModel alloc] initWithDic:tempDic];
            [self.speDetailArr addObject:speDetailItem];
        }
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:infoDic[@"coverPathBig"]]];
        
        self.headLabel.text = infoDic[@"title"];
        
        self.upLabel.frame = CGRectMake(10, 200, WIDTH - 20, 0);
        self.upLabel.text = infoDic[@"intro"];
        self.upLabel.numberOfLines = 0;
        [self.upLabel sizeToFit];
        self.headView.frame = CGRectMake(0, 0, WIDTH, self.headImageView.frame.size.height + self.headLabel.frame.size.height + self.upLabel.frame.size.height + 64);
        self.tableView.tableHeaderView = self.headView;
        
        [self.tableView reloadData];
        } failure:^(NSError *error) {
        
        NSLog(@"解析失败");
    }];
}





-(void)createView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 113) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = 0;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView release];
    self.tableView.rowHeight = self.view.frame.size.height/6;
    
    self.headView = [[UIView alloc] init];
    self.headView.backgroundColor = [UIColor clearColor];
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    self.headImageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.headImageView];
    [self.headImageView release];
    
    self.headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, self.view.frame.size.width, 30)];
    self.headLabel.textAlignment = 1;
    self.headLabel.textColor = [UIColor whiteColor];
    [self.headView addSubview:self.headLabel];
    self.headLabel.backgroundColor = [UIColor clearColor];
    [_headLabel release];
    
    self.upLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, WIDTH - 20, 0)];
    self.upLabel.textColor = [UIColor whiteColor];
    self.upLabel.font = [UIFont systemFontOfSize:15];
    [self.headView addSubview:self.upLabel];
    
    self.headView.frame = CGRectMake(0, 0, WIDTH, self.headImageView.frame.size.height + self.headLabel.frame.size.height + self.upLabel.frame.size.height);
    self.tableView.tableHeaderView = self.headView;
    
    [_upLabel release];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.speDetailArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse = @"reuse";
    SpecialDetailItemCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[[SpecialDetailItemCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse] autorelease];
    }
    SpecialDetailItemModel *speDetail = self.speDetailArr[indexPath.row];
    cell.titleLabel.text = speDetail.title;
    cell.selectionStyle = 0;
    [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:speDetail.albumCoverUrl290]];
    CGFloat newNum = [speDetail.playsCounts floatValue];
    cell.playCountLabel.text = [NSString stringWithFormat:@"▷%.1f万",newNum/10000 ];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpecialDetailViewController *speVC = [[SpecialDetailViewController alloc] init];
    SpecialDetailItemModel *model = self.speDetailArr[indexPath.row];
    speVC.bId = model.bId;
    [self.navigationController pushViewController:speVC animated:YES];
    [speVC release];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    scrollView = self.tableView;

//    if (newHight == 180+scrollView.contentOffset.y) {
//        newWight =oldWidth*newHight/oldHight;
//        self.headImageView.frame = CGRectMake(-(newWight-oldWidth)/2, 0, newWight, newHight);
//    }
    if (scrollView.contentOffset.y <0) {
        self.headImageView.frame = CGRectMake(-(WIDTH *(150-scrollView.contentOffset.y)/150-WIDTH)/2, 0,WIDTH *(150-scrollView.contentOffset.y)/150  , 150-scrollView.contentOffset.y);
    }else{
        self.headImageView.frame = CGRectMake( 0, -scrollView.contentOffset.y, WIDTH, 150);
    }
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
