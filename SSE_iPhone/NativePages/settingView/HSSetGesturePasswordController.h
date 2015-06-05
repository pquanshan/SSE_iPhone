//
//  HSSetGesturePasswordController.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/10.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TentacleView.h"
#import "GesturePasswordView.h"

typedef enum {
    HSGPWSeting = 0,    //设置密码
    HSGPWReset,         //重置密码
    HSGPWProtection,    //保护密码
} HSGPWType;

@interface HSSetGesturePasswordController : UIViewController<VerificationDelegate,ResetDelegate,GesturePasswordDelegate>

@property(nonatomic, assign) HSGPWType gpwType;

@end
