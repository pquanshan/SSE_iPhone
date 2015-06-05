//
//  HSModel.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/1.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HSUtils.h"
#import "HSViewControllerFactory.h"

typedef enum {
    HSAppSystemBond = 0,        //债券系统
    HSAppSystemStock,           //股票系统
    HSAppSystemTCMP,            //TCMP系统
} HSAppSystemType;

@interface HSModel : NSObject

+(HSModel *)sharedHSModel;

@property (strong, nonatomic) NSString* userName;
@property (strong, nonatomic) NSString* userId;
@property (assign, nonatomic) BOOL isLogin;
@property (assign, nonatomic) BOOL isShowMain;
@property (assign, nonatomic) BOOL isReachable;
@property (assign, nonatomic) HSAppSystemType appSystem;

@property (strong, nonatomic) NSString* deviceTokenStr;

-(NSString*)getUUID;
//获取系统名称
-(NSString*)getAppSystemName;
//获取主视图
-(HSPageVCType)getMainSystemVC;

//登录
-(void)login;
//登录成功回调函数
-(void)login:(void(^)()) successHandler
errorHandler:(void(^)()) errorHandler;

//登出
-(void)logout;


@end
