//
//  HSRegisterDataKey_SSE_Stock.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/5/10.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSRegisterDataKey.h"

@implementation HSRegisterDataKey_SSE_Stock

-(NSDictionary*)registerProTypeDicKeyData{
    return @{
             @"flowType"        :@"flowType",
             @"flowTypeName"    :@"flowTypeName",
             @"taskNum"         :@"taskNum"
             };
}

-(NSDictionary*)registerWillDoDicKeyData{
    return @{
             @"instanceId"      :@"instanceId",
             @"taskId"          :@"taskId",
             @"flowType"        :@"flowType",
             @"flowTypeName"    :@"flowTypeName",
             @"flowName"        :@"flowName",
             @"starterName"     :@"starterName",
             @"startTime"       :@"startTime",
             @"nodeName"        :@"nodeName",
             @"taskType"        :@"taskType"
             };
}

-(NSDictionary*)registerDidDoDicKeyData{
    return @{
             @"instanceId"      :@"instanceId",
             @"taskId"          :@"",
             @"flowType"        :@"flowType",
             @"flowTypeName"    :@"flowTypeName",
             @"flowName"        :@"flowName",
             @"starterName"     :@"starterName",
             @"startOrgName"    :@"startOrgName",
             @"startTime"       :@"startTime",
             @"flowStatus"      :@"flowStatus",
             @"taskType"        :@"taskType",
             @"nodeName"        :@"nodeName",
             @"assignName"      :@"assignName",
             };
}

-(NSDictionary*)registerWillDoDetailDicKeyData{
    return @{
             @"instanceId"      :@"instanceId",
             @"taskId"          :@"taskId",
             @"flowName"        :@"flowName",
             @"processName"     :@"processName",
             @"starterName"     :@"starterName",
             @"startTime"       :@"startTime",
             @"nodeName"        :@"nodeName",
             @"flowInfo"        :@"flowInfo"
             };
}

-(NSDictionary*)registerDidDoDetailDicKeyData{
    return @{
             @"instanceId"      :@"instanceId",
             @"flowName"        :@"flowName",
             @"processName"     :@"processName",
             @"starterName"     :@"starterName",
             @"startTime"       :@"startTime",
             @"nodeName"        :@"nodeName",
             @"flowInfo"        :@"flowInfo"
             };
}

-(NSDictionary*)registerHistoryOpiDicKeyData{
    return @{
             @"nodeName"        :@"nodeName",
             @"approveUser"     :@"approveUser",
             @"approveTime"     :@"approveTime",
             @"remark"          :@"remark"
             };
}

-(NSDictionary*)registerNewsDicKeyData{
    return @{
             @"messageid"       :@"messageid",
             @"title"           :@"title",
             @"sender"          :@"sender",
             @"isread"          :@"isread",
             @"mark"            :@"mark",
             @"sendtime"        :@"sendtime"
             };
}

-(NSDictionary*)registerNewsDetailDicKeyData{
    return @{
             @"title"           :@"title",
             @"sender"          :@"sender",
             @"mark"            :@"mark",
             @"sendtime"        :@"sendtime",
             @"content"         :@"content"
             };
}

-(NSDictionary*)registerProjectDicKeyData{
    return @{
             @"projectId"           :@"",
             @"projectCode"         :@"projectCode",
             @"projectName"         :@"projectName",
             @"projectType"         :@"",
             @"plannedFundingAmt"   :@"plannedFundingAmt",
             @"projectOuterStatus"  :@"projectOuterStatus",
             @"planName"            :@"",
             @"baseAssertType"      :@""
             };
}

-(NSDictionary*)registerProjectDetailDicKeyData{
    return @{
             @"projectId"           :@"",
             @"projectCode"         :@"projectCode",
             @"projectName"         :@"projectName",
             @"projectType"         :@"",
             @"plannedFundingAmt"   :@"plannedFundingAmt",
             @"projectOuterStatus"  :@"projectOuterStatus",
             @"projectStage"        :@"projectStage",
             @"issuer"              :@"",
             @"listedCompanyName"   :@"listedCompanyName",
             @"enterpriseType"      :@"enterpriseType",
             @"industry"            :@"industry",
             @"sponsor"             :@"sponsor",
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
             @"projectCode"         :@"projectCode",
             @"projectName"         :@"projectName",
             @"projectType"         :@"",
             @"plannedFundingAmt"   :@"plannedFundingAmt",
             @"issuer"              :@"",
             @"listedCompanyName"   :@"listedCompanyName",
             @"sponsor"             :@"sponsor",
             @"projectOuterStatus"  :@"projectOuterStatus",
             @"lastestModifyDatetime"  :@"lastestModifyDatetime"
             };
}

-(NSDictionary*)registerPublicInfoDetailDicKeyData{
    return @{
             @"projectId"           :@"",
             @"projectCode"         :@"projectCode",
             @"projectName"         :@"projectName",
             @"projectType"         :@"",
             @"plannedFundingAmt"   :@"plannedFundingAmt",
             @"listedCompanyName"   :@"listedCompanyName",
             @"sponsor"             :@"sponsor",
             @"projectOuterStatus"  :@"projectOuterStatus",
             @"lastestModifyDatetime"  :@"lastestModifyDatetime",
             @"projectType"         :@"projectType",
             @"industryName"        :@"industryName",
             @"confirmFileNo"        :@""
             };
    
}


-(NSArray*)getProjectTypeKey{
    return @[@{@"IPO"           :@"1"},
             @{@"再融资"         :@"2"}
             ];

}

@end
