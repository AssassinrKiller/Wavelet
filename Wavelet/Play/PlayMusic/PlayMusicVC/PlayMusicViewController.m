//
//  PlayMusicViewController.m
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "PlayMusicViewController.h"
#import "playLeftTableMd.h"
#import "playRightTableMd.h"
#import "RightTableCell.h"
#import "playTableModel.h"
#import "PlayMusicModel.h"
#import "playTableCell.h"
#import "MyPlayer.h"
#import "PlayView.h"

@interface PlayMusicViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)UIView * headerView;
@property(nonatomic,retain)UIImageView * imageView;
@property(nonatomic,retain)UIScrollView * scrollView;
@property(nonatomic,retain)UIView * playView;
@property(nonatomic,retain)UITableView * leftTableView;
@property(nonatomic,retain)UITableView * rightTableView;
@property(nonatomic,retain)UIImageView * smallView;
@property(nonatomic,retain)UIView * SmallBackView;
//给左右两个tableView赋值的数组
@property(nonatomic,retain)NSMutableArray * leftTbArr;
@property(nonatomic,retain)NSMutableArray * righeTbArr;
//给scrollView赋值的字典
@property(nonatomic,retain)NSMutableDictionary * userInfo;
//播放
@property(nonatomic,retain)UIButton * playButton;
//上一曲
@property(nonatomic,retain)UIButton * leftButton;
//下一曲
@property(nonatomic,retain)UIButton * rightButton;
//播放历史
@property(nonatomic,retain)UIButton * historyButton;
//收藏
@property(nonatomic,retain)UIButton * zanButton;
//用于判断播放状态的属性
@property(nonatomic,assign)BOOL isPlay;
//播放进度条
@property(nonatomic,retain)UISlider * playSlider;
//进度更新时间
@property(nonatomic,retain)NSTimer * timer;
//
@property(nonatomic,retain)AVPlayerItem * avItem;
//
@property(nonatomic,assign)float  currentValue;

@property(nonatomic,copy)NSString *trackIdStr;

@property(nonatomic,retain)NSIndexPath *musicIndex;
//
@property(nonatomic,retain)UIButton * alblumButton;
@property(nonatomic,retain)UIButton * alockButton;
@property(nonatomic,retain)UILabel * midLabel;
@property(nonatomic,copy)NSNumber * albumId;

@property(nonatomic,retain)CABasicAnimation *animation;
//

@end

@implementation PlayMusicViewController

+(PlayMusicViewController *)sharePlayMusicVC
{
    static PlayMusicViewController * PlayerMusicVC=nil;
    if (PlayerMusicVC == nil) {
       PlayerMusicVC=[[PlayMusicViewController alloc] init];
    }
    return PlayerMusicVC;
}

-(void)dealloc
{
    [_headerView release];
    [_imageView release];
    [_scrollView release];
    [_playView release];
    [_leftTableView release];
    [_rightTableView release];
    [_leftTbArr release];
    [_righeTbArr release];
    [_userInfo release];
    [_SmallBackView release];
    [super dealloc];
    
}
#pragma mark 初始化方法
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.leftTbArr=[NSMutableArray array];
        self.righeTbArr=[NSMutableArray array];
        self.userInfo=[NSMutableDictionary dictionary];
        if ([MyPlayer sharePlayer].rate == 0) {
            self.isPlay = NO;
        }else{
            self.isPlay = YES;
        }
        self.avItem= [[AVPlayerItem alloc] initWithURL:nil];
        self.trackIdStr = [NSString string];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:YES];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}
-(BOOL)canBecomeFirstResponder
{
    return YES;
}
-(void)viewDidAppear:(BOOL)animated
{
   [self turn];
   self.navigationController.navigationBar.hidden=YES;
   self.tabBarController.tabBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(Timer) userInfo:nil repeats:YES];
    //创建播放界面
    [self creatInterface];
    self.SmallBackView.hidden=YES;
    //网络请求
    [self netWorkingState];
    
    
    
}
-(void)netWorkingState
{
    AFNetworkReachabilityManager * manager=[AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status==1||status==2) {
            [self leftNetWorking];
        }else{
            [self readCaches];
        }
        
    }];

    [manager stopMonitoring];
}
-(id)readCaches
{
    NSArray * sandBox=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, 1, YES);
    NSString * sandBoxPath=sandBox[0];
    NSString * cachesPath=[sandBoxPath stringByAppendingPathComponent:@"result.plist"];
    //反归档
    id result=[NSKeyedUnarchiver unarchiveObjectWithFile:cachesPath];
    
    
    return result;
}

-(void)sliderAction:(UISlider*)slider
{
    float current=slider.value;
   float  newCurrent=current* CMTimeGetSeconds(self.avItem.duration);
    [[MyPlayer sharePlayer] seekToTime:CMTimeMakeWithSeconds(newCurrent, 1000000)];
    [[MyPlayer sharePlayer] play];



    self.timer.fireDate =[NSDate distantPast];
//    NSLog(@"%g",newCurrent);

}
-(void)turn
{
    if ([MyPlayer sharePlayer].rate==1) {
        self.animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        self.animation.fromValue=[NSNumber numberWithFloat:0.0];
        self.animation.toValue=[NSNumber numberWithFloat:2 *M_PI];
        self.animation.duration=10;
        self.animation.repeatCount=HUGE_VALF;
        NSArray *arr = [[PlayView sharePlayView] subviews];
        UIButton *bu = arr[0];
        [bu.layer addAnimation:self.animation forKey:@"rotation"];
        [self.smallView.layer addAnimation:self.animation forKey:@"rotation"];
        
//        NSLog(@"-------%@", [self.smallView.layer animationKeys]);
//        NSLog(@"+++++++%@", [[PlayView sharePlayView]->button.layer animationKeys]);
//        NSLog(@"*******%@", [PlayView sharePlayView]->button);
    }else{
//        self.animation.removedOnCompletion = NO;
//        [self.smallView animationDidStop:self.animation finished:YES];
        [self.smallView.layer removeAnimationForKey:@"rotation"];
        NSArray *arr = [[PlayView sharePlayView] subviews];
        UIButton *bu = arr[0];
        [bu.layer removeAnimationForKey:@"rotation"];
    }

}
- (void)Timer
{
    self.avItem=[MyPlayer sharePlayer].currentItem;
    self.playSlider.value = CMTimeGetSeconds(self.avItem.currentTime) / CMTimeGetSeconds(self.avItem.duration);
    if (CMTimeGetSeconds(self.avItem.currentTime) == CMTimeGetSeconds(self.avItem.duration)) {
        [self nextSong];
    }
}

#pragma mark 播放的方法
-(void)playMusic
{
    if (self.isPlay==NO) {
           //添加通知
        [[MyPlayer sharePlayer] play];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.avItem];
        [self.playButton setImage:[UIImage imageNamed:@"plause"] forState:UIControlStateNormal];
        
        //开启
        
        [self turn];
        
        self.timer.fireDate =[NSDate distantPast];
        
        self.isPlay=YES;
           
        }else if(self.isPlay==YES){
            
            [[MyPlayer sharePlayer] pause];
            self.isPlay=NO;
            //暂停
            self.timer.fireDate = [NSDate distantFuture];
            [self.playButton setImage:[UIImage imageNamed:@"iconfont-bofang"] forState:UIControlStateNormal];
            [self.smallView.layer removeAnimationForKey:@"rotation"];
        }
    
    
}

-(void)playFinished:(NSNotification*)nstification
{
    [self nextSong];
}


//下一曲的方法
-(void)nextSong
{
    if (self.leftTbArr.count-1!=self.musicIndex.row) {
        NSIndexPath * newpath=[NSIndexPath indexPathForRow:self.musicIndex.row+1 inSection:self.musicIndex.section];
        self.musicIndex=newpath;
        [self tableView:self.leftTableView didSelectRowAtIndexPath:self.musicIndex];
        [self.leftTableView selectRowAtIndexPath:self.musicIndex animated:YES scrollPosition:2];
    }
    [self turn];
}
//上一曲的方法
-(void)backSong
{
    if (0 != self.musicIndex.row) {
        NSIndexPath * newpath=[NSIndexPath indexPathForRow:self.musicIndex.row-1 inSection:self.musicIndex.section];
        self.musicIndex=newpath;
        [self tableView:self.leftTableView didSelectRowAtIndexPath:self.musicIndex];
        [self.leftTableView selectRowAtIndexPath:self.musicIndex animated:YES scrollPosition:2];
    }
    [self turn];
}

-(void)rightTVappear
{
  if (self.scrollView.contentOffset.x!=WIDTH*2) {
      [self.scrollView setContentOffset:CGPointMake(WIDTH*2, 0) animated:YES];
      [self.alockButton setImage:[UIImage imageNamed:@"rightxia"] forState:UIControlStateNormal];
   }else{
          [self.scrollView setContentOffset:CGPointMake(WIDTH, 0) animated:YES];
       [self.alockButton setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
       
  }
}
-(void)leftTVappear
{
    if (self.scrollView.contentOffset.x!=0) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(WIDTH, 0) animated:YES];
    
    }
    

}

-(void)collection:(UIButton*)button
{
    playRightTableMd * model=self.righeTbArr[button.tag];
    NSLog(@"%@",model.title);
}











//给avplayerItem添加监控
-(void)addObserverToPlayerItem:(AVPlayerItem *)playerItem{
    //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
    [[MyPlayer sharePlayer] addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载情况属性
    [self.avItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem{
    [self.avItem removeObserver:self forKeyPath:@"status"];
    [self.avItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}
/**
 *  通过KVO监控播放器状态
 *
 *  @param keyPath 监控属性
 *  @param object  监视器
 *  @param change  状态改变
 *  @param context 上下文
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    AVPlayerItem *playerItem=object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){
            NSLog(@"正在播放...，视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array=playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        NSLog(@"共缓冲：%.2f",totalBuffer);
        //
    }
}



#pragma mark 创建播放界面
-(void)creatInterface
{
    //设置毛玻璃效果
    self.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,WIDTH, HEIGHT)];
    self.imageView.userInteractionEnabled = YES;
    self.imageView.image=[UIImage imageNamed:@"backImage"];

    [self.view addSubview:self.imageView];
    //设置毛玻璃效果;
    UIBlurEffect * blur=[UIBlurEffect effectWithStyle:1];
    //创建毛玻璃view
    UIVisualEffectView * blurView=[[UIVisualEffectView alloc] initWithEffect:blur];
    blurView.frame=CGRectMake(0, 0, WIDTH,HEIGHT);
    [self.imageView addSubview:blurView];
    //创建小图片
    //
    
    self.smallView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"最终幻想"]];
    self.smallView.frame=CGRectMake(0, 0, 240*WIDTH/375,240*WIDTH/375);
//    self.smallView.center=CGPointMake(130*WIDTH/375,130*HEIGHT/667);
    self.smallView.layer.cornerRadius=240*WIDTH/375/2;
    self.smallView.layer.masksToBounds=YES;

    self.SmallBackView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 260*WIDTH/375, 260*WIDTH/375)];
    self.SmallBackView.backgroundColor=[UIColor colorWithRed:0.380 green:0.370 blue:0.363 alpha:1.000];
    
    self.SmallBackView.layer.cornerRadius=130*WIDTH/375;
    self.SmallBackView.center=CGPointMake(WIDTH/2,250*HEIGHT/667);
    self.smallView.center = CGPointMake(self.SmallBackView.frame.size.width/2, self.SmallBackView.frame.size.height / 2);
    [self.SmallBackView addSubview:self.smallView];
    [self.view addSubview:self.SmallBackView];
#pragma mark 创建scrollView
    self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0,80*WIDTH/375,WIDTH,350*HEIGHT/667)];
    self.scrollView.contentSize=CGSizeMake(WIDTH*3,0);
    self.scrollView.contentOffset=CGPointMake(WIDTH, 0);
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled=YES;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.scrollView];
    
    //scrollView中的左边的tableView
    self.leftTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0,WIDTH, 330*HEIGHT/667) style:UITableViewStylePlain];
    self.leftTableView.backgroundColor= [UIColor clearColor];
    self.leftTableView.delegate=self;
    self.leftTableView.dataSource=self;
    [self.scrollView addSubview:self.leftTableView];
    
    
    //scrollView中的右边的tableView
    self.rightTableView=[[UITableView alloc] initWithFrame:CGRectMake(WIDTH*2, 0, WIDTH, 330*HEIGHT/667) style:UITableViewStylePlain];
    self.rightTableView.backgroundColor=[UIColor clearColor];
    self.rightTableView.rowHeight=50*WIDTH/375;
    self.rightTableView.delegate=self;
    self.rightTableView.dataSource=self;
    [self.scrollView addSubview:self.rightTableView];
    
    //设置playView
    self.playView=[[UIView alloc] initWithFrame:CGRectMake(5,550*HEIGHT/667,WIDTH-10, 60*HEIGHT/667)];
    self.playView.backgroundColor = [UIColor clearColor];
//    self.playView.layer.cornerRadius=10;
//    self.playView.layer.borderWidth=1;
    [self.view addSubview:self.playView];
    
    //设置进度条
    self.playSlider=[[UISlider alloc] initWithFrame:CGRectMake(20*WIDTH/375,520 * HEIGHT / 667, 335*WIDTH/375, 10)];
    self.playSlider.minimumTrackTintColor = [UIColor greenColor];
    [self.playSlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.playSlider];
    [_playSlider release];
#pragma  mark 创建播放功能的button
    //播放或暂停
    self.playButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.playButton.frame=CGRectMake(0,0,45,45);
    self.playButton.center=CGPointMake(self.playView.frame.size.width/2, self.playView.frame.size.height/2);
    [self.playView addSubview:self.playButton];
    if (self.isPlay) {
        [self.playButton setImage:[UIImage imageNamed:@"plause"] forState:UIControlStateNormal];
    }else{
        [self.playButton setImage:[UIImage imageNamed:@"iconfont-bofang"] forState:UIControlStateNormal];
    }
    [self.playButton addTarget:self action:@selector(playMusic) forControlEvents:UIControlEventTouchUpInside];
    //上一曲
    self.leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame=CGRectMake(0, 0,25,25);
    self.leftButton.center=CGPointMake(WIDTH/2-WIDTH/4, self.playView.frame.size.height/2);
    [self.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(backSong) forControlEvents:UIControlEventTouchUpInside];
    [self.playView addSubview:self.leftButton];
    //下一曲
    self.rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame=CGRectMake(0, 0,25,25);
    self.rightButton.center=CGPointMake(WIDTH-WIDTH/2+WIDTH/4, self.playView.frame.size.height/2);
    [self.rightButton  setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(nextSong) forControlEvents:UIControlEventTouchUpInside];
    [self.playView addSubview:self.rightButton];
    
//    //历史播放
//    self.historyButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    self.historyButton.frame=CGRectMake(0,0,20,20);
//    self.historyButton.center=CGPointMake(20, self.playView.frame.size.height/2);
//    [self.historyButton setImage:[UIImage imageNamed:@"iconfont-lishi"] forState:UIControlStateNormal];
//    [self.playView addSubview:self.historyButton];
//    
//    //收藏
//    self.zanButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    self.zanButton.frame=CGRectMake(0,0,20,20);
//    self.zanButton.center=CGPointMake(WIDTH-30, self.playView.frame.size.height/2);
//    [self.zanButton setImage:[UIImage imageNamed:@"iconfont-zan"] forState:UIControlStateNormal];
//    [self.playView addSubview:self.zanButton];
    
    
    
    
#pragma mark 设置头视图
    //设置头视图
    self.headerView=[[UIView alloc] initWithFrame:CGRectMake(10,20,WIDTH-20,60*HEIGHT/667)];
    
    [self.view addSubview:self.headerView];
    self.alblumButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.alblumButton.frame=CGRectMake(10,20, 25,25);
    
    [self.alblumButton setImage:[UIImage imageNamed:@"iconfont-liebiao"] forState:UIControlStateNormal];
    [self.alblumButton addTarget:self action:@selector(leftTVappear) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.alblumButton];
    self.alockButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.alockButton.frame=CGRectMake(self.headerView.frame.size.width-30,20, 25,25);
    [self.alockButton setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [self.alockButton addTarget:self action:@selector(rightTVappear) forControlEvents:UIControlEventTouchUpInside];
    

    [self.headerView addSubview:self.alockButton];
    
    self.midLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0,200*WIDTH/375, 40*HEIGHT/667)];
    self.midLabel.center=CGPointMake(self.headerView.frame.size.width/2, self.headerView.frame.size.height/2);
    self.midLabel.textAlignment=1;
    [self.headerView addSubview:self.midLabel];
    
    


}
#pragma mark 网络请求的方法
-(void)leftNetWorking
{
    
    //leftTableView的数据请求
    [HTTPTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/playlist/album?albumId=%@&device=iPhone", self.playAlbumId] body:nil httpResult:JSON success:^(id result) {
    
        NSArray * sandBox=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, 1, YES);
        NSString * sandBoxPath=sandBox[0];
        NSString * cachesPath=[sandBoxPath stringByAppendingPathComponent:@"result.plist"];
        //归档
        [NSKeyedArchiver archiveRootObject:result toFile:cachesPath];
        
        NSDictionary * Dic=result;
        NSMutableArray * data=Dic[@"data"];
    for (NSDictionary * tempDic in data) {
    
        playLeftTableMd * model=[[playLeftTableMd alloc] init];
        [model setValuesForKeysWithDictionary:tempDic];
        [self.leftTbArr addObject:model];
      }
        playLeftTableMd *model = self.leftTbArr[0];
        [self.leftTableView reloadData];
        self.trackIdStr = model.trackId;
        [self rightNetWorking];
        [self midleNetWorking];
        [self.leftTableView reloadData];
        self.midLabel.text=model.title;
#pragma mark 开始播放音乐
        if ([PlayView sharePlayView]->playAlbumId == self.playAlbumId) {
            [[MyPlayer sharePlayer] play];
        }else{
            [[MyPlayer sharePlayer] playMusicWithURL:model.playUrl64];
        }
        [self.playButton setImage:[UIImage imageNamed:@"plause"] forState:UIControlStateNormal];
        [self turn];
        
    } failure:^(NSError *error) {
    
        id result=[self readCaches];
        NSDictionary * Dic=result;
        NSMutableArray * data=Dic[@"data"];
        for (NSDictionary * tempDic in data) {
            
            playLeftTableMd * model=[[playLeftTableMd alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [self.leftTbArr addObject:model];
        }
        playLeftTableMd *model = self.leftTbArr[0];
        [self.leftTableView reloadData];
        self.trackIdStr = model.trackId;
        [self rightNetWorking];
        [self midleNetWorking];
        
#pragma mark 开始播放音乐
        self.midLabel.text=model.title;
        [[MyPlayer sharePlayer] playMusicWithURL:model.playUrl64];
        [self.playButton setImage:[UIImage imageNamed:@"plause"] forState:UIControlStateNormal];
        self.isPlay=YES;
        [self turn];

  }];
}
- (void)rightNetWorking
{
    //rightTableView的数据请求
    [HTTPTool get:[NSString stringWithFormat:@"http://ar.ximalaya.com/rec-association/recommend/album?device=iPhone&trackId=%@", self.trackIdStr] body:nil httpResult:JSON success:^(id result) {
        [self.righeTbArr removeAllObjects];
        NSDictionary * Dic=result;
        NSMutableArray * albums=Dic[@"albums"];
        for (NSDictionary * tempDic in albums) {
            playRightTableMd * model=[[playRightTableMd alloc] initWithDic:tempDic];
            [self.righeTbArr addObject:model];
            [model release];
        }
        NSDictionary * baseAlbum=Dic[@"baseAlbum"];
        playRightTableMd * basemodel=[[playRightTableMd alloc] initWithDic:baseAlbum];
        [self.righeTbArr addObject:basemodel];
        [basemodel release];
        
        [self.rightTableView reloadData];
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}
- (void)midleNetWorking
{
    [HTTPTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/track/detail?device=iPhone&trackId=%@", self.trackIdStr] body:nil httpResult:JSON success:^(id result) {
        
        NSDictionary * Dic=result;
        playTableModel * playModel=[[playTableModel alloc] initWithDic:Dic];
        //给毛玻璃赋值
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:playModel.coverLarge]];
        [self.smallView sd_setImageWithURL:[NSURL URLWithString:playModel.coverLarge]];

        [[PlayView sharePlayView] setImageWithUrl:playModel.coverLarge playAlbumId:self.playAlbumId];

        if (playModel.coverLarge) {
            self.SmallBackView.hidden=NO;
        }else{
            self.SmallBackView.hidden=YES;
        }

        NSMutableDictionary * dic=Dic[@"userInfo"];
        self.userInfo=dic;
        [playModel release];
      
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}
#pragma mark 滑动改变smallView透明度的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   if (self.scrollView.contentOffset.x < WIDTH) {
        self.smallView.alpha = self.scrollView.contentOffset.x/WIDTH;
       self.SmallBackView.alpha=self.scrollView.contentOffset.x/WIDTH;
  }if (self.scrollView.contentOffset.x>WIDTH) {
        self.smallView.alpha = (2 * WIDTH - self.scrollView.contentOffset.x) / WIDTH;
      self.SmallBackView.alpha = (2 * WIDTH - self.scrollView.contentOffset.x) / WIDTH;
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.scrollView.contentOffset.x!=WIDTH*2) {
        [self.alockButton setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    }else {
        [self.alockButton setImage:[UIImage imageNamed:@"rightxia"] forState:UIControlStateNormal];
    }
}

#pragma mark tableView的协议方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView ==self.rightTableView) {
        return 2;
    }else{
        return 1;
    }
    
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    tableView.backgroundColor = [UIColor clearColor];
    if (section==1) {
        return @"|相关专辑";
    }else{
        return nil;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView==self.leftTableView) {
        return self.leftTbArr.count;
    }else if(tableView==self.rightTableView){
        if (section==0) {
            return 1;
        }else{
            return self.righeTbArr.count-1;
        }
    }else{
        return 0;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.leftTableView) {
        static NSString * leftTb=@"leftTb";
        UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:leftTb];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:leftTb];
            
        }
        //对leftTableView的赋值
        cell.backgroundColor=[UIColor clearColor];
        playLeftTableMd * model=self.leftTbArr[indexPath.row];
        
        cell.textLabel.text=model.title;
        return cell;
    }else{
        
        if (indexPath.section==0) {
            static NSString * rightTb=@"rightTbb";
            RightTableCell * cell=[tableView dequeueReusableCellWithIdentifier:rightTb];
            if (!cell) {
                cell=[[RightTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:rightTb];
            }
            playRightTableMd * model=[self.righeTbArr lastObject];
            [cell.button addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
            cell.button.tag=self.righeTbArr.count - 1;
            cell.textLabel.text=model.title;
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.coverSmall]];
            cell.contentView.backgroundColor=[UIColor clearColor];
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }else{
            static NSString * rightTb=@"rightTb";
            RightTableCell * cell=[tableView dequeueReusableCellWithIdentifier:rightTb];
            if (!cell) {
                cell=[[RightTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:rightTb];
            }
        playRightTableMd * model=self.righeTbArr[indexPath.row];
        [cell.button addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
        cell.button.tag=indexPath.row;
        cell.textLabel.text=model.title;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        }
        
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.leftTableView) {
        playLeftTableMd *model = self.leftTbArr[indexPath.row];
        self.trackIdStr = model.trackId;
        [self rightNetWorking];
        [self midleNetWorking];
        self.musicIndex = indexPath;
        self.midLabel.text=model.title;
        [[MyPlayer sharePlayer] playMusicWithURL:model.playUrl64];
        [self.playButton setImage:[UIImage imageNamed:@"plause"] forState:UIControlStateNormal];
        self.isPlay=YES;
        [self.scrollView setContentOffset:CGPointMake(WIDTH, 0) animated:YES];
        self.timer.fireDate = [NSDate distantPast];//恢复定时器
    }else if (tableView == self.rightTableView){
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
        
    }else{
        if (indexPath.section==1) {
            playRightTableMd * model=self.righeTbArr[indexPath.row];
            self.albumId=model.albumId;
            
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
