//
//  GesturePasswordController.m
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

#import <Security/Security.h>
#import <CoreFoundation/CoreFoundation.h>
#import "GesturePasswordController.h"
#import "KeychainItemWrapper.h"
#import "HSModel.h"
#import "HSUtils.h"

#define KErrorUpperLimit        (5)

static int errorCount = KErrorUpperLimit;

@interface GesturePasswordController ()

@property (nonatomic,strong) GesturePasswordView * gesturePasswordView;

@end

@implementation GesturePasswordController {
    NSString * previousString;
    NSString * password;
}

@synthesize gesturePasswordView;

- (id)init
{
    self = [super init];
    if (self) {
       _isLogin = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    previousString = [NSString string];
    KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
    password = [keychin objectForKey:(__bridge id)kSecValueData];
    if ([password isEqualToString:@""]) {
        [self reset];
    } else {
        [self verify];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    if (!_isLogin) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
}

#pragma mark - 验证手势密码
- (void)verify{
    if (gesturePasswordView == nil) {
        gesturePasswordView = [[GesturePasswordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:gesturePasswordView];
    }
    [gesturePasswordView.tentacleView setRerificationDelegate:self];
    [gesturePasswordView.tentacleView setStyle:1];
    [gesturePasswordView setGesturePasswordDelegate:self];
    [gesturePasswordView.forgetButton setHidden:NO];
    [gesturePasswordView.changeButton setHidden:NO];
    
    gesturePasswordView.imgView.image = [UIImage imageNamed:@"headPortrait.png"];
    gesturePasswordView.imgView.clipsToBounds = YES;
    gesturePasswordView.imgView.layer.cornerRadius = 35;
}

#pragma mark - 重置手势密码
- (void)reset{
    if (gesturePasswordView == nil) {
        gesturePasswordView = [[GesturePasswordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:gesturePasswordView];
    }
    [gesturePasswordView.tentacleView setResetDelegate:self];
    [gesturePasswordView.tentacleView setStyle:2];
    [gesturePasswordView.forgetButton setHidden:YES];
    [gesturePasswordView.changeButton setHidden:YES];
    
}

#pragma mark - 判断是否已存在手势密码
- (BOOL)exist{
    KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
    password = [keychin objectForKey:(__bridge id)kSecValueData];
    if ([password isEqualToString:@""])return NO;
    return YES;
}

#pragma mark - 清空记录
- (void)clear{
    KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
    [keychin resetKeychainItem];
}

#pragma mark - 改变手势密码
- (void)change{
    if ([[HSModel sharedHSModel] isLogin] && _isLogin) {
        [gesturePasswordView.state setText:@""];
        [gesturePasswordView.tentacleView enterArgin];
        [self reset];
    }else if([[HSModel sharedHSModel] isLogin] && !_isLogin){
        [HSUtils showAlertMessage:@"提示" msg:@"屏幕保护状态下,无法修改手势密码。\n请输入正确的手势密码进入应用，或者通过账号名和密码登录" delegate:nil];
    }else{
        [HSUtils showAlertMessage:@"提示" msg:@"未登录，无法修改手势密码，请先登录应用" delegate:nil];
    }
}

#pragma mark - 忘记手势密码
- (void)forget{
    [self.navigationController popViewControllerAnimated:YES];
    [[HSModel sharedHSModel] logout];
}

- (BOOL)verification:(NSString *)result{
    if (result && [result isEqualToString:password]) {
        [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
        [gesturePasswordView.state setText:@"输入正确"];
        errorCount = KErrorUpperLimit;
        if (_isLogin) {
            gesturePasswordView.imgView.image = [UIImage imageNamed:@"headPortrait.png"];
            gesturePasswordView.imgView.clipsToBounds = YES;
            gesturePasswordView.imgView.layer.cornerRadius = 35;
        }else{
            [self.navigationController popViewControllerAnimated:YES];
            BOOL activationGP = [[[NSUserDefaults standardUserDefaults] objectForKey:KActivationGesturePassword] boolValue];
            if (activationGP && ![[HSModel sharedHSModel] isLogin]) {
                [[HSModel sharedHSModel] login];
            }
        }
        return YES;
    }else if (result && [result isEqualToString:@""]){
    }else{
        [gesturePasswordView.state setTextColor:[UIColor redColor]];
        if (--errorCount < 1) {
            //账号锁定
            errorCount = KErrorUpperLimit;
            [[HSModel sharedHSModel] logout];
            [gesturePasswordView.state setText:@"已登出"];
            [self performSelector:@selector(enterArgin) withObject:nil afterDelay:0.3];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self performSelector:@selector(enterArgin) withObject:nil afterDelay:0.3];
            [gesturePasswordView.state setText:[[NSString alloc] initWithFormat:@"手势密码错误,还有%d次您的账号将登出",errorCount]];
        };
    }

    return NO;
}

- (BOOL)resetPassword:(NSString *)result{
    if ([previousString isEqualToString:@""]) {
        previousString = result;
        [self performSelector:@selector(enterArgin) withObject:nil afterDelay:0.3];
        [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
        [gesturePasswordView.state setText:@"请验证输入密码"];
        return YES;
    } else {
        if ([result isEqualToString:previousString]) {
            KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
            [keychin setObject:@"<帐号>" forKey:(__bridge id)kSecAttrAccount];
            [keychin setObject:result forKey:(__bridge id)kSecValueData];
            [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
            [gesturePasswordView.state setText:@"已保存手势密码，再次输入进入应用"];
            [self performSelector:@selector(enterArgin) withObject:nil afterDelay:0.3];
            [[NSUserDefaults standardUserDefaults] setObject:[[HSModel sharedHSModel] userName] forKey:KGesturePassword];
            [self verify];
            return YES;
        }else{
            previousString = @"";
            [gesturePasswordView.state setTextColor:[UIColor redColor]];
            [gesturePasswordView.state setText:@"两次密码不一致，请重新输入"];
            [self performSelector:@selector(enterArgin) withObject:nil afterDelay:0.3];
            return NO;
        }
    }
}

-(void)enterArgin{
    [gesturePasswordView.tentacleView enterArgin];
}

@end
