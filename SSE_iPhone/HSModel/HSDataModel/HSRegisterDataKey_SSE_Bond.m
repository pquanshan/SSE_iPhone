//
//  HSRegisterDataKey_SSE_Bond.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/5/10.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSRegisterDataKey.h"

@implementation HSRegisterDataKey_SSE_Bond

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
             @"starterName"     :@"starter",
             @"startTime"       :@"startTime",
             @"nodeName"        :@"nodeName",
             @"taskType"        :@"taskType"
             };
}

-(NSDictionary*)registerDidDoDicKeyData{
    return @{
             @"instanceId"      :@"instanceId",
             @"taskId"          :@"taskId",
             @"flowType"        :@"flowType",
             @"flowTypeName"    :@"flowTypeName",
             @"flowName"        :@"flowName",
             @"starterName"     :@"starter",
             @"startOrgName"    :@"startOrg",
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
             @"starterName"     :@"starter",
             @"startTime"       :@"startTime",
             @"nodeName"        :@"nodeName",
             @"flowInfo"        :@"flowInfo"
             };
}

-(NSDictionary*)registerDidDoDetailDicKeyData{
    return @{
             @"instanceId"      :@"instanceId",
//             TaskId
             @"flowName"        :@"flowName",
             @"processName"     :@"processName",
             @"starterName"     :@"starter",
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
//             opTypeName
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
             @"projectId"           :@"projectId",
             @"projectCode"         :@"projectNo",
             @"projectName"         :@"projectName",
             @"projectType"         :@"projectType",
             @"plannedFundingAmt"   :@"projectScale",
             @"projectOuterStatus"  :@"projectStatus",
             @"planName"            :@"planName",
             @"baseAssertType"      :@"baseAssertType"
             };
}

-(NSDictionary*)registerProjectDetailDicKeyData{
    return @{
             @"projectId"           :@"projectId",
             @"projectCode"         :@"projectNo",
             @"projectName"         :@"projectName",
             @"projectType"         :@"projectType",
             @"plannedFundingAmt"   :@"projectScale",
             @"projectOuterStatus"  :@"projectStatus",
             @"projectStage"        :@"projectStage",
             @"issuer"              :@"issuer",
             @"listedCompanyName"   :@"",
             @"enterpriseType"      :@"",
             @"industry"            :@"",
             @"sponsor"             :@"underwriter",
             @"planName"             :@"planName",
             @"baseAssertType"       :@"baseAssertType",
             @"baseAssertDefinition" :@"baseAssertDefinition",
             @"baseAssertIndustry"   :@"baseAssertIndustry",
             @"priorityScale"        :@"priorityScale",
             @"afterPriorityScale"   :@"afterPriorityScale",
             @"secondaryScale"       :@"secondaryScale"
             };
    
}

-(NSDictionary*)registerPublicInfoDicKeyData{
    return @{
             @"projectId"           :@"projectId",
             @"projectCode"         :@"projectNo",
             @"projectName"         :@"projectName",
             @"projectType"         :@"projectType",
             @"plannedFundingAmt"   :@"balance",
             @"issuer"              :@"issuer",
             @"listedCompanyName"   :@"issuer",
             @"sponsor"             :@"underwriter",
             @"projectOuterStatus"  :@"status",
             @"lastestModifyDatetime"  :@"updateDate"
             };
}

-(NSDictionary*)registerPublicInfoDetailDicKeyData{
    return @{
             @"projectId"           :@"projectId",
             @"projectCode"         :@"projectNo",
             @"projectName"         :@"projectName",
             @"projectType"         :@"projectType",
             @"plannedFundingAmt"   :@"balance",
             @"listedCompanyName"   :@"issuer",
             @"sponsor"             :@"underwriter",
             @"projectOuterStatus"  :@"status",
             @"lastestModifyDatetime"  :@"updateDate",
             @"projectType"         :@"projectType",
             @"industryName"        :@"",
             @"confirmFileNo"       :@"confirmFileNo"
             };
    
}


-(NSArray*)getProjectTypeKey{
    return @[@{@"公募债券"       :@"0"},
             @{@"私募债券"       :@"1"},
             @{@"ABS债券"       :@"2"},
             ];
    
}

@end
