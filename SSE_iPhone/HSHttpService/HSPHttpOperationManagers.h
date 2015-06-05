//
//  HSPHttpOperationManagers.h
//  HSMoveApproval
//
//  Created by yons on 15-1-24.
//  Copyright (c) 2015年 pquanshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSPHttpOperation.h"

@protocol HSPHttpRequestDelegate<NSObject>
@required
-(void)requestFinish:(NSDictionary*)dicData;

@optional
-(void)requestItmeFinish:(NSDictionary*)dicData;
-(void)requestFailed:(NSDictionary*)dicData;

@end

@interface HSPHttpOperationManagers : NSObject

@property(weak,nonatomic)id<HSPHttpRequestDelegate> delegate;

/**
*  @brief 添加请求队列
*  @param -strUrl,请求URL
*  @param -type,请求方式
*  @param -data,请求数据参数，type为HSRequestTypePOST时有效。data 中的元素必须是@"type=focus-c"格式的字符串
*/
-(void)addRequestByKey:(NSURL*)strUrl type:(HSHttpRequestType)type data:(NSArray*)data;

/**
 *  @brief 添加请求队列
 *  @param -data,请求数据参数，type为HSRequestTypePOST时有效。data 中的元素必须是@"type=focus-c"格式的字符串
 *  successHandler,errorHandler 成果失败回调
 */
-(void)requestByUrl:(NSURL*)strUrl
     successHandler:(void(^)(NSData *data)) successHandler
       errorHandler:(void(^)(NSError *error)) errorHandler;

/**
 *  @brief 执行请求队列
 */
-(void)executionQueue;
/**
 *  @brief 清空请求队列
 */
-(void)clearQueue;

@end
