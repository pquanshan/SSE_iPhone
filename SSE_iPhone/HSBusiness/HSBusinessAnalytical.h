//
//  HSBusinessAnalytical.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/3.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HSConfig.h"

@interface HSBusinessAnalytical : NSObject

+ (HSBusinessAnalytical *)sharedBusinessAnalytical;

//附件解析相关
-(NSArray*)getAnnexStringByHsstr:(NSString*)string;
-(NSArray*)getAnnexDetailByHsstr:(NSString*)string;
//字节转换
-(NSString*)getSizeByLong:(long)lsize;
//获取详情页面要显示的业务数据
-(NSArray*)getFlowinfoArr:(NSArray*)flowinfoArr;
//<\br>审批历史时，换行说明
-(NSArray*)getRemarkArrByHsstr:(NSString*)string;
//审批意见颜色（同意，批准，否决，提交）
-(UIColor*)getRemarkyColorHsstr:(NSString*)string;
//不同流程种类颜色（审批，投票，会签，协作）
-(UIColor*)getProcessColorHsstr:(NSString*)string;

//消息图标（0系统通知，1待办消息）
-(UIImage*)getNewsIconHsint:(int)code;

//判断请求数据格式的正确性
- (BOOL)stringIsValidRequestStr:(NSString*)checkString;


@end
