//
//  HSURLBusiness_SSE_Stock.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/1.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSURLBusiness.h"
#import "HSConfig.h"
#import "HSUtils.h"

@implementation HSURLBusiness_SSE_Stock
-(NSString*)getMBPUrl{
//    return @"http://192.168.2.27:8008/mbp/sse/"; //无线地址:apple的MacBook Pro
//    return @"http://192.168.90.221:8008/mbp/sse/";
//    return @"http://192.168.245.215:8008/mbp/sse/"; //内网
    
//    return @"http://192.168.57.163:8008/mbp/sse/"; //内网
//    return @"http://192.168.90.163:8008/mbp/sse/"; //内网 孙维
//    return @"http://192.168.90.178:8008/mbp/sse/"; //内网 孙维
    return @"http://192.168.90.166:8008/mbp/sse/"; //内网 孙维
}

-(NSString*)getLoginUrl{
    return [NSString stringWithFormat:@"%@login.jsp?clienttype=%@&clientsign=sse.com.cn&devicetoken=%@&deviceid=%@",[self getMBPUrl],STRING_CLIENT_TYPE,[[HSModel sharedHSModel] deviceTokenStr],[HSUtils getUUID]];
}

-(NSString*)getLogoutUrl{
    return [NSString stringWithFormat:@"%@logout.jsp?clienttype=%@&clientsign=sse.com.cn",[self getMBPUrl],STRING_CLIENT_TYPE];
}
//
-(NSString*)getSMSCheckUrl{
    return [NSString stringWithFormat:@"%@data.jsp?functionid=1020003&clienttype=%@&clientsign=sse.com.cn",[self getMBPUrl],STRING_CLIENT_TYPE];
}

-(NSString*)getSafetyCodeCheckUrl{
    return [NSString stringWithFormat:@"%@data.jsp?functionid=1020004&clienttype=%@&clientsign=sse.com.cn",[self getMBPUrl],STRING_CLIENT_TYPE];
}

-(NSString*)getProcessCategoryUrl{
    return [NSString stringWithFormat:@"%@data.jsp?userid=%@&functionid=2250106",[self getMBPUrl],[[HSModel sharedHSModel] userId]];
}

-(NSString*)getProcWillDoListUrl{
    return [NSString stringWithFormat:@"%@data.jsp?userid=%@&functionid=2250101",[self getMBPUrl],[[HSModel sharedHSModel] userId]];
}

-(NSString*)getProcDidDoListUrl{
    return [NSString stringWithFormat:@"%@data.jsp?userid=%@&functionid=2250102",[self getMBPUrl],[[HSModel sharedHSModel] userId]];
}

-(NSString*)getProcWillDoDetailInfoUrl{
    return [NSString stringWithFormat:@"%@data.jsp?userid=%@&functionid=2250103",[self getMBPUrl],[[HSModel sharedHSModel] userId]];
}

-(NSString*)getProcDidDoDetailInfoUrl{
    return [NSString stringWithFormat:@"%@data.jsp?userid=%@&functionid=2250104",[self getMBPUrl],[[HSModel sharedHSModel] userId]];
}

-(NSString*)getProcHistoryOpinionUrl{
    return [NSString stringWithFormat:@"%@data.jsp?userid=%@&functionid=2250105",[self getMBPUrl],[[HSModel sharedHSModel] userId]];
}

-(NSString*)getNewsListUrl{
    return [NSString stringWithFormat:@"%@data.jsp?userid=%@&functionid=1020101",[self getMBPUrl],[[HSModel sharedHSModel] userId]];
}

-(NSString*)getNewsDetailsUrl{
    return [NSString stringWithFormat:@"%@data.jsp?userid=%@&functionid=1020102",[self getMBPUrl],[[HSModel sharedHSModel] userId]];
}

-(NSString*)getNewsUnreadStatisticsUrl{
     return [NSString stringWithFormat:@"%@data.jsp?userid=%@&functionid=1020103",[self getMBPUrl],[[HSModel sharedHSModel] userId]];
}

-(NSString*)getNewsUnreadConvertReadUrl{
    return [NSString stringWithFormat:@"%@data.jsp?userid=%@&functionid=1020104",[self getMBPUrl],[[HSModel sharedHSModel] userId]];
}

-(NSString*)getProjectListUrl{
    return [NSString stringWithFormat:@"%@data.jsp?userid=%@&functionid=2250201",[self getMBPUrl],[[HSModel sharedHSModel] userId]];
}

-(NSString*)getProjectDetailsUrl{
    return [NSString stringWithFormat:@"%@data.jsp?userid=%@&functionid=2250202",[self getMBPUrl],[[HSModel sharedHSModel] userId]];
}

-(NSString*)getPublicityListUrl{
    return [NSString stringWithFormat:@"%@data_not_session.jsp?functionid=2250001",[self getMBPUrl]];
}

-(NSString*)getPublicityDetailsUrl{
    return [NSString stringWithFormat:@"%@data_not_session.jsp?functionid=2250002",[self getMBPUrl]];
}

@end
