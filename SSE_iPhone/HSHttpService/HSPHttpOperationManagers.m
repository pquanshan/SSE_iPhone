//
//  HSPHttpOperationManagers.m
//  HSMoveApproval
//
//  Created by yons on 15-1-24.
//  Copyright (c) 2015年 pquanshan. All rights reserved.
//

#import "HSPHttpOperationManagers.h"
#import "CJSONDeserializer.h"
#import "HSUtils.h"
#import "HSModel.h"

@interface HSPHttpOperationManagers(){
    NSOperationQueue* operationQueue;
    NSMutableArray* operationQueueArr;
}

@end


@implementation HSPHttpOperationManagers

-(id)init{
    self = [super init];
    if (self) {
        operationQueue = [[NSOperationQueue alloc] init];
        operationQueueArr  = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addRequestByKey:(NSURL*)strUrl type:(HSHttpRequestType)type data:(NSArray*)data{
    if (operationQueueArr == nil) {
        operationQueueArr  = [[NSMutableArray alloc] init];
    }
    
    for(id reStr in data) {
        //data 中的元素必须是@"type=focus-c"格式的字符串
        if (![reStr isKindOfClass:[NSString class]] || ![[HSBusinessAnalytical sharedBusinessAnalytical] stringIsValidRequestStr:reStr]) {
            NSMutableDictionary* mudic =[[NSMutableDictionary alloc] init];
            [mudic setObject:@"1" forKey:@"requestDataCode"];
            [mudic setObject:@"请求url格式不正确。" forKey:@"requestData"];
            [self.delegate requestFailed:mudic];
            return;
        }
    }
    HSPHttpOperation* operation = [[HSPHttpOperation alloc] initWithURL:self action:@selector(requestHandle:) url:strUrl type:type data:data];
    [operation setNumbel:operationQueueArr.count];
    [operationQueueArr addObject:operation];
}

-(void)requestByUrl:(NSURL*)strUrl
        successHandler:(void(^)(NSData *data)) successHandler
          errorHandler:(void(^)(NSError *error)) errorHandler{
    NSURLRequest *request = [NSURLRequest requestWithURL:strUrl
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:10];
    NSLog(@"requestUrl = %@",request);
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *err) {
        if (err == nil) {
            successHandler(data);
        }else{
            errorHandler(err);
        }
    }];

}

-(void)executionQueue{
    //崩溃的原因是:操作完成后，执行，或已经在队列中，而无法进入队列 ???
    //1 (of 2) operation is finished, executing, or already in a queue, and cannot be enqueued'
    [operationQueue addOperations:operationQueueArr waitUntilFinished:NO];

}

-(void)clearQueue{
    [operationQueue cancelAllOperations];
    [operationQueueArr removeAllObjects];
}


-(void)requestHandle:(NSDictionary *)dicData{
    NSMutableDictionary* mudic =[[NSMutableDictionary alloc] init];
    BOOL bl = [[dicData objectForKey:@"requestDataCode"] boolValue];
    [mudic setObject:[dicData objectForKey:@"requestDataCode"] forKey:@"requestDataCode"];
    if (bl) {
        NSError *error = nil;
        NSData* data = [dicData objectForKey:@"requestData"];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//        id jsonObject = [[CJSONDeserializer deserializer] deserialize:data error:&error];
        
        if ([jsonObject isKindOfClass:[NSDictionary class]]){
            NSDictionary *dictionary = (NSDictionary *)jsonObject;
            [mudic setObject:dictionary forKey:@"requestData"];
//            NSLog(@"Request Data Dersialized JSON --- Dictionary = %@", dictionary);
        }else if ([jsonObject isKindOfClass:[NSArray class]]){
            NSArray *nsArray = (NSArray *)jsonObject;
            [mudic setObject:nsArray forKey:@"requestData"];
//            NSLog(@"Request Data Dersialized JSON --- Array = %@", nsArray);
        } else {
            NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
            [mudic setObject:[[NSString alloc] initWithFormat:@"服务器返回字符串:%@",result] forKey:@"requestData"];
//            NSLog(@"Request Data Dersialized JSON --- NSString = %@", result);
        }
        
        NSInteger index = [[dicData objectForKey:@"Numbel"] integerValue];
        for(HSPHttpOperation *operation in operationQueueArr) {
            if (index == operation.numbel ) {
                [operationQueueArr removeObject:operation];
                break;
            }
        }
        
        if (operationQueueArr.count == 0) {
            if ([self.delegate respondsToSelector:@selector(requestItmeFinish:)]) {
                [self.delegate requestItmeFinish:mudic];
            }
            [self.delegate requestFinish:mudic];
        }else{
            [self.delegate requestItmeFinish:mudic];
        }
        
    }else{
        NSError *error = [dicData objectForKey:@"error"];
        if (error) {
            [mudic setObject:error forKey:@"error"];
        }
        if ([self.delegate respondsToSelector:@selector(requestFailed:)]) {
           [self.delegate requestFailed:mudic];
        }
    }
}

@end
