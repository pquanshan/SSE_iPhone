//
//  HSPHttpOperation.m
//  HSMoveApproval
//
//  Created by yons on 15-1-24.
//  Copyright (c) 2015年 pquanshan. All rights reserved.
//

#import "HSPHttpOperation.h"
#import "HSUtils.h"

@implementation HSPHttpOperation

- (id)initWithURL:(id)target action:(SEL)action url:(NSURL*)url type:(HSHttpRequestType)type data:(NSArray*)data;{
    self = [super init];
    if (self){
        retarget = target;
        reaction = action;
        requestUrl = url;
        requestType = type;
        requestData = data;
    }
    return self;
}
- (void)main {
    if (!requestUrl) {
        return;
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:requestUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    if (requestType == HSRequestTypeGET) {
        NSMutableString *str = [[NSMutableString alloc] initWithString:[requestUrl absoluteString]];
        [str appendString:@"&"];
        for(NSString *reStr in requestData) {
            if ([[HSBusinessAnalytical sharedBusinessAnalytical] stringIsValidRequestStr:reStr]) {
                [str appendString:reStr];
                [str appendString:@"&"];
            }
        }
        request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    }else if(requestType == HSRequestTypePOST){
        [request setHTTPMethod:@"POST"];
        NSMutableString* postStr = [NSMutableString string];
        for (NSString* strdata in requestData) {
            //strdata 格式必须是@"type=focus-c"
            [postStr appendString:strdata];
            [postStr appendString:@"&"];
        }
        NSData *data = [postStr dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
    }
    NSLog(@"requestUrl = %@",request);
    
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSMutableDictionary* mudic = [[NSMutableDictionary alloc] init];
    [mudic setObject:[NSNumber numberWithInteger:self.numbel] forKey:@"Numbel"];
    if (received == nil) {
        [mudic setObject:[NSNumber numberWithBool:NO] forKey:@"requestDataCode"];
        [mudic setObject:error forKey:@"error"];
    }else{
        [mudic setObject:[NSNumber numberWithBool:YES] forKey:@"requestDataCode"];
        [mudic setObject:received forKey:@"requestData"];
    }
    [self performSelectorOnMainThread:@selector(requestComplete:) withObject:mudic waitUntilDone:NO];
}

-(void)setIdentification:(NSUInteger)index{

}

-(void)requestComplete:(NSDictionary*)requestdata{
    [retarget performSelector:reaction withObject:requestdata afterDelay:0.0];
}



@end
