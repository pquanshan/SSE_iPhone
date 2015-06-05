//
//  HSTodoDetailViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/2/26.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSTodoDetailViewController.h"


@interface HSTodoDetailViewController()

@end

@implementation HSTodoDetailViewController
@synthesize basicInfoView,tabview;

#pragma mark Subclassing
-(NSString*)requestStrUrl{
    return [[HSURLBusiness sharedURL] getProcWillDoDetailInfoUrl];
}

-(NSMutableArray*)requestArrData{
    NSMutableArray* muArr =[super requestArrData];
    [muArr removeAllObjects];
    if (self.taskid) {
        [muArr addObject:[@"taskid=" stringByAppendingString:self.taskid]];
    }
    return muArr;
}

-(UIView*)getTableHeaderView{
    UIView* headelView = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF, 0, self.view.frame.size.width - 2*KBoundaryOFF, KTabViewRowHeight)];
    UILabel * lab= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headelView.frame.size.width, headelView.frame.size.height - 1 )];
    HSDataWillDoDetailModel* modelData = [[HSDataWillDoDetailModel alloc] init];
    if (self.reDataArr && self.reDataArr.count == 1) {
        [modelData setDataByDictionary:[self.reDataArr firstObject]];
    }

    NSString* nodeName = modelData.nodeName;
    if (nodeName) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[@"当前节点:" stringByAppendingString:nodeName]];
        [str addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} range:NSMakeRange(0,5)];
        [str addAttributes:@{NSForegroundColorAttributeName:KCorolTextRed,NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(5,str.length - 5)];
        lab.attributedText = str;
    }

    if (self.flowinfoArr && self.flowinfoArr.count > 0) {
        CGRect lineRect= CGRectMake(KBoundaryOFF, headelView.frame.size.height - 1, headelView.bounds.size.width, 1);
        [HSUtils drawLine:headelView type:HSRealizationLine rect:lineRect color:KCorolTextLLGray];
    }
    
    [headelView addSubview:lab];
    return headelView;
}

-(void)setTableViewCell:(HSDetailTableViewCell*)cell{
    HSDataWillDoDetailModel* modelData = [[HSDataWillDoDetailModel alloc] init];
    if (self.reDataArr && self.reDataArr.count == 1) {
        [modelData setDataByDictionary:[self.reDataArr firstObject]];
    }

    [cell.titleLab setText:modelData.flowName];
    cell.titleLab.font = [UIFont boldSystemFontOfSize:17];
    cell.titleLab.textColor = [UIColor whiteColor];
    [cell.detailsLab setText:modelData.starterName?[@"发起人:" stringByAppendingString:modelData.starterName]:@""];
    cell.detailsLab.font = [UIFont boldSystemFontOfSize:14];
    cell.detailsLab.textColor = [UIColor whiteColor];
    [cell.valueLab setText:modelData.startTime?[@"发起时间:" stringByAppendingString:modelData.startTime]:@""];
    cell.valueLab.font = [UIFont systemFontOfSize:14];
    cell.valueLab.textColor = [UIColor whiteColor];
    [cell setCurrentNodeStr:nil];

}

@end
