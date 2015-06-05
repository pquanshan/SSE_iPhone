//
//  HSRegisterDataKey_TCMP.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/5/10.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSRegisterDataKey.h"

@implementation HSRegisterDataKey_TCMP

-(NSDictionary*)registerProTypeDicKeyData{
    return @{
             @"flowType"        :@"flowtype",
             @"flowTypeName"    :@"flowtypename",
             @"taskNum"         :@"tasknum"
             };
}

-(NSDictionary*)registerWillDoDicKeyData{
    return @{
             @"taskId"          :@"taskid",
             @"flowType"        :@"flowtype",
             @"flowTypeName"    :@"flowtypename",
             @"flowName"        :@"flowname",
             @"starterName"     :@"starter",
             @"startTime"       :@"starttime",
             @"nodeName"        :@"nodename",
             @"taskType"        :@"tasktype"
             };
}

-(NSDictionary*)registerDidDoDicKeyData{
    return @{
             @"instanceId"      :@"instanceid",
             @"flowType"        :@"flowtype",
             @"flowTypeName"    :@"flowtypename",
             @"flowName"        :@"flowname",
             @"starterName"     :@"starter",
             @"startOrgName"    :@"",
             @"startTime"       :@"starttime",
             @"flowStatus"      :@"flowstatus",
             @"taskType"        :@"",
             @"nodeName"        :@"",
             @"assignName"      :@"",
             };
}

-(NSDictionary*)registerWillDoDetailDicKeyData{
    return @{
             @"instanceId"      :@"instanceid",
             @"taskId"          :@"taskid",
             @"flowName"        :@"flowname",
             @"processName"     :@"processname",
             @"starterName"     :@"starter",
             @"startTime"       :@"starttime",
             @"nodeName"        :@"nodename",
             @"flowInfo"        :@"flowinfo"
             };
}

-(NSDictionary*)registerDidDoDetailDicKeyData{
    return @{
             @"instanceId"      :@"instanceid",
             @"flowName"        :@"flowname",
             @"processName"     :@"processname",
             @"starterName"     :@"starter",
             @"startTime"       :@"starttime",
             @"nodeName"        :@"nodename",
             @"flowInfo"        :@"flowinfo"
             };
}

-(NSDictionary*)registerHistoryOpiDicKeyData{
    return @{
             @"nodeName"        :@"nodename",
             @"approveUser"     :@"approveuser",
             @"approveTime"     :@"approvetime",
             @"remark"          :@"remark"
             };
}

-(NSDictionary*)registerNewsDicKeyData{
    return @{
             @"messageid"       :@"",
             @"title"           :@"title",
             @"sender"          :@"",
             @"isread"          :@"",
             @"mark"            :@"",
             @"sendtime"        :@"sendtime"
             };
}

-(NSDictionary*)registerNewsDetailDicKeyData{
    return @{
             @"title"           :@"",
             @"sender"          :@"",
             @"mark"            :@"",
             @"sendtime"        :@"",
             @"content"         :@""
             };
}

-(NSDictionary*)registerProjectDicKeyData{
    return @{
             @"projectId"           :@"",
             @"projectCode"         :@"",
             @"projectName"         :@"",
             @"projectType"         :@"",
             @"plannedFundingAmt"   :@"",
             @"projectOuterStatus"  :@"",
             @"planName"            :@"",
             @"baseAssertType"      :@""
             };
}

-(NSDictionary*)registerProjectDetailDicKeyData{
    return @{
             @"projectId"           :@"",
             @"projectCode"         :@"",
             @"projectName"         :@"",
             @"plannedFundingAmt"   :@"",
             @"projectOuterStatus"  :@"",
             @"projectStage"        :@"",
             @"issuer"              :@"",
             @"listedCompanyName"   :@"",
             @"enterpriseType"      :@"",
             @"industry"            :@"",
             @"sponsor"             :@"",
             @"planName"             :@"",
             @"baseAssertType"       :@"",
             @"baseAssertDefinition" :@"",
             @"baseAssertIndustry"   :@"",
             @"priorityScale"        :@"",
             @"afterPriorityScale"   :@"",
             @"secondaryScale"       :@""
             };
    
}

-(NSDictionary*)registerPublicInfoDicKeyData{
    return @{
             @"projectId"           :@"",
             @"projectCode"         :@"",
             @"projectName"         :@"",
             @"projectType"         :@"",
             @"plannedFundingAmt"   :@"",
             @"issuer"              :@"",
             @"listedCompanyName"   :@"",
             @"sponsor"             :@"",
             @"projectOuterStatus"  :@"",
             @"lastestModifyDatetime"  :@""
             };
}

-(NSDictionary*)registerPublicInfoDetailDicKeyData{
    return @{
             @"projectId"           :@"",
             @"projectCode"         :@"",
             @"projectName"         :@"",
             @"projectType"         :@"",
             @"plannedFundingAmt"   :@"",
             @"listedCompanyName"   :@"",
             @"sponsor"             :@"",
             @"projectOuterStatus"  :@"",
             @"lastestModifyDatetime"  :@"",
             @"projectType"         :@"",
             @"industryName"        :@"",
             @"confirmFileNo"       :@""
             };
    
}


-(NSArray*)getProjectTypeKey{
    return @[@{@"TCMP1"         :@"1"},
             @{@"TCMP2"         :@"2"}
             ];
}

@end
