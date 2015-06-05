//
//  AppDelegate.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/9.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "AppDelegate.h"
#import "HSViewControllerFactory.h"
#import "HSLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    //设置系统类型 HSAppSystemBond（债券）,HSAppSystemStock（股票）,HSAppSystemTCMP
    [[HSModel sharedHSModel] setAppSystem:HSAppSystemStock];
    [HSUtils registeredBaiduStatistics];
    
    UIViewController* viewController = [[HSViewControllerFactory sharedFactory] getViewController:HSMPageRootVC isReload:NO];
    _navigation = [[UINavigationController alloc] initWithRootViewController:viewController];
    _navigation.navigationBar.barTintColor = [HSColor getColorByColorNavigation];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    NSDictionary* textAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                     NSForegroundColorAttributeName:[UIColor whiteColor]};
    _navigation.navigationBar.titleTextAttributes = textAttributes;
    _navigation.navigationBar.translucent = NO;
    [_navigation.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    _navigation.navigationBar.shadowImage = [[UIImage alloc] init];
   
//    //测试
//    UIViewController* viewController = [[HSViewControllerFactory sharedFactory] getViewController:HSMPageHandleTaskVC];
//    _navigation = [[UINavigationController alloc] initWithRootViewController:viewController];
    
//    [NSThread sleepForTimeInterval:2.0];//启动页停留时间
    
    [self.window setRootViewController:_navigation];
    [self.window makeKeyAndVisible];

    [self addApplicationPush:launchOptions];
    
    return YES;
}

-(void)addApplicationPush:(NSDictionary *)launchOptions{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        //IOS8
        //创建UIUserNotificationSettings，并设置消息的显示类类型
        UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:notiSettings];
        
    } else{ // ios7
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge                                       |UIRemoteNotificationTypeSound                                      |UIRemoteNotificationTypeAlert)];
    }
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

//注册消息推送-成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)ideviceToken{
    NSString* itoken = [[ideviceToken description] stringByReplacingOccurrencesOfString:@" " withString:@""];
    itoken = [itoken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    itoken = [itoken stringByReplacingOccurrencesOfString:@">" withString:@""];
    [[HSModel sharedHSModel] setDeviceTokenStr:itoken];
    NSLog(@"[deviceToken]##%@",ideviceToken);
}

// 当 DeviceToken 获取失败时,系统会回调此⽅方法
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:( NSError *)error
{
    NSLog(@"DeviceToken 获取失败,原因:%@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // App 收到推送通知
    NSLog(@"userInfo == %@",userInfo);
    NSString *message = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    
    [alert show];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //手势密码屏幕保护
    NSString* gesturePassword  = [[NSUserDefaults standardUserDefaults] objectForKey:KGesturePassword];
    NSString* account = [[NSUserDefaults standardUserDefaults] objectForKey:KAccount];
    BOOL activationGP = [[[NSUserDefaults standardUserDefaults] objectForKey:KActivationGesturePassword] boolValue];
    if (gesturePassword && account && activationGP && [gesturePassword isEqualToString:account]) {
        [[HSViewControllerFactory sharedFactory] gotoGesturePasswordController];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
