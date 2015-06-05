//
//  HSViewControllerBase.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/1.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSViewControllerFactory.h"
#import "HSPHttpOperationManagers.h"
#import "HSConfig.h"
#import "HSUtils.h"
#import "HSModel.h"

@interface HSViewControllerBase : UIViewController<HSPHttpRequestDelegate>

@property(nonatomic, strong)HSPHttpOperationManagers* operation;

@property(nonatomic, strong)NSMutableArray* reDataArr;
@property(nonatomic, strong)NSString* navTitle;
@property(nonatomic, strong)NSMutableArray* requestArr;

@property(nonatomic, assign)BOOL isAddData;
@property(nonatomic, assign)BOOL isUseNoDataView;
@property(nonatomic, strong)UIView* noDataView;


//请求
-(void)request;
//安全的请求
-(void)requestSafe;
//请求类型，默认get,若想postbi必须子类重载
-(HSHttpRequestType)requestType;
//页面出现后自动请求数据
-(BOOL)isAutomaticRequest;


//需要额外增加请求参数时，重载
-(NSMutableArray*)requestArrData;

//以下三个方法必须子类继承实现
-(NSString*)requestStrUrl;

//返回的事数组时
-(BOOL)refreshData;
-(void)updateUI;

//返回的是字典时
-(void)returnDictionary:(NSDictionary*)redic;

//返回的是字符串时
-(void)returnString:(NSString*)restr;


//统一的无数句控制
-(void)addNoDataView;
-(void)setNoDataViewRectY:(CGFloat)off_y;
-(void)noDataViewHide;
-(void)noDataViewShow;

@end
