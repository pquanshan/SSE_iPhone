//
//  GesturePasswordController.h
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "TentacleView.h"
#import "GesturePasswordView.h"

@protocol GesturePasswordControllerDelegate <NSObject>
//- (void)gesturePasswordlogin;
@end

@interface GesturePasswordController : UIViewController <VerificationDelegate,ResetDelegate,GesturePasswordDelegate>

@property(nonatomic, weak) id <GesturePasswordControllerDelegate> delegate;

@property(nonatomic, assign) BOOL isLogin;//默认为YES，用来登录。置为NO时，用来屏保验证。

- (void)clear;
- (BOOL)exist;

@end
