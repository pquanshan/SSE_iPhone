//
//  HSModel.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/1.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSModel.h"
#import "Reachability.h"
#import "HSPHttpOperationManagers.h"
#import "HsUUID.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@interface HSModel()
@property(nonatomic,strong)Reachability* hostReach;

@end

@implementation HSModel


+ (HSModel *)sharedHSModel
{
    static HSModel *sharedModel = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedModel = [[self alloc] init];
        [sharedModel getAppSystemName];
    });
    return sharedModel;
}

-(id)init{
    self = [super init];
    if (self) {
        //开启网络状况的监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        self.hostReach = [Reachability reachabilityForInternetConnection];
        
        NSString *clientsign = [HsUUID UDID];
        _deviceTokenStr = [NSString stringWithFormat:@"%@%@",@"simulator_",clientsign];
            
        [self.hostReach startNotifier];  //开始监听，会启动一个run loop
        self.isReachable = YES;        
    }
    return self;
}

//网络链接改变时会调用的方法
-(void)reachabilityChanged:(NSNotification *)note
{
    Reachability *currReach = [note object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    self.isReachable = YES;
    NSString* ssid = @"";
    switch (status) {
        case NotReachable:
        {
            self.isReachable = NO;
            [HSUtils showAlertMessage:@"提示" msg:@"网络已断开" delegate:nil];
        }
            break;
        case ReachableViaWiFi:
        {
            NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
            NSLog(@"Supported interfaces: %@", ifs);
            id info = nil;
            for (NSString *ifnam in ifs) {
                info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
                NSLog(@"%@ => %@", ifnam, info);
                if (info && [info count]) { break; }
            }
            ssid = [[info objectForKey:@"SSID"] lowercaseString];
            
            ssid == nil ? ssid = @"": NO;
            [HSUtils showAlertMessage:@"提示" msg:[@"已连接到网络:" stringByAppendingString:ssid] delegate:nil];
        }
            break;
        case ReachableViaWWAN:
        {
            [HSUtils showAlertMessage:@"提示" msg:@"已连接到网络" delegate:nil];
        }
            break;
        default:
            break;
    }

}

-(NSString*)getUUID{
    return [HsUUID UDID];
}

-(NSString*)getAppSystemName{
    NSString* system = @"";
    switch (self.appSystem) {
        case HSAppSystemBond:
            system = @"债券系统";
            break;
        case HSAppSystemStock:
            system = @"股票系统";
            break;
        case HSAppSystemTCMP:
            system = @"TCMP";
            break;
        default:
            break;
    }
    return system;
}

-(HSPageVCType)getMainSystemVC{
    HSPageVCType pageVC = HSMPageViewControllerVC;
    switch (self.appSystem) {
        case HSAppSystemBond:
            pageVC = HSMPageBondSystemtVC;
            break;
        case HSAppSystemStock:
            pageVC = HSMPageStockSystemVC;
            break;
        case HSAppSystemTCMP:
            pageVC = HSMPageMainTabBarVC;
            break;
        default:
            break;
    }
    return pageVC;
}

-(void)login{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString* accountid = [[NSUserDefaults standardUserDefaults] objectForKey:KAccountId];
        NSString* pass = [[NSUserDefaults standardUserDefaults] objectForKey:KPassword];
        if (accountid && pass) {
            accountid = [@"userid=" stringByAppendingString:accountid];
            pass = [@"userpwd=" stringByAppendingString:pass];
            NSString* strUrl = [[HSURLBusiness sharedURL] getLoginUrl];
            strUrl = [strUrl stringByAppendingString:@"&"];
            strUrl = [strUrl stringByAppendingString:accountid];
            strUrl = [strUrl stringByAppendingString:@"&"];
            strUrl = [strUrl stringByAppendingString:pass];
            HSPHttpOperationManagers* operation = [[HSPHttpOperationManagers alloc] init];
            if ([[HSModel sharedHSModel] isReachable]) {//网络正常
                [operation requestByUrl:[NSURL URLWithString:strUrl] successHandler:^(NSData *data) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSError *error = nil;
                        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                        if ([jsonObject isKindOfClass:[NSDictionary class]]){
                            NSDictionary *dictionary = (NSDictionary *)jsonObject;
                            int isCode = [[dictionary objectForKey:@"code"] boolValue];
                            if (isCode) {
//                                NSString* accountid = [[NSUserDefaults standardUserDefaults] objectForKey:KAccountId];
                                [[HSModel sharedHSModel] setIsLogin:YES];
                                [[HSModel sharedHSModel] setUserName:accountid];
//                                [[HSModel sharedHSModel] setUserId:[dictionary objectForKey:@"userid"]];
                                [[HSModel sharedHSModel] setUserName:[dictionary objectForKey:@"username"]];
                                [[HSModel sharedHSModel] setUserId:[dictionary objectForKey:@"userid"]];
                                [[NSNotificationCenter defaultCenter] postNotificationName:KMessageLogin object:nil];
                            }
                        }else if ([jsonObject isKindOfClass:[NSArray class]]){
                            NSArray *nsArray = (NSArray *)jsonObject;
                            if (nsArray &&[nsArray count] == 1) {
                                NSDictionary* dic = [nsArray  objectAtIndex:0];
                                int isCode = [[dic objectForKey:@"code"] boolValue];
                                if (isCode) {
//                                    NSString* account = [[NSUserDefaults standardUserDefaults] objectForKey:KAccount];
                                    [[HSModel sharedHSModel] setIsLogin:YES];
                                    [[HSModel sharedHSModel] setUserName:[dic objectForKey:@"username"]];
                                    [[HSModel sharedHSModel] setUserId:[dic objectForKey:@"userid"]];
                                    [[NSNotificationCenter defaultCenter] postNotificationName:KMessageLogin object:nil];
                                }
                            }
                        } else {
                            NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
                            NSLog(@"HSModel Request Data Dersialized JSON --- NSString = %@", result);
                        }

                    });
                } errorHandler:^(NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // something
                    });
                }];
            }
        }
    });
}

-(void)login:(void(^)()) successHandler
errorHandler:(void(^)()) errorHandler{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString* accountid = [[NSUserDefaults standardUserDefaults] objectForKey:KAccountId];
        NSString* pass = [[NSUserDefaults standardUserDefaults] objectForKey:KPassword];
        if (accountid && pass) {
            accountid = [@"userid=" stringByAppendingString:accountid];
            pass = [@"userpwd=" stringByAppendingString:pass];
            NSString* strUrl = [[HSURLBusiness sharedURL] getLoginUrl];
            strUrl = [strUrl stringByAppendingString:@"&"];
            strUrl = [strUrl stringByAppendingString:accountid];
            strUrl = [strUrl stringByAppendingString:@"&"];
            strUrl = [strUrl stringByAppendingString:pass];
            HSPHttpOperationManagers* operation = [[HSPHttpOperationManagers alloc] init];
            if ([[HSModel sharedHSModel] isReachable]) {//网络正常
                [operation requestByUrl:[NSURL URLWithString:strUrl] successHandler:^(NSData *data) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSError *error = nil;
                        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                        if ([jsonObject isKindOfClass:[NSDictionary class]]){
                            NSDictionary *dictionary = (NSDictionary *)jsonObject;
                            int isCode = [[dictionary objectForKey:@"code"] boolValue];
                            if (isCode) {
                                successHandler();
                            }
                        }else if ([jsonObject isKindOfClass:[NSArray class]]){
                            NSArray *nsArray = (NSArray *)jsonObject;
                            if (nsArray &&[nsArray count] == 1) {
                                NSDictionary* dic = [nsArray  objectAtIndex:0];
                                int isCode = [[dic objectForKey:@"code"] boolValue];
                                if (isCode) {
                                    successHandler();
                                }
                            }
                        } else {
                            errorHandler();
                        }
                        
                    });
                } errorHandler:^(NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        errorHandler();
                    });
                }];
            }
        }
    });
}

-(void)logout{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([HSModel sharedHSModel].isLogin) {
            NSString* strUrl = [[HSURLBusiness sharedURL] getLogoutUrl];
            HSPHttpOperationManagers* operation = [[HSPHttpOperationManagers alloc] init];
            if ([[HSModel sharedHSModel] isReachable]) {//网络正常
                [operation requestByUrl:[NSURL URLWithString:strUrl] successHandler:^(NSData *data) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSError *error = nil;
                        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                        if ([jsonObject isKindOfClass:[NSDictionary class]]){
                            NSDictionary *dictionary = (NSDictionary *)jsonObject;
                            int icode = [[dictionary objectForKey:@"code"] intValue];
                            if (icode == 0) {
                                [HSUtils showAlertMessage:@"提示" msg:[dictionary objectForKey:@"result"] delegate:nil];
                            }else{
                                [[HSModel sharedHSModel] setIsLogin:NO];
                                [[HSModel sharedHSModel] setUserName:@""];
                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:KAccountId];
                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:KAccount];
                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:KPassword];
                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:KGesturePassword];
                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:KActivationGesturePassword];
                                [[NSNotificationCenter defaultCenter] postNotificationName:KMessageLogOut object:nil];
                            }
                        }else if ([jsonObject isKindOfClass:[NSArray class]]){
                            NSArray *nsArray = (NSArray *)jsonObject;
                            if (nsArray &&[nsArray count] == 1) {
                                NSDictionary* dic = [nsArray  objectAtIndex:0];;
                                int icode = [[dic objectForKey:@"code"] intValue];
                                if (icode == 0) {
                                    [HSUtils showAlertMessage:@"提示" msg:[dic objectForKey:@"result"] delegate:nil];
                                }else{
                                    [[HSModel sharedHSModel] setIsLogin:NO];
                                    [[HSModel sharedHSModel] setUserName:@""];
                                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KAccountId];
                                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KAccount];
                                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KPassword];
                                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KGesturePassword];
                                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KActivationGesturePassword];
                                    [[NSNotificationCenter defaultCenter] postNotificationName:KMessageLogOut object:nil];
                                }
                            } else {
                                NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
                                NSLog(@"HSModel Request Data Dersialized JSON --- NSString = %@", result);
                            }
                        }

                    });
                } errorHandler:^(NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // something
                    });
                }];
            }
        }
    });
}

@end
