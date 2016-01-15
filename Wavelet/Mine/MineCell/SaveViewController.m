//
//  SaveViewController.m
//  Wavelet
//
//  Created by dllo on 15/7/13.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "SaveViewController.h"
#import "SaveDataBase.h"
#import "saveCell.h"
#import "HTTPTool.h"
#import "saveModel.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@interface SaveViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *dataArr;
@property(nonatomic,retain)NSMutableArray *arr;
@property(nonatomic,retain)NSMutableArray *saveArr;
@end

@implementation SaveViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataArr = [NSMutableArray array];
        self.arr = [NSMutableArray array];
        self.saveArr = [ NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收藏";
    self.navigationController.navigationBar.translucent = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight =  80;
    [self.tableView release];
    
    self.dataArr = [[SaveDataBase shareSaveDataBase] selectspecialList];
    NSLog(@"%ld__123213",self.dataArr.count);
    [self create];
    
}


-(void)create{
    
    for (NSString *bIdStr in self.dataArr) {
        NSString *strUrl = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%@/true/1/15",bIdStr];
        [self.arr addObject:strUrl];
    }
    for (NSString *str in  self.arr) {
        [HTTPTool get:str body:nil httpResult:JSON success:^(id result) {
            NSDictionary *dic = result;
            NSDictionary *albumDic = dic[@"album"];
            saveModel *save = [[saveModel alloc] initWithDic:albumDic];
            [self.saveArr addObject:save];
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            NSLog(@"解析失败");
            
        }];
    }
    NSLog(@"%ld",self.saveArr.count);
    NSLog(@"---------------");
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.saveArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuse = @"reuse";
    saveCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[[saveCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse] autorelease];
        
    }
//    cell.textLabel.text = @"1";
    saveModel *save = self.saveArr[indexPath.row];
    [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:save.coverSmall]];
    cell.titleLabel.text = save.title;
    cell.tracksLabel.text = [NSString stringWithFormat:@"节目数:%@",save.tracks];
    return cell;
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
