//
//  HSProDetailViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/4/4.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSProDetailViewController.h"
#import "HSDataModel.h"

@interface HSProDetailViewController (){
    UILabel* titleLab;
    HSDataProjectDetailModel* modelData;
}

@end

@implementation HSProDetailViewController

-(id)init{
    self =[super init];
    if (self) {
        _isABS = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark Subclassing

-(NSString*)requestStrUrl{
    return [[HSURLBusiness sharedURL] getProjectDetailsUrl];
}

-(NSMutableArray*)requestArrData{
    NSMutableArray* muArr =[super requestArrData];
    [muArr removeAllObjects];
    if ([[HSModel sharedHSModel] appSystem] == HSAppSystemStock) {
        if (self.projectcode) {
            [muArr addObject:[@"projectcode=" stringByAppendingString:self.projectcode]];
        }
    }else if ([[HSModel sharedHSModel] appSystem] == HSAppSystemBond){
        if (self.projectid) {
            [muArr addObject:[@"projectid=" stringByAppendingString:self.projectid]];
        }
    }
    
    return muArr;
}

-(void)updateUI{
    if (self.reDataArr && self.reDataArr.count == 1) {
        modelData = modelData == nil ? [[HSDataProjectDetailModel alloc] init] : NO;
        [modelData setDataByDictionary:[self.reDataArr firstObject]];
    }
    
    if ([[HSModel sharedHSModel] appSystem] == HSAppSystemStock) {
        NSString* projectCode = modelData.projectCode ?  modelData.projectCode : @"";
        NSDictionary* dic1 = @{@"keyStr":@"项目编号:",@"dataStr":projectCode};
        
        NSString* projectStage = modelData.projectStage ?  modelData.projectStage : @"";
        NSDictionary* dic2 = @{@"keyStr":@"项目阶段:",@"dataStr":projectStage};
        NSString* listedCompanyName = modelData.listedCompanyName ?  modelData.listedCompanyName : @"";
        NSDictionary* dic3 = @{@"keyStr":@"申报企业:",@"dataStr":listedCompanyName,@"isComma":@"1"};
        NSString* enterpriseType = modelData.enterpriseType ?  modelData.enterpriseType : @"";
        NSDictionary* dic4 = @{@"keyStr":@"公司类型:",@"dataStr":enterpriseType,@"isComma":@"1"};
        NSString* industry = modelData.industry ?  modelData.industry : @"";
        NSDictionary* dic5 = @{@"keyStr":@"行业类型:",@"dataStr":industry,@"isComma":@"1"};
        NSString* sponsor = modelData.sponsor ?  modelData.sponsor : @"";
        NSDictionary* dic6 = @{@"keyStr":@"保荐机构:",@"dataStr":sponsor,@"isComma":@"1"};
        self.flowinfoArr = [[NSArray alloc] initWithObjects:dic1,dic2,dic3,dic4,dic5,dic6, nil];
    }else if ([[HSModel sharedHSModel] appSystem] == HSAppSystemBond){
        if (!_isABS) {
            NSString* projectCode = modelData.projectCode ?  modelData.projectCode : @"";
            NSDictionary* dic1 = @{@"keyStr":@"项目编号:",@"dataStr":projectCode};
            NSString* projectStage = modelData.projectStage ?  modelData.projectStage : @"";
            NSDictionary* dic2 = @{@"keyStr":@"项目阶段:",@"dataStr":projectStage};
            NSString* issuer = modelData.issuer ?  modelData.issuer : @"";
            NSDictionary* dic3 = @{@"keyStr":@"发行人:",@"dataStr":issuer,@"isComma":@"1"};
            NSString* sponsor = modelData.sponsor ?  modelData.sponsor : @"";
            NSDictionary* dic4 = @{@"keyStr":@"承销机构:",@"dataStr":sponsor,@"isComma":@"1"};
            self.flowinfoArr = [[NSArray alloc] initWithObjects:dic1,dic2,dic3,dic4, nil];
        }else{
            NSString* projectCode = modelData.projectCode ?  modelData.projectCode : @"";
            NSDictionary* dic1 = @{@"keyStr":@"项目编号:",@"dataStr":projectCode};
            NSString* projectStage = modelData.projectStage ?  modelData.projectStage : @"";
            NSDictionary* dic2 = @{@"keyStr":@"项目阶段:",@"dataStr":projectStage};
            NSString* issuer = modelData.issuer ?  modelData.issuer : @"";
            NSDictionary* dic3 = @{@"keyStr":@"发行人:",@"dataStr":issuer,@"isComma":@"1"};
            //            NSString* planName = modelData.planName ?  modelData.planName : @"";
            //            NSDictionary* dic4 = @{@"keyStr":@"专项计划全称:",@"dataStr":planName};
            NSString* baseAssertType = modelData.baseAssertType ?  modelData.baseAssertType : @"";
            NSDictionary* dic5 = @{@"keyStr":@"基础资产类型:",@"dataStr":baseAssertType,@"isComma":@"1"};
            NSString* baseAssertDefinition = modelData.baseAssertDefinition ?  modelData.baseAssertDefinition : @"";
            NSDictionary* dic6 = @{@"keyStr":@"基础资产基本定义:",@"dataStr":baseAssertDefinition};
            NSString* baseAssertIndustry = modelData.baseAssertIndustry ?  modelData.baseAssertIndustry : @"";
            NSDictionary* dic7 = @{@"keyStr":@"基础资产涉及行业:",@"dataStr":baseAssertIndustry,@"isComma":@"1"};
            NSString* priorityScale = modelData.priorityScale ?  modelData.priorityScale : @"";
            NSDictionary* dic8 = @{@"keyStr":@"优先级档总规模:",@"dataStr":priorityScale};
            NSString* afterPriorityScale = modelData.afterPriorityScale ?  modelData.afterPriorityScale : @"";
            NSDictionary* dic9 = @{@"keyStr":@"次优先级总规模:",@"dataStr":afterPriorityScale};
            NSString* secondaryScale = modelData.secondaryScale ?  modelData.secondaryScale : @"";
            NSDictionary* dic10 = @{@"keyStr":@"次级档总规模:",@"dataStr":secondaryScale};
            self.flowinfoArr = [[NSArray alloc] initWithObjects:dic1,dic2,dic3,dic5,dic6,dic7,dic8,dic9,dic10, nil];
        }
        
    }
    
    [super updateUI];
}

-(float)addBasicInfoView:(float)topHeight{
    float basicInfoHeight = 0;
    if (self.basicInfoView == nil) {
        self.basicInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, topHeight, self.view.frame.size.width, basicInfoHeight)];
        [self.basicInfoView setBackgroundColor:[HSColor getColorByColorNavigation]];
        UIImage* img = [[HSUtils sharedUtils] getImageNamed:@"banner02.png"];
        
        UIImageView* infoImgView = [[UIImageView alloc] initWithImage:img];
        infoImgView.center = CGPointMake(self.basicInfoView.frame.size.width/2,  img.size.height/2);
        [self.basicInfoView bringSubviewToFront:infoImgView];
        [self.basicInfoView addSubview:infoImgView];
        [self.view addSubview:self.basicInfoView];
    }
    basicInfoHeight =  [[HSUtils sharedUtils] getImageNamed:@"banner02.png"].size.height;
    
    
    NSString* projectName = modelData.projectName ? modelData.projectName : @"";
    CGRect rect = [projectName boundingRectWithSize:CGSizeMake((self.basicInfoView.frame.size.width - 2* KBoundaryOFF)*3/4, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]} context:nil];
    if (titleLab == nil) {
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF, basicInfoHeight - 38, (self.basicInfoView.frame.size.width - 2* KBoundaryOFF)*3/4, 38)];
        titleLab.font = [UIFont boldSystemFontOfSize:20];
        titleLab.lineBreakMode = 0;
        titleLab.numberOfLines = 0;
        titleLab.textColor = [UIColor whiteColor];
        [self.basicInfoView addSubview:titleLab];
    }
    titleLab.text = projectName;
    float labHeight = rect.size.height + KMiddleOFF > 38 ? rect.size.height + KMiddleOFF : 38;
    titleLab.frame = CGRectMake(KBoundaryOFF, basicInfoHeight - labHeight, self.basicInfoView.frame.size.width - 2* KBoundaryOFF, labHeight);
    
    basicInfoHeight += KMiddleOFF;
    
    self.basicInfoView.frame = CGRectMake(0, topHeight, self.view.frame.size.width, basicInfoHeight);
    
    return basicInfoHeight;
}

-(UIView*)getTableHeaderView{
    float off_y = 2*KMiddleOFF;
    UIView* headelView = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF, 0, self.view.frame.size.width - 2*KBoundaryOFF, 2*KMiddleOFF + 80)];
    UILabel * lab= [[UILabel alloc] initWithFrame:CGRectMake(0, off_y, headelView.frame.size.width, 30 )];
    
    NSString* projectOuterStatus = modelData.projectOuterStatus;
    if (projectOuterStatus) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[@"项目状态:" stringByAppendingString:projectOuterStatus]];
        [str addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} range:NSMakeRange(0,5)];
        [str addAttributes:@{NSForegroundColorAttributeName:KCorolTextRed,NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(5,str.length - 5)];
        lab.attributedText = str;
    }
    
    UILabel * lab2= [[UILabel alloc] initWithFrame:CGRectMake(0, off_y + 48, headelView.frame.size.width, 30 )];
    lab2.font = [UIFont systemFontOfSize:18];
    lab2.textColor = KCorolTextRed;
    NSString* plannedFundingAmt = modelData.plannedFundingAmt;
    
    UILabel * lab1= [[UILabel alloc] initWithFrame:CGRectMake(0, off_y + 28, headelView.frame.size.width, 25 )];
    lab1.font = [UIFont systemFontOfSize:13];
    if ([[HSModel sharedHSModel] appSystem] == HSAppSystemStock) {
        lab1.text = @"拟筹资额";
        lab2.text = [plannedFundingAmt stringByAppendingString:@"亿"];
    }else if ([[HSModel sharedHSModel] appSystem] == HSAppSystemBond){
        lab1.text = @"募集规模";
        if (_isABS) {
            lab2.text = [plannedFundingAmt stringByAppendingString:@"亿"];
        }else{
            lab2.text = [plannedFundingAmt stringByAppendingString:@"万"];
        }
    }
    
    CGRect rect = [plannedFundingAmt boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:lab2.font} context:nil];
    CGRect lineRect= CGRectMake(rect.size.width + 20, off_y + 48 + 15, headelView.bounds.size.width - rect.size.width - 20, 1);
    [HSUtils drawLine:headelView type:HSRealizationLine rect:lineRect color:KCorolTextLLGray];
    
    [headelView addSubview:lab];
    [headelView addSubview:lab1];
    [headelView addSubview:lab2];
    return headelView;
}

@end
