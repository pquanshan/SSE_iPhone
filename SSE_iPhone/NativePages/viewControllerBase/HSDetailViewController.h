//
//  HSDetailViewController.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/12.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSViewControllerBase.h"
#import "HSDataModel.h"
#import "HSProcessTableViewCell.h"
#import "HSDetailTableViewCell.h"

#define KLabelHeight        (35)
#define KLabelSHeight       (28)

#define KIconImgHeight      (30)
#define KIconImgSHeight     (24)

#define KBasicInfoTopHeight (96 - 64)
#define KTabViewRowHeight   (60)

#define KAnnexBtnTag(a)     ((1000) + (a))
#define KAnnexBtnSub(a)     ((a) - (1000))


@interface HSDetailViewController : HSViewControllerBase

@property(nonatomic, strong)UIView* basicInfoView;
@property(nonatomic, strong)UITableView* tabview;

@property(nonatomic, strong)NSArray* flowinfoArr;//业务数据

//用来请求数据
@property(nonatomic, strong)NSString* instanceid;
@property(nonatomic, strong)NSString* flowtype;
@property(nonatomic, strong)NSString* taskid;

//可以子类实现
-(float)addBasicInfoView:(float)topHeight;

-(UIView*)getTableHeaderView;



-(void)setTableViewCell:(HSDetailTableViewCell*)cell;

@end
