//
//  HSRootViewController.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/2/26.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "HSConfig.h"
#import "HSLeftMenuViewController.h"
#import "HSToDoViewController.h"
#import "HSMainTabBarViewController.h"

@interface HSRootViewController : UIViewController<HSLeftMenuViewControllerDelegate>{
@private
    UIViewController * leftControl;
    UIViewController * mainControl;
    UIViewController * righControl;
    CGFloat scalef;
}

//滑动速度系数-建议在0.5-1之间。默认为0.5
@property (assign,nonatomic) CGFloat speedf;
//是否允许点击视图恢复视图位置。默认为yes
@property (strong,nonatomic) UITapGestureRecognizer *sideslipTapGes;
//是否允许右边滑动
@property (assign,nonatomic) BOOL isRightPan;

//初始化
-(instancetype)initWithLeftView:(UIViewController *)LeftView
                    andMainView:(UIViewController *)MainView
                   andRightView:(UIViewController *)RighView;

//恢复位置
-(void)showMainView;
//显示左视图
-(void)showLeftView;
//显示右视图
-(void)showRighView;

//主页面当前显示具体VC
-(void)leftMenuViewControllerTransformEvent:(HSPageVCType)pageVCType isShowMain:(BOOL)isShowMain;


@end
