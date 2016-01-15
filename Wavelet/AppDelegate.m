//
//  AppDelegate.m
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "AppDelegate.h"
#import "FindDetailViewController.h"
#import "ClassDetailViewController.h"
#import "SpecialListViewController.h"
#import "PlayMusicViewController.h"
#import "TabBaseView.h"
#import "MineViewController.h"
#import "collocViewController.h"
#import "DownLoadViewController.h"
#import "MyPlayer.h"

#import "SaveDataBase.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    


    //==========
    [[SaveDataBase shareSaveDataBase] openDB];

    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"zhanweitu"]]];
//    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];

#pragma mark tab

    FindDetailViewController *findVc = [[FindDetailViewController alloc] init];
    UINavigationController *findNaVc = [[UINavigationController alloc] initWithRootViewController:findVc];
    findNaVc.navigationController.navigationBar.translucent = NO;

    findVc.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"iconfont-faxian"] tag:1000]autorelease];
   
    collocViewController *collectVC = [[collocViewController alloc] init];
    UINavigationController *collectNaVc = [[UINavigationController alloc] initWithRootViewController:collectVC];
    collectNaVc.navigationController.navigationBar.translucent = NO;
    collectNaVc.navigationBarHidden = NO;
    collectVC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"专题" image:[UIImage imageNamed:@"1"] tag:1001]autorelease];
    
    SpecialListViewController *downLoadVc = [[SpecialListViewController alloc] init];
    UINavigationController *specialListNaVc = [[UINavigationController alloc] initWithRootViewController:downLoadVc];
    specialListNaVc.navigationController.navigationBar.translucent = NO;
    downLoadVc.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"专辑列表" image:[UIImage imageNamed:@"1"] tag:1002]autorelease];
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    UINavigationController *mineNaVc = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineVC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"iconfont-wo"] tag:1003]autorelease];
    
    DownLoadViewController *downVC = [[DownLoadViewController alloc] init];
    UINavigationController *downNaVc = [[UINavigationController alloc] initWithRootViewController:downVC];
    downNaVc.navigationController.navigationBar.translucent = NO;
    downVC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"下载" image:[UIImage imageNamed:@"iconfont-xiazai"] tag:1004]autorelease];

    
    UITabBarController *tab = [[UITabBarController alloc] init];

//    tab.viewControllers = @[findNaVc];

    tab.viewControllers = @[findNaVc, downLoadVc, mineNaVc];
    tab.tabBar.tintColor=[UIColor whiteColor];

    self.window.rootViewController = tab;
//    tab.tabBar.hidden = YES;
    [tab.tabBar addSubview:[PlayView sharePlayView]];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 49)];
    backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"zhanweitu"]];
    [tab.tabBar insertSubview:backView atIndex:0];
    tab.tabBar.opaque = YES;
    [backView release];

    
//    //设置全局导航条风格和颜色
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:23/255.0 green:180/255.0 blue:237/255.0 alpha:1]];
//    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
//    
//    FindDetailViewController *mainController=[[FindDetailViewController alloc]init];
//    _window.rootViewController=mainController;
    [_window release];
    [tab release];
    [collectNaVc release];
    [collectVC release];
    [findNaVc release];
    [findVc release];
    [specialListNaVc release];
    [downLoadVc release];
    //如果已经获得发送通知的授权则创建本地通知，否则请求授权(注意：如果不请求授权在设置中是没有对应的通知设置项的，也就是说如果从来没有发送过请求，即使通过设置也打不开消息允许设置)
    
//    if ([[UIApplication sharedApplication]currentUserNotificationSettings].types!=UIUserNotificationTypeNone) {
//        [self addLocalNotification];
//    }else{
//        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
//    }

    
    return YES;
}
#pragma mark 调用过用户注册通知方法之后执行（也就是调用完registerUserNotificationSettings:方法之后执行）
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    if (notificationSettings.types!=UIUserNotificationTypeNone) {
        [self addLocalNotification];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    AVAudioSession * session=[AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];


}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    [session setActive:YES error:nil];
    
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标


}
#pragma mark - 私有方法
#pragma mark 添加本地通知
-(void)addLocalNotification{
    
    //定义本地通知对象
    UILocalNotification *notification=[[UILocalNotification alloc]init];
    //设置调用时间
    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:12*3600.0];//通知触发的时间，10s以后
    notification.repeatInterval=2;//通知重复次数
    //notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
    
    //设置通知属性
    notification.alertBody=@"你好久没有聆听世界了，是否立即体验？"; //通知主体
    notification.applicationIconBadgeNumber=1;//应用程序图标右上角显示的消息数
    notification.alertAction=@"打开应用"; //待机界面的滑动动作提示
    notification.alertLaunchImage=@"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
    //notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    notification.soundName=@"msg.caf";//通知声音（需要真机才能听到声音）
    
    //设置用户信息
    notification.userInfo=@{@"id":@1,@"user":@"Wavelet"};//绑定到通知上的其他附加信息
    
    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}
#pragma mark 移除本地通知，在不需要此通知时记得移除
-(void)removeNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
