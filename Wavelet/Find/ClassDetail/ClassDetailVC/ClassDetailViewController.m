//
//  ClassDetailViewController.m
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "ClassDetailViewController.h"
#import "MyCollectionViewCell.h"
#import "HTTPTool.h"
#import "MyItemModel.h"
#import "ClassDetailModel.h"
#import "UIImageView+WebCache.h"
#import "MyScrollViewModel.h"
#import "SpecialListViewController.h"
@interface ClassDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property(nonatomic,retain)UICollectionView * collectionView;
@property(nonatomic,retain)NSMutableArray * MyCollectArr;
@property(nonatomic,retain)UIScrollView * scrollView;
@property(nonatomic,retain)NSMutableArray * MyscrollArr;
@property(nonatomic,retain)MBProgressHUD * hud;
@end

@implementation ClassDetailViewController

-(void)dealloc
{
    [_collectionView release];
    [_MyCollectArr release];
    [_scrollView release];
    [_MyCollectArr release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    self.title = self.name;
#pragma mark 创建一个CollectionView
    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc] init];
    //设置item的大小
    
    flowLayout.itemSize=CGSizeMake(100*WIDTH/375, 100*HEIGHT/667);
    //设置行间距
    //设置边界距离
    flowLayout.sectionInset=UIEdgeInsetsMake(20  * HEIGHT/ 667,20  * WIDTH/ 375,20  * HEIGHT/ 667,20 * WIDTH/ 375 );
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, HEIGHT - 64 - 49) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor=[UIColor clearColor];

    [self.view addSubview:self.collectionView];
    //设置代理人
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
 
    //注册item
    [self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    //把collectView整体下移200
    self.collectionView.contentInset = UIEdgeInsetsMake(160, 0, 0, 0);
    [_collectionView release];
#pragma mark 创建轮播图的scrollView
    self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(20,-160, WIDTH-40, 160)];
    self.scrollView.delegate=self;
    //设置偏移量
    self.scrollView.contentOffset=CGPointMake(WIDTH-40, 0);
    //边界回弹
    self.scrollView.pagingEnabled=YES;
    
    [self.collectionView addSubview:self.scrollView];
    //设置自动跳转
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changePic) userInfo:nil repeats:YES];
    

    [self creatData];
    //设置加载的小菊花
    self.hud.backgroundColor = [UIColor yellowColor];
    self.hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode=MBProgressHUDModeIndeterminate;
}



-(void)changePic
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x+(WIDTH-40), 0) animated:YES];
    if (self.scrollView.contentOffset.x==(WIDTH-40)*(self.MyscrollArr.count-1)) {
        self.scrollView.contentOffset=CGPointMake(WIDTH-40, 0);
    }

}
#pragma mark 网络请求数据的方法
-(void)creatData
{
    NSString *classStr1 = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/category_tag_list?device=iphone&per_page=100&category=%@&type=album&page=1", self.category];

    [HTTPTool get:classStr1 body:nil httpResult:JSON success:^(id result) {
        //json解析
        NSDictionary * Dic=result;
        //    ClassDetailModel * detailModel=[[ClassDetailModel alloc] initWithDic:Dic];
        //
        NSMutableArray * list=Dic[@"list"];
        self.MyCollectArr=[NSMutableArray array];
        for (NSDictionary * tempDic in list) {
            MyItemModel * model=[[MyItemModel alloc] initWithDic:tempDic];
            [self.MyCollectArr addObject:model];
        }
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];

    
#pragma mark 轮播图的请求数据
    NSString *classStr2 = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/category_focus_image?categoryId=%@&version=3.33.1.1&device=android", self.categoryId];
    [HTTPTool get:classStr2 body:nil httpResult:JSON success:^(id result) {
        NSDictionary * Dic=result;
        NSMutableArray * listArr=Dic[@"list"];
        if (listArr.count == 0) {
            [self.scrollView removeFromSuperview];
            self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }else{
        self.MyscrollArr=[NSMutableArray array];
        for (NSDictionary * tempDic in listArr) {
            MyScrollViewModel * model=[[MyScrollViewModel alloc] initWithDic:tempDic];
            [self.MyscrollArr addObject:model];
            [model release];
        }
        [self.collectionView reloadData];
        //设置滚动范围
        [self.MyscrollArr addObject:self.MyscrollArr[0]];
        [self.MyscrollArr insertObject:self.MyscrollArr[self.MyscrollArr.count-2] atIndex:0];
        self.scrollView.contentSize=CGSizeMake(self.MyscrollArr.count*(WIDTH-40), 0);
        for (NSInteger i=0;i<self.MyscrollArr.count;i++) {
            //创建一个imageView
            UIImageView * imageView=[[UIImageView alloc] initWithFrame:CGRectMake((WIDTH-40)*i, 0, WIDTH-40, 200)];
            MyScrollViewModel * model=self.MyscrollArr[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"占位图"]];
            imageView.userInteractionEnabled=YES;
            [self.scrollView addSubview:imageView];
            [imageView release];
        }
        }
        [self.hud hide:YES];
        
    } failure:^(NSError *error) {
        
        
    }];
   
    
}
//轮播图的头尾滑动方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.scrollView.contentOffset.x==(WIDTH-40)*(self.MyscrollArr.count-1)) {
        self.scrollView.contentOffset=CGPointMake(WIDTH-40, 0);
        
    }else if(self.scrollView.contentOffset.x==0)
    {
        self.scrollView.contentOffset=CGPointMake((WIDTH-40)*(self.MyscrollArr.count-2), 0);
    }
        
}


//collectionView的协议方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.MyCollectArr.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell * cell=[self.collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    MyItemModel * model=self.MyCollectArr[indexPath.item];
    cell.label.text=model.tname;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.cover_path]];
    return cell;
}
//每个item的点击方法(跳转)
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SpecialListViewController *speVC = [[SpecialListViewController alloc] init];
    MyItemModel *model = self.MyCollectArr[indexPath.item];
    speVC.category_name = model.tname;
    speVC.ag_name = self.category;
    speVC.titleName = model.tname;
    [self.navigationController pushViewController:speVC animated:YES];
    [speVC release];
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
