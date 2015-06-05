//
//  HSSetGesturePasswordController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/10.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSSetGesturePasswordController.h"
#import <Security/Security.h>
#import <CoreFoundation/CoreFoundation.h>
#import "KeychainItemWrapper.h"
#import "HSUtils.h"
#import "HSModel.h"
#import "HSRootViewController.h"


@interface HSSetGesturePasswordController (){
    NSString * previousString;
    NSString * password;
    UILabel* textLab;
}

@property (nonatomic,strong) GesturePasswordView * gesturePasswordView;

@end


@implementation HSSetGesturePasswordController
@synthesize gesturePasswordView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _gpwType = HSGPWSeting;//设置密码。
    
    previousString = [NSString string];
    KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
    password = [keychin objectForKey:(__bridge id)kSecValueData];
    
    NSString* gesturePassword  = [[NSUserDefaults standardUserDefaults] objectForKey:KGesturePassword];
    if (gesturePassword && [gesturePassword isEqualToString:[HSModel sharedHSModel].userName] && password.length > 0) {
        self.navigationItem.title = @"修改手势密码";
        [self verify];
    }else{
        self.navigationItem.title = @"设置手势密码";
        [self reset];
    }

    [self addTextLab];
}

#pragma mark - 验证手势密码
- (void)verify{
    if (gesturePasswordView == nil) {
         gesturePasswordView = [[GesturePasswordView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:gesturePasswordView];
        CGPoint point = gesturePasswordView.center;
        gesturePasswordView.center = CGPointMake(point.x, point.y - KNavigationAddstatusHeight);
    }
    [gesturePasswordView.tentacleView setRerificationDelegate:self];
    [gesturePasswordView.tentacleView setStyle:1];
    [gesturePasswordView setGesturePasswordDelegate:self];
    [gesturePasswordView.imgView setHidden:YES];
    [gesturePasswordView.forgetButton setHidden:YES];
    [gesturePasswordView.changeButton setHidden:NO];
    [gesturePasswordView.changeButton setTitle:@"重置手势密码" forState:UIControlStateNormal];
}

#pragma mark - 重置手势密码
- (void)reset{
    if (gesturePasswordView == nil) {
        gesturePasswordView = [[GesturePasswordView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:gesturePasswordView];
        CGPoint point = gesturePasswordView.center;
        gesturePasswordView.center = CGPointMake(point.x, point.y - KNavigationAddstatusHeight);
    }
    [gesturePasswordView.tentacleView setResetDelegate:self];
    [gesturePasswordView.tentacleView setStyle:2];
    [gesturePasswordView.imgView setHidden:YES];
    [gesturePasswordView.forgetButton setHidden:YES];
    [gesturePasswordView.changeButton setHidden:YES];
//    [gesturePasswordView.changeButton setTitle:@"重置手势密码" forState:UIControlStateNormal];
    
}

-(void)addTextLab{
    textLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 150 -KNavigationAddstatusHeight, self.view.frame.size.width, 35)];
    textLab.textAlignment = NSTextAlignmentCenter;
    textLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textLab];
    [self.view bringSubviewToFront:textLab];
    
    NSString* gesturePassword  = [[NSUserDefaults standardUserDefaults] objectForKey:KGesturePassword];
    if (gesturePassword && [gesturePassword isEqualToString:[HSModel sharedHSModel].userName] && password.length > 0){
        textLab.textColor = [UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1];
        textLab.text = @"请输入你的原始密码";
    }else{
        textLab.textColor = [UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1];
        textLab.text = @"请设置你的密码";
    }
}

- (void)change{
    [gesturePasswordView.state setText:@""];
    [gesturePasswordView.tentacleView enterArgin];
    textLab.text = @"请设置你的密码";
    [self reset];
}

- (void)forget{
    
}

- (BOOL)verification:(NSString *)result{
    if (result && [result isEqualToString:password]) {
        textLab.textColor = [UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1];
        textLab.text = @"请输入新密码";
        [self performSelector:@selector(enterArgin) withObject:nil afterDelay:0.3];
        [self reset];
        return YES;
    }else if (result && [result isEqualToString:@""]){
    }else{
        textLab.textColor = [UIColor redColor];
        textLab.text = @"密码错误";
        [self performSelector:@selector(enterArgin) withObject:nil afterDelay:0.3];
    }
    
    return NO;
}

-(void)enterArgin{
    [gesturePasswordView.tentacleView enterArgin];
}

- (BOOL)resetPassword:(NSString *)result{
    if ([previousString isEqualToString:@""]) {
        previousString = result;
        [self performSelector:@selector(enterArgin) withObject:nil afterDelay:0.3];
        textLab.textColor = [UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1];
        textLab.text = @"再次输入新密码";
        return YES;
    } else {
        if ([result isEqualToString:previousString]) {
            KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
            [keychin setObject:@"<帐号>" forKey:(__bridge id)kSecAttrAccount];
            [keychin setObject:result forKey:(__bridge id)kSecValueData];
            textLab.textColor = [UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1];
            textLab.text = @"已保存手势密码";
            [self performSelector:@selector(enterArgin) withObject:nil afterDelay:0.3];
            [[NSUserDefaults standardUserDefaults] setObject:[[HSModel sharedHSModel] userName] forKey:KGesturePassword];
            [self.navigationController popViewControllerAnimated:YES];
            return YES;
        }else{
            previousString = @"";
            textLab.textColor = [UIColor redColor];
            textLab.text = @"两次密码不一致，请重新输入";
            [self performSelector:@selector(enterArgin) withObject:nil afterDelay:0.3];
            return NO;
        }
    }
}

#pragma mark - 清空记录
- (void)clear{
    KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
    [keychin resetKeychainItem];
}


@end
