//
//  HSPHttpOperation.h
//  HSMoveApproval
//
//  Created by yons on 15-1-24.
//  Copyright (c) 2015年 pquanshan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    HSRequestTypeGET = 0,
    HSRequestTypePOST,
} HSHttpRequestType;

@interface HSPHttpOperation : NSOperation{
    id retarget;
    SEL reaction;
    NSURL* requestUrl;
    HSHttpRequestType requestType;
    NSArray* requestData;
    
   
}
@property(assign,nonatomic) NSUInteger numbel;

- (id)initWithURL:(id)target action:(SEL)action url:(NSURL*)url type:(HSHttpRequestType)type data:(NSArray*)data;

-(void)setIdentification:(NSUInteger)index;

@end
