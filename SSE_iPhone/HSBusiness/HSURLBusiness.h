//
//  HSURLBusiness.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/1.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSModel.h"

//#define CC_CUSTOMER HSURLBusiness_SSE_Stock

@interface HSURLBusiness : NSObject

+(HSURLBusiness*) sharedURL;

//MBP---------------------------------------------------
-(NSString*)getMBPUrl;

//登录接口------------------------------------------------
//登录
-(NSString*)getLoginUrl;
//注销
-(NSString*)getLogoutUrl;
//短信校验
-(NSString*)getSMSCheckUrl;
//安全码校验
-(NSString*)getSafetyCodeCheckUrl;

//工作流接口-----------------------------------------------
//流程分类
-(NSString*)getProcessCategoryUrl;
//待办信息查看
-(NSString*)getProcWillDoListUrl;
//已办信息查看
-(NSString*)getProcDidDoListUrl;
//待办流程信息查看
-(NSString*)getProcWillDoDetailInfoUrl;
//已办流程信息查看
-(NSString*)getProcDidDoDetailInfoUrl;
//查看历史审批意见
-(NSString*)getProcHistoryOpinionUrl;

//消息模块接口----------------------------------------------
//消息列表
-(NSString*)getNewsListUrl;
//消息详情
-(NSString*)getNewsDetailsUrl;
//消息未读统计
-(NSString*)getNewsUnreadStatisticsUrl;
//消息未读置为已读
-(NSString*)getNewsUnreadConvertReadUrl;

//项目模块接口----------------------------------------------
//项目列表
-(NSString*)getProjectListUrl;
//项目详情
-(NSString*)getProjectDetailsUrl;

//公示信息接口----------------------------------------------
//公示列表，免登入
-(NSString*)getPublicityListUrl;
//公示详情，免登入
-(NSString*)getPublicityDetailsUrl;
@end

//股票
@interface HSURLBusiness_SSE_Stock:HSURLBusiness
@end
//债券
@interface HSURLBusiness_SSE_Bond:HSURLBusiness
@end
//TCMP
@interface HSURLBusiness_TCMP:HSURLBusiness
@end

