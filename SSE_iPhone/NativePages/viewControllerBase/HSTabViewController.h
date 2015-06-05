//
//  HSTabViewController.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/9.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//


#define KDownLoadLimit              (20)
#define KDownLoadTotalCount         (99999)

#import "HSViewControllerBase.h"



@interface HSTabViewController : HSViewControllerBase<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UIView* topView;
@property(nonatomic, strong)UITableView *pullTableView;
@property(nonatomic, strong)UIView* bottomView;

@property(nonatomic, assign)BOOL isTopView;
@property(nonatomic, assign)BOOL isBottomView;

@property(nonatomic,assign)int totalCount;
@property(nonatomic,assign)BOOL isRereshing;//刷新

@property(nonatomic,assign)int page;//请求第几页,一页KDownLoadLimit个数

//数据重置
-(void)resetData;
//添加上中下三部分视图
-(void)addTopView;
-(void)addTabView;
-(void)addBottomView;

- (void)footerRereshing;

@end
