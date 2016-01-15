//
//  SpecialDetailViewController.m
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "SpecialDetailViewController.h"
#import "SpecialListModel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "HTTPTool.h"
#import "SpecialDetailModel.h"
#import "specialDetailCell.h"
#import "introduceModel.h"
#import "introduceCell.h"
#import "releteDeCell.h"
#import "MJRefresh.h"
#import "PlayMusicViewController.h"
#import "DownLoadViewController.h"
#import "SaveDataBase.h"

@interface SpecialDetailViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate, UIAlertViewDelegate>
@property(nonatomic,retain)UITableView *detailTableView;

@property(nonatomic,retain)UIImageView *headImageView;

@property(nonatomic,retain)NSMutableArray *speciaDetailArr;
@property(nonatomic,retain)NSMutableArray *introArr;

@property(nonatomic,assign)NSInteger tagNumber;

@property(nonatomic,retain)UISegmentedControl *seg;
//@property(nonatomic,retain)UIImageView *smallImageView;
//
//@property(nonatomic,retain)UIImageView *coverSmallImageView;

@property(nonatomic,retain)UIButton *smallButton;
@property(nonatomic,retain)UIButton *coverSmallButton;
@property(nonatomic,retain)UILabel *coverSmallLabel;
@property(nonatomic,retain)NSMutableArray *releteArr;
@property(nonatomic,retain)MBProgressHUD *HUD;
@property(nonatomic,assign)NSInteger pageId;
@property(nonatomic,assign)NSInteger maxPageId;
@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,assign)NSInteger clickDownLoadBu;
@property(nonatomic,retain)NSMutableArray *dataArr;
@end

@implementation SpecialDetailViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.speciaDetailArr = [NSMutableArray array];
        self.introArr = [NSMutableArray array];
        self.releteArr = [NSMutableArray array];
        self.dataArr = [NSMutableArray array];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.translucent = NO;
    self.dataArr= [[SaveDataBase shareSaveDataBase] selectspecialList];
    [self creatView];
    
   
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
    
- (void)creatView{
    self.detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 113) style:UITableViewStylePlain];
    self.detailTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.detailTableView];
    self.detailTableView.separatorStyle = 0;
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
//    self.detailTableView.rowHeight = 100;
    [self.detailTableView release];
//    self.detailTableView.sectionIndexBackgroundColor = [UIColor grayColor];
    

    UIView *headBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -200, self.view.frame.size.width, 300)];
//    [self.view addSubview:self.headImageView];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.specialMD.coverMiddle] ];
    [headBackView addSubview:self.headImageView];
    [self.headImageView release];
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *view1 = [[UIVisualEffectView alloc] initWithEffect:blur];
    view1.alpha = 0.3;
    view1.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
    [self.headImageView addSubview:view1];
    [view1 release];
    

    
    self.smallButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.smallButton.backgroundColor = [UIColor clearColor];
    self.smallButton.frame = CGRectMake(130, 220, 20, 20);
    [self.headImageView addSubview:self.smallButton];
    self.smallButton.layer.cornerRadius = 10;
    self.smallButton.layer.masksToBounds = YES;
    
    self.coverSmallButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.coverSmallButton.backgroundColor = [UIColor clearColor];
    [self.headImageView addSubview:self.coverSmallButton];
    self.coverSmallButton.frame = CGRectMake(40, 220, 60, 60);
    
    self.coverSmallLabel = [[UILabel alloc] initWithFrame:CGRectMake(155, 220, 100, 15)];
    [self.headImageView addSubview:self.coverSmallLabel];
    self.coverSmallLabel.textColor = [UIColor clearColor];
    [self.coverSmallLabel release];
    
    UIImageView *saveImageView = [[UIImageView alloc] initWithFrame:CGRectMake(130, 260, 15, 15)];
    [self.headImageView addSubview:saveImageView];
    saveImageView.image  = [UIImage imageNamed:@"iconfont-favorfill"];
    [saveImageView release];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    saveButton.frame = CGRectMake(150, 260, 60, 15);
    saveButton.titleLabel.textColor = [UIColor clearColor];
    [saveButton setTitle:@"收藏专辑" forState: UIControlStateNormal];
    [self.headImageView addSubview:saveButton];
    [saveButton addTarget:self action:@selector(saveclick:) forControlEvents:UIControlEventValueChanged];
    
    for (NSString  * str in self.dataArr) {
        
        if ([[NSString stringWithFormat:@"%@", str] isEqualToString:[NSString stringWithFormat:@"%@",self.bId]]) {
            [saveButton setTitle:@"已经收藏" forState: UIControlStateNormal];
            break;
        }
    }
    
    
    
    
    
    self.detailTableView.tableHeaderView = headBackView;
    
    //出事状态
    self.tagNumber = 1;
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    self.HUD.delegate = self;
    [self.HUD show:YES];
    [self creatData];
    
    

    [self.detailTableView addFooterWithCallback:^{
        if (self.pageId < self.maxPageId) {
            self.pageId++;
            [self footRefresh];
            
        }else{
            [self.detailTableView footerEndRefreshing];
//            self.detailTableView.headerHidden = YES;
        }
    }];
}

-(void)footRefresh{
    NSString *str =[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%@/true/%ld/%ld",self.bId,(long)self.pageId,(long)self.pageSize];
    [HTTPTool get:str body:nil httpResult:HTTP success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:0 error:nil];
        NSDictionary *tracksDic = dic[@"tracks"];
        NSMutableArray *listArr = tracksDic[@"list"];
        for (NSDictionary *tempDic in listArr) {
            SpecialDetailModel *specialModel  = [[SpecialDetailModel alloc] initWithDic:tempDic];
            [self.speciaDetailArr addObject:specialModel];
            
        }
        [self.detailTableView reloadData];
//        if (self.pageId < self.maxPageId) {
//            self.detailTableView.headerHidden = NO;
//        }else{
//            self.detailTableView.headerHidden = YES;
//        }
//
        if (self.pageId ==self.maxPageId) {
          self.detailTableView.headerHidden = YES;
        }
        [self.detailTableView footerEndRefreshing];
      
        
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"解析失败");
    }];
    
}



  




-(void)creatData{
    NSString *strUrl = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%@/true/1/15",self.bId];
    [HTTPTool  get:strUrl body:nil httpResult:HTTP success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dicTracks = dic[@"tracks"];
        self.maxPageId = [dicTracks[@"maxPageId"]integerValue];
        self.pageId = [dicTracks[@"pageId"] integerValue];
        self.pageSize = [dicTracks[@"pageSize"]integerValue];
        
        NSArray *listArr = dicTracks[@"list"];
        for (NSDictionary *tempDic in listArr) {
            SpecialDetailModel *specialDetail = [[SpecialDetailModel alloc] initWithDic:tempDic];
            [self.speciaDetailArr addObject:specialDetail];
        }
        NSDictionary *albumDic = dic[@"album"];
        introduceModel  *specialD = [[introduceModel alloc] initWithDic:albumDic];
        [self.introArr addObject:specialD];
        
//        self.pageId = 1;
      
        [self.smallButton sd_setBackgroundImageWithURL:[NSURL URLWithString:albumDic[@"avatarPath"]] forState:UIControlStateNormal];
        [self.coverSmallButton sd_setBackgroundImageWithURL:[NSURL URLWithString:albumDic[@"coverSmall"]] forState:UIControlStateNormal];
        
        self.coverSmallLabel.text = albumDic[@"nickname"];
        
        
        [self.detailTableView reloadData];
       
//        [self.HUD hide:YES];
        [self.HUD removeFromSuperview];
    } failure:^(NSError *error) {
        NSLog(@"22");
        
    }];
    
    //相关页面数据解析
    NSString *strlUrl = [NSString stringWithFormat:@"http://ar.ximalaya.com/rec-association/recommend/album/by_album?albumId=%@&device=android",self.bId];
    NSLog(@"%@",strlUrl);
    [HTTPTool get:strlUrl body:nil httpResult:HTTP success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSArray *albumsArr = dic[@"albums"];
        for (NSDictionary *tempDic in albumsArr) {
            SpecialListModel *speModel = [[SpecialListModel alloc] initWithDic:tempDic];
            [self.releteArr addObject:speModel];
        }
        
        [self.detailTableView reloadData];
    } failure:^(NSError *error) {
        
        NSLog(@"333");
    }];
    
    
    
    
    
}

-(void)saveclick:(UIButton *)button{
    NSLog(@"_________-------");
    [[SaveDataBase shareSaveDataBase] openDB];
    [[SaveDataBase shareSaveDataBase] createTable];
    if ([[SaveDataBase shareSaveDataBase] insertSpecialListModel:self.bId]) {
        [button setTitle:@"已经收藏" forState: UIControlStateNormal];
    }else{
        [[SaveDataBase shareSaveDataBase] deleteSpecialList:self.bId];
        [button setTitle:@"收藏专辑" forState: UIControlStateNormal];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tagNumber == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 40, 0)];
        introduceModel *introduce = self.introArr[indexPath.row];
        label.text =introduce.intro;
        label.numberOfLines = 0;
        [label sizeToFit];
        return 150 + label.frame.size.height;
    }else if (self.tagNumber ==1){
        return 120;
    }else{
        return 80;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *sectionBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    sectionBackView.backgroundColor = [UIColor clearColor];
    
    UIView *sectionView  =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 50)];
    sectionView.backgroundColor  = [UIColor colorWithRed:47 / 255.0 green:79 / 255.0 blue:100 / 255.0 alpha:1];
    
    self.seg = [[UISegmentedControl alloc] initWithItems:@[@"简介",@"排序",@"相关专辑"]];
    [sectionView addSubview:self.seg];
    self.seg.frame =CGRectMake(10,10 , self.view.frame.size.width-20,30);
    [self.seg addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    self.seg.selectedSegmentIndex = self.tagNumber;
    
    self.seg.tintColor = [UIColor clearColor];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName,  [UIColor whiteColor], NSForegroundColorAttributeName,nil];
    [self.seg setTitleTextAttributes:dic forState:UIControlStateNormal];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:17],NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName,nil];
    [self.seg setTitleTextAttributes:dic1 forState:UIControlStateSelected];
    
    [sectionBackView addSubview:sectionView];
    return sectionBackView;

}




//协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.tagNumber ==0) {
        return self.introArr.count;
    }else if (self.tagNumber==1){
       return self.speciaDetailArr.count;
    }else{
        return self.releteArr.count;
    }
    
    
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tagNumber == 0) {
        static NSString *reuse1 = @"reuse1";
        introduceCell *cell1 = [tableView dequeueReusableCellWithIdentifier:reuse1];
        if (!cell1) {
            cell1  = [[[introduceCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1] autorelease];
        }
        cell1.selectionStyle = 0;
        introduceModel *introduce = self.introArr[indexPath.row];
       cell1.label1.text =@"简介:";
        cell1.introduceLabel.text =introduce.intro;
        return  cell1;
    }else if (self.tagNumber ==1){
        static NSString *reuse = @"reuse";
        specialDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        if (!cell) {
            cell = [[[specialDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse] autorelease];
        }
        cell.selectionStyle = 0;
        SpecialDetailModel *specialDetail = self.speciaDetailArr[indexPath.row];
        [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:specialDetail.coverLarge]];
        cell.titleLabel.text =specialDetail.title;
        cell.midLabel.text =[NSString stringWithFormat:@"by%@",specialDetail.nickname];
        CGFloat a = [specialDetail.playtimes floatValue];
        a/=10000;
        cell.playCountLabel.text = [NSString stringWithFormat:@"▷%0.1f万",a ];
        
        cell.likeLavel.text = [NSString stringWithFormat:@"♡%@",specialDetail.likes];
        cell.comImageView.image = [UIImage imageNamed:@"iconfont-comment.png"];
        cell.commentsLabel.text = [NSString stringWithFormat:@"%@",specialDetail.comments];
        cell.downLoadView.tag = indexPath.row + 1000;
        [cell.downLoadView addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        return cell;

    }else{
        static NSString *reuse2 = @"reuse2";
         releteDeCell *cell2 = [tableView dequeueReusableCellWithIdentifier:reuse2];
        if (!cell2) {
            cell2 = [[[releteDeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse2] autorelease];
            
        }
        cell2.selectionStyle = 0;
        SpecialListModel *specialModel = self.releteArr[indexPath.row];
        [cell2.leftImageView sd_setImageWithURL:[NSURL URLWithString:specialModel.coverSmall]];
        cell2.titleLabel.text = specialModel.title;
        cell2.chanelLabel.text = [NSString stringWithFormat:@"节目数 %ld",specialModel.tracks];
        
        return cell2;
    }
}
- (void)click:(UIButton *)button
{
    self.clickDownLoadBu = button.tag - 1000;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否添加任务到下载列表" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        SpecialDetailModel *specialDetail = self.speciaDetailArr[self.clickDownLoadBu];
        DownLoadViewController *downVC = [[DownLoadViewController alloc] init];
        downVC.downLoadInfo = specialDetail;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tagNumber == 1) {
        SpecialDetailModel *model = self.speciaDetailArr[indexPath.row];
        PlayMusicViewController *playVC = [[PlayMusicViewController alloc] init];
        playVC.playAlbumId = model.albumId;
        self.modalTransitionStyle = 0;
        [self presentViewController:playVC animated:YES completion:^{}];
        [playVC release];
    }else if (self.tagNumber == 2){
        SpecialListModel *model = self.releteArr[indexPath.row];
        SpecialDetailViewController *speVC = [[SpecialDetailViewController alloc] init];
        speVC.bId = model.albumId;
        [self.navigationController pushViewController:speVC animated:YES];
        [speVC release];

    }
}

-(void)segAction:(UISegmentedControl *)seg {

    if (self.seg.selectedSegmentIndex == 0) {
        self.tagNumber = 0;
    }else if (self.seg.selectedSegmentIndex ==1){
        self.tagNumber = 1;
    }else if (self.seg.selectedSegmentIndex == 2){
        self.tagNumber = 2;
    }
    [self.detailTableView reloadData];
    
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