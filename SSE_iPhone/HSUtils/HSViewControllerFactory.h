//
//  HSViewControllerFactory.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/11.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    HSMPageViewControllerVC = 0,        //系统VC
    HSMPageLoginVC,                     //登录视图
    HSMPageGesturePasswordVC,           //手势密码登录视图
    HSMPageRootVC,                      //根视图
    HSMPageMainTabBarVC,                //主页面
    HSMPageLeftMenuVC,                  //左边菜单视图
    HSMPageToDoVC,                      //待办页面
    
    HSMPageTodoListVC,                  //待办列表页面
    HSMPageTodoDetailVC,                //待办详情页面
    HSMPageHistoryVC,                   //审批历史页面
    
    HSMPageDoneListVC,                  //已办页面
    HSMPageDoneDetailVC,                //已办详情页面
//    HSMPageDoneReadVC,                //已阅页面

    HSMPageBondSystemtVC,               //债券系统
    HSMPageStockSystemVC,               //股票系统
    HSMPagePublicInfoVC,                //公示信息
    HSMPagePublicInfoDetailVC,          //公示详情
    HSMPageSearchVC,                    //搜索页面
    
    HSMPageProductsVC,                  //产品页面
    HSMPageProDetailVC,                 //产品详情页面

    HSMPageMessageVC,                   //消息页面
    HSMPageMsgDetailVC,                 //消息详情
    HSMPageSettingVC,                   //设置页面
    HSMPageSetGesturePasswordVC,        //重置密码页面
    HSMPageAboutVC,                     //关于页面
    
} HSPageVCType;

@interface HSViewControllerFactory : NSObject
@property(nonatomic,weak) UIViewController* rootViewController;

+(HSViewControllerFactory *)sharedFactory;


-(UIViewController*)getViewController:(HSPageVCType)pageVCType isReload:(BOOL)isReload;
-(BOOL)isViewController:(HSPageVCType)pageVCType;
-(void)deletetCacheViewController:(HSPageVCType)pageVCType;

-(void)gotoGesturePasswordController;
-(void)gotoLoginController;

@end
