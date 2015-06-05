//
//  HSDataModel.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/5/9.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSDataModel.h"
#import "HSRegisterDataKey.h"

@implementation HSDataModel
-(id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)setDataByDictionary:(NSDictionary*)dataDic{
}
@end


@implementation HSDataProTypeModel
-(void)setDataByDictionary:(NSDictionary*)dataDic{
    self.registerDicKey = [[HSRegisterDataKey sharedRegisterDataKey] registerProTypeDicKeyData];
    _flowType = [dataDic objectForKey:[self.registerDicKey objectForKey:@"flowType"]];
    _flowTypeName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"flowTypeName"]];
    _taskNum = [dataDic objectForKey:[self.registerDicKey objectForKey:@"taskNum"]];
}
@end

@implementation HSDataWillDoModel
-(void)setDataByDictionary:(NSDictionary*)dataDic{
    self.registerDicKey = [[HSRegisterDataKey sharedRegisterDataKey] registerWillDoDicKeyData];
    _instanceId = [dataDic objectForKey:[self.registerDicKey objectForKey:@"instanceId"]];
    _taskId = [dataDic objectForKey:[self.registerDicKey objectForKey:@"taskId"]];
    _flowType = [dataDic objectForKey:[self.registerDicKey objectForKey:@"flowType"]];
    _flowTypeName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"flowTypeName"]];
    _flowName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"flowName"]];
    _starterName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"starterName"]];
    _startTime = [dataDic objectForKey:[self.registerDicKey objectForKey:@"startTime"]];
    _nodeName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"nodeName"]];
    _taskType = [dataDic objectForKey:[self.registerDicKey objectForKey:@"taskType"]];
}
@end

@implementation HSDataDidDoModel
-(void)setDataByDictionary:(NSDictionary*)dataDic{
    self.registerDicKey = [[HSRegisterDataKey sharedRegisterDataKey] registerDidDoDicKeyData];
    _instanceId = [dataDic objectForKey:[self.registerDicKey objectForKey:@"instanceId"]];
    _taskId = [dataDic objectForKey:[self.registerDicKey objectForKey:@"taskId"]];
    _flowType = [dataDic objectForKey:[self.registerDicKey objectForKey:@"flowType"]];
    _flowTypeName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"flowTypeName"]];
    _flowName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"flowName"]];
    _starterName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"starterName"]];
    _startOrgName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"startOrgName"]];
    _startTime = [dataDic objectForKey:[self.registerDicKey objectForKey:@"startTime"]];
    _flowStatus = [dataDic objectForKey:[self.registerDicKey objectForKey:@"flowStatus"]];
    _taskType = [dataDic objectForKey:[self.registerDicKey objectForKey:@"taskType"]];
    _nodeName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"nodeName"]];
    _assignName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"assignName"]];
}
@end

@implementation HSDataWillDoDetailModel
-(void)setDataByDictionary:(NSDictionary*)dataDic{
    self.registerDicKey = [[HSRegisterDataKey sharedRegisterDataKey] registerWillDoDetailDicKeyData];
    _instanceId = [dataDic objectForKey:[self.registerDicKey objectForKey:@"instanceId"]];
    _taskId = [dataDic objectForKey:[self.registerDicKey objectForKey:@"taskId"]];
    _flowName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"flowName"]];
    _processName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"processName"]];
    _starterName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"starterName"]];
    _startTime = [dataDic objectForKey:[self.registerDicKey objectForKey:@"startTime"]];
    _nodeName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"nodeName"]];
    _flowInfo = [dataDic objectForKey:[self.registerDicKey objectForKey:@"flowInfo"]];
    
}
@end

@implementation HSDataDidDoDetailModel
-(void)setDataByDictionary:(NSDictionary*)dataDic{
    self.registerDicKey = [[HSRegisterDataKey sharedRegisterDataKey] registerDidDoDetailDicKeyData];
    _instanceId = [dataDic objectForKey:[self.registerDicKey objectForKey:@"instanceId"]];
    _flowName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"flowName"]];
    _processName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"processName"]];
    _starterName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"starterName"]];
    _startTime = [dataDic objectForKey:[self.registerDicKey objectForKey:@"startTime"]];
    _nodeName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"nodeName"]];
    _flowInfo = [dataDic objectForKey:[self.registerDicKey objectForKey:@"flowInfo"]];
}
@end

@implementation HSDataHistoryOpiModel
-(void)setDataByDictionary:(NSDictionary*)dataDic{
    self.registerDicKey = [[HSRegisterDataKey sharedRegisterDataKey] registerHistoryOpiDicKeyData];
    _nodeName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"nodeName"]];
    _approveUser = [dataDic objectForKey:[self.registerDicKey objectForKey:@"approveUser"]];
    _approveTime = [dataDic objectForKey:[self.registerDicKey objectForKey:@"approveTime"]];
    _remark = [dataDic objectForKey:[self.registerDicKey objectForKey:@"remark"]];
}
@end

@implementation HSDataNewsModel
-(void)setDataByDictionary:(NSDictionary*)dataDic{
    self.registerDicKey = [[HSRegisterDataKey sharedRegisterDataKey] registerNewsDicKeyData];
    _messageid = [dataDic objectForKey:[self.registerDicKey objectForKey:@"messageid"]];
    _title = [dataDic objectForKey:[self.registerDicKey objectForKey:@"title"]];
    _sender = [dataDic objectForKey:[self.registerDicKey objectForKey:@"sender"]];
    _isread = [dataDic objectForKey:[self.registerDicKey objectForKey:@"isread"]];
    _mark = [dataDic objectForKey:[self.registerDicKey objectForKey:@"mark"]];
    _sendtime = [dataDic objectForKey:[self.registerDicKey objectForKey:@"sendtime"]];
}
@end

@implementation HSDataNewsDetailModel
-(void)setDataByDictionary:(NSDictionary*)dataDic{
    self.registerDicKey = [[HSRegisterDataKey sharedRegisterDataKey] registerNewsDetailDicKeyData];
    _title = [dataDic objectForKey:[self.registerDicKey objectForKey:@"title"]];
    _sender = [dataDic objectForKey:[self.registerDicKey objectForKey:@"sender"]];
    _mark = [dataDic objectForKey:[self.registerDicKey objectForKey:@"mark"]];
    _sendtime = [dataDic objectForKey:[self.registerDicKey objectForKey:@"sendtime"]];
    _content = [dataDic objectForKey:[self.registerDicKey objectForKey:@"content"]];
}
@end

@implementation HSDataProjectModel
-(void)setDataByDictionary:(NSDictionary*)dataDic{
    self.registerDicKey = [[HSRegisterDataKey sharedRegisterDataKey]  registerProjectDicKeyData];
    _projectId = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectId"]];
    _projectCode = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectCode"]];
    _projectType = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectType"]];
    _projectName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectName"]];
    _plannedFundingAmt = [dataDic objectForKey:[self.registerDicKey objectForKey:@"plannedFundingAmt"]];
    _projectOuterStatus = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectOuterStatus"]];
    _planName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"planName"]];
    _baseAssertType = [dataDic objectForKey:[self.registerDicKey objectForKey:@"baseAssertType"]];
}
@end

@implementation HSDataProjectDetailModel
-(void)setDataByDictionary:(NSDictionary*)dataDic{
    self.registerDicKey = [[HSRegisterDataKey sharedRegisterDataKey]  registerProjectDetailDicKeyData];
    _projectId = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectId"]];
    _projectCode = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectCode"]];
    _projectType = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectType"]];
    _projectName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectName"]];
    _plannedFundingAmt = [dataDic objectForKey:[self.registerDicKey objectForKey:@"plannedFundingAmt"]];
    _projectOuterStatus = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectOuterStatus"]];
    _projectStage = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectStage"]];
    _issuer = [dataDic objectForKey:[self.registerDicKey objectForKey:@"issuer"]];
    _listedCompanyName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"listedCompanyName"]];
    _enterpriseType = [dataDic objectForKey:[self.registerDicKey objectForKey:@"enterpriseType"]];
    _industry = [dataDic objectForKey:[self.registerDicKey objectForKey:@"industry"]];
    _sponsor = [dataDic objectForKey:[self.registerDicKey objectForKey:@"sponsor"]];
    _planName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"planName"]];
    _baseAssertType = [dataDic objectForKey:[self.registerDicKey objectForKey:@"baseAssertType"]];
    _baseAssertDefinition = [dataDic objectForKey:[self.registerDicKey objectForKey:@"baseAssertDefinition"]];
    _baseAssertIndustry = [dataDic objectForKey:[self.registerDicKey objectForKey:@"baseAssertIndustry"]];
    _priorityScale = [dataDic objectForKey:[self.registerDicKey objectForKey:@"priorityScale"]];
    _afterPriorityScale = [dataDic objectForKey:[self.registerDicKey objectForKey:@"afterPriorityScale"]];
    _secondaryScale = [dataDic objectForKey:[self.registerDicKey objectForKey:@"secondaryScale"]];
}
@end

@implementation HSDataPublicInfoModel
-(void)setDataByDictionary:(NSDictionary*)dataDic{
    self.registerDicKey = [[HSRegisterDataKey sharedRegisterDataKey]  registerPublicInfoDicKeyData];
    _projectId = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectId"]];
    _projectCode = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectCode"]];
    _projectType = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectType"]];
    _projectName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectName"]];
    _plannedFundingAmt = [dataDic objectForKey:[self.registerDicKey objectForKey:@"plannedFundingAmt"]];
    _issuer = [dataDic objectForKey:[self.registerDicKey objectForKey:@"issuer"]];
    _listedCompanyName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"listedCompanyName"]];
    _sponsor = [dataDic objectForKey:[self.registerDicKey objectForKey:@"sponsor"]];
    _projectOuterStatus = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectOuterStatus"]];
    _lastestModifyDatetime = [dataDic objectForKey:[self.registerDicKey objectForKey:@"lastestModifyDatetime"]];
}
@end

@implementation HSDataPublicInfoDetailModel
-(void)setDataByDictionary:(NSDictionary*)dataDic{
    self.registerDicKey = [[HSRegisterDataKey sharedRegisterDataKey]  registerPublicInfoDetailDicKeyData];
    _projectId = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectId"]];
    _projectCode = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectCode"]];
    _projectName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectName"]];
    _projectType = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectType"]];
    _plannedFundingAmt = [dataDic objectForKey:[self.registerDicKey objectForKey:@"plannedFundingAmt"]];
    _listedCompanyName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"listedCompanyName"]];
    _sponsor = [dataDic objectForKey:[self.registerDicKey objectForKey:@"sponsor"]];
    _projectOuterStatus = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectOuterStatus"]];
    _lastestModifyDatetime = [dataDic objectForKey:[self.registerDicKey objectForKey:@"lastestModifyDatetime"]];
    _projectType = [dataDic objectForKey:[self.registerDicKey objectForKey:@"projectType"]];
    _industryName = [dataDic objectForKey:[self.registerDicKey objectForKey:@"industryName"]];
    _confirmFileNo = [dataDic objectForKey:[self.registerDicKey objectForKey:@"confirmFileNo"]];
}
@end