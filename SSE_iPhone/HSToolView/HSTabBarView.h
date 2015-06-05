//
//  HSTabBarView.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/16.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HSTabBarViewDelegate <NSObject>
@optional
-(void)tabBarViewselcetButton:(int)index;

@end

@interface HSTabBarView : UIView

@property(nonatomic, strong) NSMutableArray* btnArr;

@property(assign, nonatomic) float tabBarWidth;
@property(assign, nonatomic, readonly) float tabBarHeight;
@property(assign, nonatomic) int selectIndex;

@property(weak, nonatomic) id<HSTabBarViewDelegate> delegate;


-(void)setTabBarButton:(UIButton*)button index:(int)index;
-(void)addTabBarButton:(UIButton*)button;


@end
