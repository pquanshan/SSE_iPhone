//
//  HSLoadingView.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/6.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSLoadingView : UIView{
    //指示器
    UIActivityIndicatorView *indicatorView;
    //包含指示器和文字的view
    UIView *conerView;
}
//获取LoadingView单例,isLikeSynchro  Yes:类似同步，通过遮盖整个窗体实现 No:异步
+ (HSLoadingView *)shareLoadingView;

//是否是模拟同步
@property (nonatomic) BOOL isLikeSynchro;
//显示加载框
- (void)show;
//关闭加载框
- (void)close;


@end
