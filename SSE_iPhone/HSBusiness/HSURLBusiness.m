//
//  HSURLBusiness.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/1.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSURLBusiness.h"
#import "HSConfig.h"
#import "HSUtils.h"

@implementation HSURLBusiness

+(HSURLBusiness*) sharedURL{
    static HSURLBusiness *sharedObj = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        switch ([HSModel sharedHSModel].appSystem) {
            case HSAppSystemBond:
                sharedObj = [[HSURLBusiness_SSE_Bond alloc] init];
                break;
            case HSAppSystemStock:
                sharedObj = [[HSURLBusiness_SSE_Stock alloc] init];
                break;
            case HSAppSystemTCMP:
                sharedObj = [[HSURLBusiness_TCMP alloc] init];
                break;
            default:
                sharedObj = [[HSURLBusiness alloc] init];
                break;
        }
        
    });
    return sharedObj;
}

-(NSString*)getMBPUrl{
    return nil;
}

-(NSString*)getLoginUrl{
    return nil;
}

-(NSString*)getLogoutUrl{
    return nil;
}

-(NSString*)getSMSCheckUrl{
    return nil;
}

-(NSString*)getSafetyCodeCheckUrl{
    return nil;
}

-(NSString*)getProcessCategoryUrl{
    return nil;
}

-(NSString*)getProcWillDoListUrl{
    return nil;
}

-(NSString*)getProcDidDoListUrl{
    return nil;
}

-(NSString*)getProcWillDoDetailInfoUrl{
    return nil;
}

-(NSString*)getProcDidDoDetailInfoUrl{
    return nil;
}

-(NSString*)getProcHistoryOpinionUrl{
    return nil;
}

-(NSString*)getNewsListUrl{
    return nil;
}

-(NSString*)getNewsDetailsUrl{
    return nil;
}

-(NSString*)getNewsUnreadStatisticsUrl{
    return nil;
}

-(NSString*)getNewsUnreadConvertReadUrl{
    return nil;
}

-(NSString*)getProjectListUrl{
    return nil;
}

-(NSString*)getProjectDetailsUrl{
    return nil;
}

-(NSString*)getPublicityListUrl{
    return nil;
}

-(NSString*)getPublicityDetailsUrl{
    return nil;
}

@end
