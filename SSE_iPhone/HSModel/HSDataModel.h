//
//  HSDataModel.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/5/9.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSDataModel : NSObject
@property(nonatomic,strong) NSDictionary* registerDicKey;
-(void)setDataByDictionary:(NSDictionary*)dataDic;
@end

//流程分类数据
@interface HSDataProTypeModel: HSDataModel
@property(nonatomic,strong) NSString* flowType;         //流程类型
@property(nonatomic,strong) NSString* flowTypeName;     //流程类型名称
@property(nonatomic,strong) NSString* taskNum;          //代办任务个数
@end

//流程待办数据
@interface HSDataWillDoModel: HSDataModel
@property(nonatomic,strong) NSString* instanceId;       //流程编号
@property(nonatomic,strong) NSString* taskId;           //任务编号
@property(nonatomic,strong) NSString* flowType;         //流程类型
@property(nonatomic,strong) NSString* flowTypeName;     //流程类型名称
@property(nonatomic,strong) NSString* flowName;         //流程标题
@property(nonatomic,strong) NSString* starterName;      //发起人
@property(nonatomic,strong) NSString* startTime;        //发起时间
@property(nonatomic,strong) NSString* nodeName;         //当前处理节点
@property(nonatomic,strong) NSString* taskType;         //任务类型
@end

//流程已办数据
@interface HSDataDidDoModel: HSDataModel
@property(nonatomic,strong) NSString* instanceId;       //流程编号
@property(nonatomic,strong) NSString* taskId;           //任务编号
@property(nonatomic,strong) NSString* flowType;         //流程类型
@property(nonatomic,strong) NSString* flowTypeName;     //流程类型名称
@property(nonatomic,strong) NSString* flowName;         //流程标题
@property(nonatomic,strong) NSString* starterName;      //发起人
@property(nonatomic,strong) NSString* startOrgName;     //发起人部门
@property(nonatomic,strong) NSString* startTime;        //发起时间
@property(nonatomic,strong) NSString* flowStatus;       //流程状态
@property(nonatomic,strong) NSString* taskType;         //任务类型
@property(nonatomic,strong) NSString* nodeName;         //当前处理节点
@property(nonatomic,strong) NSString* assignName;       //当前处理人
@end

//流程待办详情数据
@interface HSDataWillDoDetailModel: HSDataModel
@property(nonatomic,strong) NSString* instanceId;       //流程编号
@property(nonatomic,strong) NSString* taskId;           //任务编号
@property(nonatomic,strong) NSString* flowName;         //流程标题
@property(nonatomic,strong) NSString* processName;      //流程名称
@property(nonatomic,strong) NSString* starterName;      //发起人
@property(nonatomic,strong) NSString* startTime;        //发起时间
@property(nonatomic,strong) NSString* nodeName;         //当前处理节点
@property(nonatomic,strong) NSString* flowInfo;         //详细表单信息
@end

//流程已办详情数据
@interface HSDataDidDoDetailModel: HSDataModel
@property(nonatomic,strong) NSString* instanceId;       //流程编号
@property(nonatomic,strong) NSString* flowName;         //流程标题
@property(nonatomic,strong) NSString* processName;      //流程名称
@property(nonatomic,strong) NSString* starterName;      //发起人
@property(nonatomic,strong) NSString* startTime;        //发起时间
@property(nonatomic,strong) NSString* nodeName;         //当前处理节点
@property(nonatomic,strong) NSString* flowInfo;         //详细表单信息
@end

//流程历史审批数据
@interface HSDataHistoryOpiModel: HSDataModel
@property(nonatomic,strong) NSString* nodeName;         //节点名称
@property(nonatomic,strong) NSString* approveUser;      //处理人
@property(nonatomic,strong) NSString* approveTime;      //处理时间
@property(nonatomic,strong) NSString* remark;           //处理意见
@end

//信息数据
@interface HSDataNewsModel: HSDataModel
@property(nonatomic,strong) NSString* messageid;        //消息编号
@property(nonatomic,strong) NSString* title;            //消息标题
@property(nonatomic,strong) NSString* sender;           //发送人
@property(nonatomic,strong) NSString* isread;           //是否已读
@property(nonatomic,strong) NSString* mark;             //标识
@property(nonatomic,strong) NSString* sendtime;         //发送时间
@end

//信息详情数据
@interface HSDataNewsDetailModel: HSDataModel
@property(nonatomic,strong) NSString* title;            //消息标题
@property(nonatomic,strong) NSString* sender;           //发送人
@property(nonatomic,strong) NSString* mark;             //标识
@property(nonatomic,strong) NSString* sendtime;         //发送时间
@property(nonatomic,strong) NSString* content;          //消息内容
@end

//项目数据
@interface HSDataProjectModel: HSDataModel
@property(nonatomic,strong) NSString* projectId;          //项目id
@property(nonatomic,strong) NSString* projectCode;        //项目编号
@property(nonatomic,strong) NSString* projectName;        //项目名称
@property(nonatomic,strong) NSString* projectType;        //项目类型
@property(nonatomic,strong) NSString* plannedFundingAmt;  //拟筹资额
@property(nonatomic,strong) NSString* projectOuterStatus; //项目状态
@property(nonatomic,strong) NSString* planName;           //计划简称
@property(nonatomic,strong) NSString* baseAssertType;     //基础资产类型
@end

//项目详情数据
@interface HSDataProjectDetailModel: HSDataModel
@property(nonatomic,strong) NSString* projectId;          //项目id
@property(nonatomic,strong) NSString* projectCode;        //项目编号
@property(nonatomic,strong) NSString* projectName;        //项目名称
@property(nonatomic,strong) NSString* projectType;        //项目类型
@property(nonatomic,strong) NSString* plannedFundingAmt;  //拟筹资额(亿)
@property(nonatomic,strong) NSString* projectOuterStatus; //项目状态
@property(nonatomic,strong) NSString* projectStage;       //项目阶段
@property(nonatomic,strong) NSString* issuer;             //发行人
@property(nonatomic,strong) NSString* listedCompanyName;  //申报企业
@property(nonatomic,strong) NSString* enterpriseType;     //公司类型
@property(nonatomic,strong) NSString* industry;           //行业类型
@property(nonatomic,strong) NSString* sponsor;            //保荐机构
@property(nonatomic,strong) NSString* planName;                 //ABS专有 专项计划全称
@property(nonatomic,strong) NSString* baseAssertType;           //ABS专有 基础资产类型
@property(nonatomic,strong) NSString* baseAssertDefinition;     //ABS专有 基础资产基本定义
@property(nonatomic,strong) NSString* baseAssertIndustry;       //ABS专有 基础资产涉及行业
@property(nonatomic,strong) NSString* priorityScale;            //ABS专有 优先级档总规模
@property(nonatomic,strong) NSString* afterPriorityScale;       //ABS专有 次优先级总规模
@property(nonatomic,strong) NSString* secondaryScale;           //ABS专有 次级档总规模
@end

//公示数据
@interface HSDataPublicInfoModel: HSDataModel
@property(nonatomic,strong) NSString* projectId;          //项目id
@property(nonatomic,strong) NSString* projectCode;        //项目编号
@property(nonatomic,strong) NSString* projectName;        //项目名称
@property(nonatomic,strong) NSString* projectType;        //项目类型
@property(nonatomic,strong) NSString* plannedFundingAmt;  //融资金额
@property(nonatomic,strong) NSString* issuer;             //发行人
@property(nonatomic,strong) NSString* listedCompanyName;  //上市公司
@property(nonatomic,strong) NSString* sponsor;            //主办机构
@property(nonatomic,strong) NSString* projectOuterStatus; //项目状态
@property(nonatomic,strong) NSString* lastestModifyDatetime; //更新日期
@end

//公示详情数据
@interface HSDataPublicInfoDetailModel: HSDataModel
@property(nonatomic,strong) NSString* projectId;          //项目id
@property(nonatomic,strong) NSString* projectCode;        //项目编号
@property(nonatomic,strong) NSString* projectName;        //项目名称
@property(nonatomic,strong) NSString* projectType;        //项目类型
@property(nonatomic,strong) NSString* plannedFundingAmt;  //融资金额
@property(nonatomic,strong) NSString* listedCompanyName;  //上市公司
@property(nonatomic,strong) NSString* sponsor;            //主办机构
@property(nonatomic,strong) NSString* projectOuterStatus; //项目状态
@property(nonatomic,strong) NSString* lastestModifyDatetime; //更新日期
@property(nonatomic,strong) NSString* industryName;       //所属行业
@property(nonatomic,strong) NSString* confirmFileNo;      //交易所确认文号
@end


