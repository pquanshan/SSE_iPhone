//
//  HSPublicInfoDetailViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/26.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSPublicInfoDetailViewController.h"
#import "HSDetailTableViewCell.h"
#import "HSLoadingView.h"
#import "HSDataModel.h"

@interface HSPublicInfoDetailViewController(){
    HSDetailTableViewCell *detailCell;
}

@end

@implementation HSPublicInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.navigationItem.title = @"公示详情";
    [self addCellHeight];
}

-(void)addCellHeight{
    detailCell = [[HSDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    [detailCell setIsTitleLong:YES];
//    [detailCell setIsLine:NO];
    [detailCell setCellWidth:self.view.frame.size.width];
    [self setTableViewCell:detailCell dic:nil];
    detailCell.frame = CGRectMake(0, -10, self.view.frame.size.width, [detailCell cellHeight]);
    [self.view addSubview:detailCell];
}

-(NSString*)requestStrUrl{
    return [[HSURLBusiness sharedURL] getPublicityDetailsUrl];
}

-(NSMutableArray*)requestArrData{
    NSMutableArray* muArr =[super requestArrData];
    [muArr removeAllObjects];
    if ([[HSModel sharedHSModel] appSystem] == HSAppSystemStock) {
        if (self.projectcode) {
            [muArr addObject:[@"projectcode=" stringByAppendingString:self.projectcode]];
        }
    }else if ([[HSModel sharedHSModel] appSystem] == HSAppSystemBond) {
        if (self.projectid) {
            [muArr addObject:[@"projectid=" stringByAppendingString:self.projectid]];
        }
    }

  
    return muArr;
}

-(void)updateUI{
    if (self.reDataArr && self.reDataArr.count == 1) {
        NSDictionary* dic = [self.reDataArr objectAtIndex:0];
        [self setTableViewCell:detailCell dic:dic];
        detailCell.frame = CGRectMake(0, -10, self.view.frame.size.width, [detailCell cellHeight]);
    }
}

-(void)requestSafe{
    NSString* strUrl = [self requestStrUrl];
    HSPHttpOperationManagers* operation = [[HSPHttpOperationManagers alloc] init];
    operation.delegate = self;
    if (strUrl == nil) {
        return;
    }
    NSMutableString* postStr = [[NSMutableString alloc] initWithString:strUrl];
    if ([[HSModel sharedHSModel] isReachable]) {
        [[HSLoadingView shareLoadingView] show];
        [operation addRequestByKey:[NSURL URLWithString:postStr] type:[self requestType] data:[self requestArrData]];
        [operation executionQueue];
    }else{
        [HSUtils showAlertMessage:@"提示" msg:@"网络连接异常" delegate:nil];
    }
}

-(void)setTableViewCell:(HSDetailTableViewCell*)cell dic:(NSDictionary*)dic{
    HSDataPublicInfoDetailModel* modelData = [[HSDataPublicInfoDetailModel alloc] init];
    [modelData setDataByDictionary:dic];
    
    NSString* projectName = modelData.projectName;
    if (modelData.projectName) {
//        [cell.imgView setImage:[[HSUtils sharedUtils] getImageNamed:@"label_01.png"]];
        [cell.titleLab setText:projectName];
//        [cell setImgStateLabel:modelData.projectOuterStatus labcolor:nil];
    }
    
    NSMutableArray* muArr = [[NSMutableArray alloc] init];
    if([[HSModel sharedHSModel] appSystem] == HSAppSystemStock){
        NSString* plannedFundingAmt = modelData.plannedFundingAmt;
        if (plannedFundingAmt) {
            [cell.detailsLab setText:@"拟筹资额"];
            cell.valueLab.textColor = KCorolTextRed;
            [cell.valueLab setText:[plannedFundingAmt stringByAppendingString:@"亿元"]];
        }
        
        if (modelData.projectOuterStatus) {
            [muArr addObject:@{@"keyStr":@"项目状态:",@"dataStr":modelData.projectOuterStatus}];
        }
        
        if (modelData.sponsor) {
            NSString* sponsor = [[HSDetailTableViewCell multiLineCode] stringByAppendingString:modelData.sponsor];
            [muArr addObject:@{@"keyStr":@"保荐机构:",@"dataStr":sponsor}];
        }
        
        if (modelData.listedCompanyName) {
            [muArr addObject:@{@"keyStr":@"申报企业:",@"dataStr":modelData.listedCompanyName}];
        }
        
        if (modelData.projectType) {
            [muArr addObject:@{@"keyStr":@"项目类型:",@"dataStr":modelData.projectType}];
        }
        
        if (modelData.industryName) {
            [muArr addObject:@{@"keyStr":@"所属行业:",@"dataStr":modelData.industryName}];
        }
        
        if (modelData.lastestModifyDatetime) {
            [muArr addObject:@{@"keyStr":@"更新日期:",@"dataStr":modelData.lastestModifyDatetime}];
        }
    }else if ([[HSModel sharedHSModel] appSystem] == HSAppSystemBond){
        
        NSString* plannedFundingAmt = modelData.plannedFundingAmt;
        if (plannedFundingAmt) {
            [cell.detailsLab setText:@"拟发行金额"];
            cell.valueLab.textColor = KCorolTextRed;
            [cell.valueLab setText:[plannedFundingAmt stringByAppendingString:@"万元"]];
        }
        
        if (modelData.listedCompanyName) {
            [muArr addObject:@{@"keyStr":@"发行人:",@"dataStr":modelData.listedCompanyName}];
        }
        
        if (modelData.projectOuterStatus) {
            [muArr addObject:@{@"keyStr":@"项目状态:",@"dataStr":modelData.projectOuterStatus}];
        }
        
        if (modelData.sponsor) {
            NSString* sponsor = [[HSDetailTableViewCell multiLineCode] stringByAppendingString:modelData.sponsor];
            [muArr addObject:@{@"keyStr":@"承销机构:",@"dataStr":sponsor}];
        }
        
//        if (modelData.projectType) {
//            [muArr addObject:@{@"keyStr":@"项目类型:",@"dataStr":modelData.projectType}];
//        }
        
        if (modelData.confirmFileNo) {
            [muArr addObject:@{@"keyStr":@"交易所确认文号:",@"dataStr":modelData.confirmFileNo}];
        }
        
        if (modelData.lastestModifyDatetime) {
            [muArr addObject:@{@"keyStr":@"更新日期:",@"dataStr":modelData.lastestModifyDatetime}];
        }
    }
 
    
    [cell setListArr:muArr];
}

@end
