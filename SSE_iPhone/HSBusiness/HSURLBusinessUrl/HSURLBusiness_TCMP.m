//
//  HSURLBusiness_TCMP.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/1.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSURLBusiness.h"
#import "HSConfig.h"
#import "HSUtils.h"

//恒生测试
#define CC_CUSTOMER_HS_URL      @"http://crm3.hundsun.com/mbp/tcmp/"
//民生信托:测试环境 内网10.0.60.201 8008
#define CC_CUSTOMER_MSXT_URL    @"http://111.204.210.120:8008/tcmp/"
//华澳信托
#define CC_CUSTOMER_HAXT_URL    @"http://180.168.5.5:5008/mo32_server/tcmp/"
//苏州信托
#define CC_CUSTOMER_SZXT_URL    @"http://service.trustsz.com:7001/tcmp/"
//爱建信托
#define CC_CUSTOMER_AJXT_URL    @"http://180.169.8.82:7001/mbp/tcmp/"
//渤海信托
#define CC_CUSTOMER_BHXT_URL    @"http://tcmpmobile.bohaitrust.com/mbp/tcmp/"
//山东信托
#define CC_CUSTOMER_SDXT_URL    @"http://60.216.47.25:8008/mbp/tcmp/"
//陆家嘴信托
#define CC_CUSTOMER_LJZXT_URL   @"http://116.236.240.67:8008/mbp/tcmp/"
//西藏信托
#define CC_CUSTOMER_XZXT_URL    @"http://123.124.226.112:8008/mbp/tcmp/"
//德邦信托
#define CC_CUSTOMER_DBXT_URL    @"http://101.95.24.234:8008/mbp/tcmp/"
//新华富时:外网119.161.235.83 8080 内网10.10.10.217 8080
#define CC_CUSTOMER_XHXT_URL    @"http://sj.ncfszc.com:8080/mbp/tcmp/"
//交银国际
//测试环境 内网130.0.60.101 7002  外网112.64.146.74 7002
#define CC_CUSTOMER_JYGJ_URL    @"http://mobile.bocommtrust.com:7002/mbp/tcmp/"
//四川信托
//测试环境 内网地址:172.16.40.143 8008
#define CC_CUSTOMER_SCXT_URL    @"http://172.16.40.143:8008/mbp/tcmp/"
//万家共赢:测试环境 内网地址:172.16.10.69 80 生产环境 外网地址:180.169.5.147 80
#define CC_CUSTOMER_WJGY_URL    @"http://180.169.5.147/mbp/tcmp/"
//中海恒信:测试环境 内网地址:192.168.221.112:8081 生产环境 外网地址:180.166.141.247:8081
#define CC_CUSTOMER_ZHHX_URL    @"http://180.166.141.247:8081/mbp/tcmp/"
//中信信诚:测试环境 内网地址:128.236.163.39:7001 外网地址:140.206.53.222:7787
#define CC_CUSTOMER_ZXXC_URL    @"https://tcmp.citiccpamc.com.cn:7787/mbp/tcmp/"


#define CC_CUSTOMER_URL         CC_CUSTOMER_HS_URL


@implementation HSURLBusiness_TCMP
-(NSString*)getMBPUrl{
    return CC_CUSTOMER_URL;
}

-(NSString*)getLoginUrl{
    return [NSString stringWithFormat:@"%@login.jsp?clienttype=%@&deviceid=%@&devicetoken=%@&apiversion=%@&deviceversion=%@",[self getMBPUrl],STRING_CLIENT_TYPE,[HSUtils getUUID],[HSUtils getDeviceToken],STRING_API_VERSION,[HSUtils getDeviceVersion]];
}

-(NSString*)getLogoutUrl{
    return [NSString stringWithFormat:@"%@logout.jsp?interfaceid=R8003",[self getMBPUrl]];
}

-(NSString*)getSMSCheckUrl{
    return nil;
}

-(NSString*)getSafetyCodeCheckUrl{
    return nil;
}

-(NSString*)getProcessCategoryUrl{
    return [NSString stringWithFormat:@"%@data.jsp?interfaceid=R8107",[self getMBPUrl]];
}

-(NSString*)getProcWillDoListUrl{
    return [NSString stringWithFormat:@"%@data.jsp?interfaceid=R8101",[self getMBPUrl]];
}

-(NSString*)getProcDidDoListUrl{
    return [NSString stringWithFormat:@"%@data.jsp?interfaceid=R8102",[self getMBPUrl]];
}

-(NSString*)getProcWillDoDetailInfoUrl{
    return [NSString stringWithFormat:@"%@data.jsp?interfaceid=R8103",[self getMBPUrl]];
}

-(NSString*)getProcDidDoDetailInfoUrl{
    return [NSString stringWithFormat:@"%@data.jsp?interfaceid=R8104",[self getMBPUrl]];
}

-(NSString*)getProcHistoryOpinionUrl{
    return [NSString stringWithFormat:@"%@data.jsp?interfaceid=R8105",[self getMBPUrl]];
}

-(NSString*)getNewsListUrl{
    return [NSString stringWithFormat:@"%@data.jsp?interfaceid=R8200",[self getMBPUrl]];
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
