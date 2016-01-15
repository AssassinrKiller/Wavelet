//
//  DownLoadViewController.m
//  Wavelet
//
//  Created by dlios on 15-7-8.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//
#import "DownLoadViewController.h"
#import "albumTableViewCell.h"
#import "downLoadcell.h"
#import "SpecialDetailModel.h"
@interface DownLoadViewController ()<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>

@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)UIView * headerView;
@property(nonatomic,retain)UIButton * changeButton;
@property(nonatomic,retain)UIButton * right;
@property(nonatomic,retain)UIButton * left;
@property(nonatomic,retain)UIButton * midButton;

//用来写数据的文件句柄对象
@property(nonatomic,strong)NSFileHandle * writeHandle;
//文件总大小
@property(nonatomic,assign)long long totalLength;
//已经写入文件的大小
@property(nonatomic,assign)long long currentLength;
//连接对象
@property(nonatomic,strong)NSURLConnection * connection;
//进度条
@property(nonatomic,retain)UIProgressView * progress;
//暂停开始下载
@property(nonatomic,retain)UIButton * startAndPause;
//用于判断的
@property(nonatomic,assign)BOOL isSound;

@property(nonatomic,retain)NSMutableArray * downFinishArr;
//下载歌曲存放的数组
@property(nonatomic,retain)NSMutableArray * downloadArr;


@end

@implementation DownLoadViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.downloadArr=[NSMutableArray array];
        self.downFinishArr=[NSMutableArray array];
        
    }
    return self;
}
-(void)dealloc
{
    [_tableView release];
    [_headerView release];
    [_right release];
    [_left release];
    [_midButton release];
    [_progress release];
    [_startAndPause release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatInterface];
    
//    AVAudioSessionCategoryMultiRoute
    
    
    // Do any additional setup after loading the view.
}
#pragma mark 视图创建部分
-(void)creatInterface
{
    //创建导航栏的3个button
    self.right=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.right setTitle:@"下载" forState:UIControlStateNormal];
    self.right.frame=CGRectMake(0, 0, 80, 30);
    self.right.titleLabel.font=[UIFont systemFontOfSize:18];
    [self.right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationController.navigationBar.translucent=NO;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.right];
    [self.right addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.left=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.left setTitle:@"专辑" forState:UIControlStateNormal];
    self.left.frame=CGRectMake(0, 0, 80, 30);
    self.left.titleLabel.font=[UIFont systemFontOfSize:18];
    [self.left setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.left];
    [self.left addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
   
    
   self.midButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.midButton setTitle:@"声音" forState:UIControlStateNormal];
    self.midButton.frame=CGRectMake(0, 0, 80, 30);
    self.midButton.titleLabel.font=[UIFont systemFontOfSize:18];
    [self.midButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.titleView=self.midButton;
    [self.midButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //创建tableView;
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
//    self.tableView.separatorStyle=0;
    [self.view addSubview:self.tableView];
    [_tableView release];
    //创建headerView
    self.headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    
    UIButton * clearButton=[UIButton buttonWithType:UIButtonTypeSystem];
    clearButton.frame=CGRectMake(0, 0, 100, 30);
    clearButton.center=CGPointMake(3*self.headerView.frame.size.width/4, self.headerView.frame.size.height/2);
    
    [clearButton setTitle:@"一建清空" forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.headerView addSubview:clearButton];
    self.changeButton=[UIButton buttonWithType:UIButtonTypeSystem];
    self.changeButton.frame=CGRectMake(0, 0, 100, 30);
    self.changeButton.center=CGPointMake(self.headerView.frame.size.width/4, self.headerView.frame.size.height/2);
    
    [self.headerView addSubview:self.changeButton];
    self.tableView.tableHeaderView=self.headerView;
    
    //下载暂停开始的button
    self.startAndPause=[UIButton buttonWithType:UIButtonTypeCustom];
    self.startAndPause.frame=CGRectMake(0, 0, 20, 20);
    [self.startAndPause setImage:[UIImage imageNamed:@"plause"] forState:UIControlStateNormal];
    [self.startAndPause addTarget:self action:@selector(startAndPause:) forControlEvents:UIControlEventTouchUpInside];
    //创建进度条
    self.progress=[[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progress.frame=CGRectMake(0, 0, 200, 20);
    self.progress.progressTintColor=[UIColor orangeColor];
    
    

}
#pragma mark 导航栏上的点击方法
-(void)clickButton:(UIButton*)button
{
    if (button==self.left) {
        [self.left setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.midButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.changeButton setTitle:@"" forState:UIControlStateNormal];
        self.headerView.hidden=NO;
        
    }else if (button==self.right) {
        [self.right setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.left setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.midButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.headerView.hidden=YES;
        
    }else
    {
        self.headerView.hidden=NO;
        [self.midButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.left setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.changeButton setTitle:@"手动排序" forState:UIControlStateNormal];
        [self.changeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
#pragma mark tableView的协议方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSound==YES) {
        return 100;
    }else{
        return 120;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isSound==YES) {
        return self.downFinishArr.count;
    }else{
        return self.downloadArr.count;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSound==YES) {
        static NSString * reuse=@"reuse";
        albumTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:reuse];
        if (!cell) {
            cell=[[[albumTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse] autorelease];
        }
        return cell;
 
    }else{
        static NSString * reuse=@"Reuse";
        downLoadcell * cell=[tableView dequeueReusableCellWithIdentifier:reuse];
        if (!cell) {
            cell=[[[downLoadcell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse] autorelease];
        }
        
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark 有关下载的方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"缓存失败");
}
/**
 *  接收到服务器就会响应调用
 *
 *  @param connection
 *  @param didReceiveMemoryWarning
 */
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{

    if (self.currentLength) return;
    // 文件路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filepath = [caches stringByAppendingPathComponent:@"audio.zip"];
    
    // 创建一个空的文件 到 沙盒中
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr createFileAtPath:filepath contents:nil attributes:nil];
    
    // 创建一个用来写数据的文件句柄
    self.writeHandle = [NSFileHandle fileHandleForWritingAtPath:filepath];
    
    // 获得文件的总大小
    self.totalLength = response.expectedContentLength;

}
/**
 *  2.当接收到服务器返回的实体数据时调用（具体内容，这个方法可能会被调用多次）
 *
 *  @param data       这次返回的数据
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // 移动到文件的最后面
    [self.writeHandle seekToEndOfFile];
    
    // 将数据写入沙盒
    [self.writeHandle writeData:data];
    
    // 累计文件的长度
    self.currentLength += data.length;
    
    self.progress.progress = (double)self.currentLength/ self.totalLength;
}

/**
 *  3.加载完毕后调用（服务器的数据已经完全返回后）
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.currentLength = self.currentLength;
    self.totalLength = self.currentLength;
    
    // 关闭文件
    [self.writeHandle closeFile];
    self.writeHandle = nil;
}

#pragma mark 断点缓存的点击方法
-(void)startAndPause:(UIButton *)button
{
    // 状态取反
    button.selected = !button.isSelected;
    
    // 断点续传
    // 断点下载
    
    if (button.selected) { // 继续（开始）下载
        // 1.URL
        NSURL *url = [NSURL URLWithString:@"http://upload.pianke.me/old/newuploads/6ee646c04f0543913bd213af30c75e55.mp3"];
        
        // 2.请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        // 设置请求头
        NSString *range = [NSString stringWithFormat:@"bytes=%lld-", self.currentLength];
        [request setValue:range forHTTPHeaderField:@"Range"];
        
        // 3.下载(创建完conn对象后，会自动发起一个异步请求)
        self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    } else { // 暂停
        [self.connection cancel];
        self.connection = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
