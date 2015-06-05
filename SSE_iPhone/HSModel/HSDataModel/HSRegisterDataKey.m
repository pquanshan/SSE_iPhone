//
//  HSRegisterDataKey.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/5/10.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSRegisterDataKey.h"
#import "HSModel.h"

@implementation HSRegisterDataKey

+(HSRegisterDataKey*) sharedRegisterDataKey{
    static HSRegisterDataKey *sharedObj = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        switch ([HSModel sharedHSModel].appSystem) {
            case HSAppSystemBond:
                sharedObj = [[HSRegisterDataKey_SSE_Bond alloc] init];
                break;
            case HSAppSystemStock:
                sharedObj = [[HSRegisterDataKey_SSE_Stock alloc] init];
                break;
            case HSAppSystemTCMP:
                sharedObj = [[HSRegisterDataKey_TCMP alloc] init];
                break;
            default:
                sharedObj = [[HSRegisterDataKey alloc] init];
                break;
        }
        
    });
    return sharedObj;
}

-(NSDictionary*)registerProTypeDicKeyData{
    return @{
             @"flowType"        :@"",
             @"flowTypeName"    :@"",
             @"taskNum"         :@""
             };
}

-(NSDictionary*)registerWillDoDicKeyData{
    return @{
             @"instanceId"      :@"",
             @"taskId"          :@"",
             @"flowType"        :@"",
             @"flowTypeName"    :@"",
             @"flowName"        :@"",
             @"starterName"     :@"",
             @"startTime"       :@"",
             @"nodeName"        :@"",
             @"taskType"        :@""
             };
}

-(NSDictionary*)registerDidDoDicKeyData{
    return @{
             @"instanceId"      :@"",
             @"flowType"        :@"",
             @"flowTypeName"    :@"",
             @"flowName"        :@"",
             @"starterName"     :@"",
             @"startOrgName"    :@"",
             @"startTime"       :@"",
             @"flowStatus"      :@"",
             @"taskType"        :@"",
             @"nodeName"        :@"",
             @"assignName"      :@"",
             };
}

-(NSDictionary*)registerWillDoDetailDicKeyData{
    return @{
             @"instanceId"      :@"",
             @"taskId"          :@"",
             @"flowName"        :@"",
             @"processName"     :@"",
             @"starterName"     :@"",
             @"startTime"       :@"",
             @"nodeName"        :@"",
             @"flowInfo"        :@""
             };
}

-(NSDictionary*)registerDidDoDetailDicKeyData{
    return @{
             @"instanceId"      :@"",
             @"flowName"        :@"",
             @"processName"     :@"",
             @"starterName"     :@"",
             @"startTime"       :@"",
             @"nodeName"        :@"",
             @"flowInfo"        :@""
             };
}

-(NSDictionary*)registerHistoryOpiDicKeyData{
    return @{
             @"nodeName"        :@"",
             @"approveUser"     :@"",
             @"approveTime"     :@"",
             @"remark"          :@""
             };
}

-(NSDictionary*)registerNewsDicKeyData{
    return @{
             @"messageid"       :@"",
             @"title"           :@"",
             @"sender"          :@"",
             @"isread"          :@"",
             @"mark"            :@"",
             @"sendtime"        :@""
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
             @"projectType"         :@"",
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
    return nil;
}

@end
