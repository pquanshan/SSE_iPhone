//
//  HSConfig.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/2/26.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#ifndef TCMP_iPhone_HSConfig_h
#define TCMP_iPhone_HSConfig_h

//#ifdef DEBUG
//#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//#else
//#define NSLog(FORMAT, ...) nil
//#endif
//
//#define KBondSystem             @"BondSystem"   //债券系统
//#define KStockSystem            @"StockSystem"  //股票系统
//#define KTCMPSystem             @"TCMPSystem"   //TCMP系统
//
////AppSystem 设置应用开启时的系统
//#define AppSystem               KStockSystem
#include "HSColor.h"

//全局标志=iphone
#define STRING_API_VERSION      @"1.0"
#define STRING_CLIENT_TYPE      @"iphone"
//#define STRING_CLIENT_TYPE      @"android"
#define KDeviceToken            @"deviceToken"

#define KLeftShowWidth                  (120)
#define KBottomTabBarHeight             (50)
#define KTabBarHeight                   (50)
#define KNavigationAddstatusHeight      (64)
#define KDownLoadLimit                  (20)


#define KCellHeight                     (44)

#define KBoundaryOFF                    (12)//边界
#define KMiddleOFF                      (5)//中间间距()


//系统常用信息
#define KScreenWidth            [UIScreen mainScreen].bounds.size.width         //屏幕宽
#define KScreenHeight           [UIScreen mainScreen].bounds.size.height        //屏幕高
#define KScreenBounds           [UIScreen mainScreen].bounds                    //屏幕区域

#define iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define iOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)

#define isPad   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad   ? YES : NO)
#define isPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? YES : NO)
#define isRetina ([[UIScreen mainScreen] scale] > 1 ? YES : NO)

//联系人索引
#define KIndexArr               @"indexArr"
#define KIndexDetailsDic        @"indexDetailsDic"

#define KAccount                            @"account"                          //账号
#define KAccountId                          @"accountid"                        //账号id
#define KPassword                           @"password"                         //密码
#define KGesturePassword                    @"gesturePassword"                  //密码锁编号
#define KActivationGesturePassword          @"activationGesturePassword"        //激活密码锁账号

//消息类型
#define KMessageLogin                       @"messagelogin"
#define KMessageLogOut                      @"messagelogout"
#define KNewsStatistics                     @"newsstatistics"
#define KNewsConvertRead                    @"newsconvertread"

#endif
