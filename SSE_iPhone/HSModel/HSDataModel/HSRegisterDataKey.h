//
//  HSRegisterDataKey.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/5/10.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSRegisterDataKey : NSObject

+(HSRegisterDataKey*) sharedRegisterDataKey;

//----------------------------------------------------------------------
//返回字典风格，注意临时存储变量和HSDataModel保持一致                        --
//           @"临时存储变量"      @"实际key值"                           --
//----------------------------------------------------------------------
-(NSDictionary*)registerProTypeDicKeyData;          //注册流程分类数据key值
-(NSDictionary*)registerWillDoDicKeyData;           //注册待办数据key值
-(NSDictionary*)registerDidDoDicKeyData;            //注册已办数据key值
-(NSDictionary*)registerWillDoDetailDicKeyData;     //注册待办详情数据key值
-(NSDictionary*)registerDidDoDetailDicKeyData;      //注册已办详情数据key值
-(NSDictionary*)registerHistoryOpiDicKeyData;       //注册流程审批历史key值
-(NSDictionary*)registerNewsDicKeyData;             //注册消息数据key值
-(NSDictionary*)registerNewsDetailDicKeyData;       //注册消息详情数据key值
-(NSDictionary*)registerProjectDicKeyData;          //注册项目数据key值
-(NSDictionary*)registerProjectDetailDicKeyData;    //注册项目详情数据key值
-(NSDictionary*)registerPublicInfoDicKeyData;       //注册公示信息数据key值
-(NSDictionary*)registerPublicInfoDetailDicKeyData; //注册公示信息详情数据key值

-(NSArray*)getProjectTypeKey;                    //获取项目类型

@end

//股票
@interface HSRegisterDataKey_SSE_Stock:HSRegisterDataKey
@end
//债券
@interface HSRegisterDataKey_SSE_Bond:HSRegisterDataKey
@end
//TCMP
@interface HSRegisterDataKey_TCMP:HSRegisterDataKey
@end