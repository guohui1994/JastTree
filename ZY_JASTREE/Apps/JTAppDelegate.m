//
//  JTAppDelegate.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/2.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTAppDelegate.h"
#import "JTBaseTabBarController.h"
#import "JTBaseNavigationController.h"
#import "JTCodeLoginController.h"

#import "XHLaunchAd.h"

#import "WXApi.h"

@interface JTAppDelegate ()

@property (nonatomic, strong) Reachability *hostReach;
@end

@implementation JTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    sleep(2);
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSString *token = USER_TOKEN;
    self.window.rootViewController =  token.length ?  [[JTBaseTabBarController alloc] init] : [[JTBaseNavigationController alloc] initWithRootViewController:[[JTCodeLoginController alloc] init]];
    
    JGLog(@"%@", NSHomeDirectory());
    
    [self.window makeKeyAndVisible];
    
    //适配iOS11
    if (@available(iOS 11.0, *)) {
        UITableView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
    
    //三方设置
    [self ThirdSet];
    
 
    return YES;
}

#pragma mark -  三方设置 -
- (void)ThirdSet {
    
//    //初始化开屏广告
//    [self setupXHLaunchAd];
    
    
    /*微信注册*/
    [WXApi registerApp:@"wx59b212926ba6a711"];
    //网络监测
    [self judgeNetWorkState];
    //智能键盘
    [self IQKeyboardManager];
    
}

/*IQKeyboardManager*/
- (void)IQKeyboardManager{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    //控制整个功能是否启用。
    manager.enable = YES;
    //控制点击背景是否收起键盘
    manager.shouldResignOnTouchOutside = YES;
    //    //控制键盘上的工具条文字颜色是否用户自定义。  注意这个颜色是指textfile的tintcolor
    //    manager.shouldToolbarUsesTextFieldTintColor = YES;
    //中间位置是否显示占位文字
    //    manager.shouldShowTextFieldPlaceholder = YES;
    //    //设置占位文字的字体
    //    manager.placeholderFont = [UIFont boldSystemFontOfSize:17];
    //    //控制是否显示键盘上的工具条。
    //    manager.enableAutoToolbar = YES;
}


#pragma mark - 网络监测 -
- (void)judgeNetWorkState {
    
    //先设置网络监测状态为YES
    self.isReachable = YES;
    
    //开启网络状况的监听
    [JGNotification addObserver:self
                       selector:@selector(reachabilityChanged:)
                           name:kReachabilityChangedNotification
                         object:nil];
    self.hostReach = [Reachability reachabilityWithHostname:@"v2.api.dev.fudiandmore.ie"] ;
    [self.hostReach startNotifier];  //开始监听，会启动一个run loop
}

//网络链接改变时会调用的方法
- (void)reachabilityChanged:(NSNotification *)note {
    Reachability *currReach = [note object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    if(status == NotReachable)  {
        
        self.isReachable = NO;
        [JGToast showWithText:@"网络连接错误，稍后重试"];
    }  else {
        
        self.isReachable = YES;
    }
}


#pragma - 开屏广告 -
-(void)setupXHLaunchAd{
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [XHLaunchAd setWaitDataDuration:1];
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"parameterName"] = @"start_figure";
    parameters[@"parameterName"] = @"start_figure_time";

//    WEAKSELF;
    [ZYHttpManager LoadingHttpRequestDataWithApi:JTSystemSelectValue Aarameters:parameters httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        
        JGLog(@"%@", data);

        
        
        
    } failure:^(NSString * _Nonnull message) {
        [JGToast showWithText:message];
    }];
    
    
    
    
    
    
    
    
    
}





- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[JTWeChatOrQQLoginTool shared] handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[JTWeChatOrQQLoginTool shared] sourceApplicationOpenURL:url];
}

// NOTE: 9.0以后使用新API接口1
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    return [[JTWeChatOrQQLoginTool shared] OpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
