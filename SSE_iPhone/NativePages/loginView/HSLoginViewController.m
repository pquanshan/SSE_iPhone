//
//  HSLoginViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/2/28.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSLoginViewController.h"
#import "HSRootViewController.h"
#import "HSUtils.h"
#import "HSLoadingView.h"

#define KTimerCount     (90)

@interface HSLoginViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    UITableView* tabview;
    NSArray* menuArr;
    float tabOff_y;
    
    UIView* mobileCheckView;
    NSMutableArray* textFieldArr;
    
    NSTimer* timer;
    int timerCount;
    int times;//验证次数
    
    UIButton* verBtn;
    UILabel* mobileLab;
    
    NSString* userName;
}

@end

@implementation HSLoginViewController

-(id)init{
    self =[super init];
    if (self) {
        timerCount = KTimerCount;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([[HSModel sharedHSModel] getMainSystemVC] == HSMPageStockSystemVC) {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        [view setBackgroundColor:[HSColor getColorByColorNavigation]];
        [self.view addSubview:view];
    }else {
        UIImageView* imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imgView.image = [[HSUtils sharedUtils] getImageNamed:@"login_bg.png"];
        [self.view addSubview:imgView];
    }
    
    menuArr= @[@[@"用户名",@"密码"],@[@"登录"]];
    
    [self addLogoAndName];
    [self addTabview];
    
    userNamefield = [[UITextField alloc] init];
    userNamefield.delegate = self;
    passwordfield = [[UITextField alloc] init];
    passwordfield.delegate = self;
    passwordfield.secureTextEntry = YES;
    userNamefield.text = [[NSUserDefaults standardUserDefaults] objectForKey:KAccountId];
    
    mobileCheckView = [[UIView alloc] initWithFrame:self.view.bounds];
    [mobileCheckView setBackgroundColor:[HSColor getColorByColorPageLightWhite]];
    mobileCheckView.hidden = YES;
    [self setMobileCheckView];
    [self.view addSubview:mobileCheckView];
    
    //最外层
    UIImage* closeImg = [[HSUtils sharedUtils] getImageNamed:@"icon_close.png"];
    UIButton* closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - KBoundaryOFF - closeImg.size.width, 30, closeImg.size.width, closeImg.size.height)];
    [closeBtn addTarget:self action:@selector(closeBtnclick:) forControlEvents:UIControlEventTouchDown];
    [closeBtn setImage:closeImg forState:UIControlStateNormal];
    [self.view bringSubviewToFront:closeBtn];
    [self.view addSubview:closeBtn];
    
    timer =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFunction:) userInfo:nil repeats:YES];
    [timer setFireDate:[NSDate distantFuture]];

}

-(void)setMobileCheckView{
    float off_h = 0;
    UIView* navView = [[UIView alloc] initWithFrame:CGRectMake(0, off_h, self.view.frame.size.width, KNavigationAddstatusHeight)];
    [navView setBackgroundColor:[HSColor getColorByColorNavigation]];
    UILabel* lab0 =  [[UILabel alloc] initWithFrame:CGRectMake(0, 20, navView.frame.size.width, KNavigationAddstatusHeight - 20)];
    lab0.text = @"手机验证";
    lab0.font = [UIFont boldSystemFontOfSize:18];
    lab0.textColor = [UIColor whiteColor];
    lab0.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:lab0];
    [mobileCheckView addSubview:navView];
    off_h += KNavigationAddstatusHeight + 20;
 
    UILabel* lab1 = [[UILabel alloc] initWithFrame:CGRectMake(20, off_h, 130, 30)];
    lab1.text = @"验证码已发送到手机：";
    lab1.textColor = [UIColor grayColor];
    lab1.font = [UIFont systemFontOfSize:13];
    [mobileCheckView addSubview:lab1];
    
    mobileLab = [[UILabel alloc] initWithFrame:CGRectMake(150, off_h, self.view.frame.size.width-170, 30)];
    mobileLab.text = @"";
    mobileLab.font = [UIFont systemFontOfSize:15];
    [mobileCheckView addSubview:mobileLab];
    off_h += (30 + 10);
    
    int count = 6;
    float textFieldW = (self.view.frame.size.width - 40)/count;
    UIView* textFieldBackView = [[UIView alloc] initWithFrame:CGRectMake(20, off_h, self.view.frame.size.width - 40, 40)];
    [textFieldBackView setBackgroundColor:[UIColor whiteColor]];
    [mobileCheckView addSubview:textFieldBackView];
    textFieldArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; ++i) {
        UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(i*textFieldW, 0, textFieldW - 1, 40)];
        //设置风格
        textField.tag = 1000 + 1;
        textField.delegate = self;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [textFieldArr addObject:textField];
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [textFieldBackView addSubview:textField];
        if (i != count - 1) {
            CGRect rect = CGRectMake((i+1)*textFieldW, 6, 1, 40 - 12);
            [HSUtils drawLine:textFieldBackView type:HSRealizationLine rect:rect color:KCorolTextLLGray];
        }
    }
    off_h += (40 + 25);
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(20, off_h, self.view.frame.size.width - 40, 38)];
    [btn setBackgroundColor:[HSColor getColorByColorNavigation]];
    [btn setTitle:@"验证" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(checkClicked:) forControlEvents:UIControlEventTouchDown];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mobileCheckView addSubview:btn];
    off_h += (38 + 10);
    
    //设为两分钟
    verBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, off_h, 130, 38)];
    [verBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
    verBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [verBtn addTarget:self action:@selector(getVerificationCode:) forControlEvents:UIControlEventTouchDown];
    [verBtn setTitleColor:KCorolTextBlue forState:UIControlStateNormal];
    [mobileCheckView addSubview:verBtn];
}

-(void)addLogoAndName{
    UIImage* logoImg = [[HSUtils sharedUtils] getImageNamed:@"logo.png"];
    UIImageView* logoView = [[UIImageView alloc] initWithImage:logoImg];
    logoView.center = CGPointMake(self.view.frame.size.width/2, 64 + logoImg.size.height/2);
    [self.view addSubview:logoView];
    
    UIImage* logoNameImg = [[HSUtils sharedUtils] getImageNamed:@"logo_name.png"];
    UIImageView* logoNameView = [[UIImageView alloc] initWithImage:logoNameImg];
    logoNameView.center = CGPointMake(self.view.frame.size.width/2, 64 + 24 + logoImg.size.height + logoNameImg.size.height/2);
    [self.view addSubview:logoNameView];
    
    tabOff_y = 64 + 24 + logoImg.size.height + logoNameImg.size.height;
}

-(void)addTabview{
    float off_x = 0;
    if ([[HSModel sharedHSModel] getMainSystemVC] == HSMPageStockSystemVC) {
        off_x = 20;
    }
    tabview = [[UITableView alloc] initWithFrame:CGRectMake(off_x, tabOff_y, self.view.frame.size.width - 2*off_x, self.view.frame.size.height - tabOff_y) style:UITableViewStyleGrouped];
    [tabview setBackgroundColor:[UIColor clearColor]];
    tabview.delegate = self;
    tabview.dataSource = self;
    off_x > 0 ? tabview.separatorStyle = UITableViewCellSeparatorStyleNone : NO;
    [self.view addSubview:tabview];
}

#pragma mark UITableView
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellString = @"Cell";
    UITableViewCell *cell =(UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellString];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([[HSModel sharedHSModel] getMainSystemVC] == HSMPageStockSystemVC) {
             [cell setBackgroundColor:[UIColor whiteColor]];
        }else{
            [cell setBackgroundColor:KCorolTextBackViewAlpha];
        }
    }
    NSArray* sunArr = [menuArr objectAtIndex:indexPath.section];
    if(indexPath.section == 0) {
        UIImageView* imgView = (UIImageView*)[cell.contentView viewWithTag:1000];
        if (imgView == nil) {
            imgView = [[UIImageView alloc] initWithFrame:CGRectMake(16, (54 - 24)/2, 24, 24)];
            imgView.tag = 1000;
            [cell.contentView addSubview:imgView];
        }
        
        UILabel* label = (UILabel*)[cell.contentView viewWithTag:1001];
        if (label == nil) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(16 + 24+ 8, 0, 60, 54)];
            label.tag = 1001;
            [cell.contentView addSubview:label];
            if (![[HSModel sharedHSModel] getMainSystemVC] == HSMPageStockSystemVC) {
                cell.textLabel.textColor = KCorolTextBlue;;
            }
            label.font = [UIFont systemFontOfSize:16];
        }
        label.text = [sunArr objectAtIndex:indexPath.row];
        
        float off_x = 16 + 24+ 16 + 60;
        if (indexPath.row == 0) {
            imgView.image = [[HSUtils sharedUtils] getImageNamed:@"icon_loginuser.png"];
            userNamefield.frame =CGRectMake(off_x, 0, cell.contentView.frame.size.width - off_x - 16, 54);
            [cell.contentView addSubview:userNamefield];
            if ([[HSModel sharedHSModel] getMainSystemVC] == HSMPageStockSystemVC) {
                CGRect rect = CGRectMake( 0, 53, tabview.frame.size.width, 1);
                [HSUtils drawLine:cell.contentView type:HSRealizationLine rect:rect color:KCorolTextLLGray];
            }
        }else if (indexPath.row == 1){
            passwordfield.frame =CGRectMake(off_x, 0, cell.contentView.frame.size.width - off_x - 16, 54);
            [cell.contentView addSubview:passwordfield];
            imgView.image = [[HSUtils sharedUtils] getImageNamed:@"icon_password.png"];
        }
        
    }else if(indexPath.section == 1){
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        [cell setBackgroundColor:[HSColor getColorByColorNavigation]];
        if (![[HSModel sharedHSModel] getMainSystemVC] == HSMPageStockSystemVC) {
            cell.textLabel.textColor = KCorolTextBlue;
        }else{
            cell.textLabel.textColor = [UIColor whiteColor];
        }
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
        [cell.textLabel setText:@"登录"];
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 54;
    }else if (indexPath.section == 1){
        return 44;
    }
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[menuArr objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return menuArr.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0) {
        if (indexPath.row == 0) {

        }else{

        }
    }else if(indexPath.section == 1){
        [userNamefield resignFirstResponder];
        [passwordfield resignFirstResponder];
        [self login];
    }
}

#pragma mark Subclassing
-(HSHttpRequestType)requestType{
    return HSRequestTypeGET;
}

-(BOOL)isAutomaticRequest{
    return NO;
}

-(NSString*)requestStrUrl{
    return [[HSURLBusiness sharedURL] getLoginUrl];
}

-(void)updateUI{
    if (self.reDataArr &&[self.reDataArr count] == 1) {
        NSDictionary* dic = [(NSArray*)self.reDataArr  objectAtIndex:0];
        int icode = [[dic objectForKey:@"code"] intValue];
        if (icode == 0) {
            [HSUtils showAlertMessage:@"提示" msg:[dic objectForKey:@"result"] delegate:nil];
        }else{
            userid = [dic objectForKey:@"userid"];
            userName = [dic objectForKey:@"username"];
            mobileCheckView.hidden = NO;
            [self getVerificationCode:nil];
        }
    }
}

#pragma mark  touche btnclick
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [userNamefield resignFirstResponder];
    [passwordfield resignFirstResponder];
}

-(void)closeBtnclick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveBasicInformation{
    //保存登入状态与名称
    NSString* name = [userNamefield text];
    NSString* pass = [passwordfield text];
    [[HSModel sharedHSModel] setIsLogin:YES];
    [[HSModel sharedHSModel] setUserName:userName];
    [[HSModel sharedHSModel] setUserId:userid];
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:KAccount];
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:KAccountId];
    [[NSUserDefaults standardUserDefaults] setObject:pass forKey:KPassword];
}

-(void)login{
    NSString* name = [userNamefield text];
    if ([HSUtils isEmpty:name isStrong:NO]) {
         [HSUtils showAlertMessage:@"提示" msg:@"用户名不能为空" delegate:nil];
        return;
    }
    NSString* pass = [passwordfield text];
    if ([HSUtils isEmpty:pass isStrong:NO]) {
        [HSUtils showAlertMessage:@"提示" msg:@"密码不能为空" delegate:nil];
        return;
    }
    
    [[HSModel sharedHSModel] setIsLogin:NO];
    if (name && pass) {
        name = [@"userid=" stringByAppendingString:name];
        pass = [@"userpwd=" stringByAppendingString:pass];
        self.requestArr = [[NSMutableArray alloc] initWithObjects:name,pass, nil];
        [self requestSafe];
    }else{
        NSLog(@"必须输入用户名与密码");
    }
}

-(void)returnDictionary:(NSDictionary*)redic{
    BOOL isCode = [[redic objectForKey:@"code"] boolValue];
    if (isCode) {
        [self.reDataArr addObject:redic];
        //更新界面
        if ([self refreshData]) {
            [self updateUI];
        }
    }else{
        [HSUtils showAlertMessage:@"提示" msg:@"数据请求失败(nil)\n 1,请检查您的网络连接状态。\n 2,请检查服务器开启状态。" delegate:nil];
    }
}

#pragma mark  check
-(void)checkClicked:(UIButton*)sender{
    
    [self saveBasicInformation];
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:KMessageLogin object:nil];
    
//    NSString* checkStr = @"";
//    for (int i = 0; i < textFieldArr.count; ++i) {
//        UITextField*  textField = [textFieldArr objectAtIndex:i];
//        NSString* text = textField.text ? textField.text : @"";
//        checkStr = [checkStr stringByAppendingString:text];
//    }
//    
//    if (checkStr.length == textFieldArr.count) {
//        //发送校验请求
//        NSString* strUrl = [[HSURLBusiness sharedURL] getSafetyCodeCheckUrl];
//        strUrl = [strUrl stringByAppendingString:@"&"];
//        strUrl = [strUrl stringByAppendingString:[@"userid=" stringByAppendingString:userid]];
//        strUrl = [strUrl stringByAppendingString:@"&"];
//        strUrl = [strUrl stringByAppendingString:[@"mobilesign=" stringByAppendingString:checkStr]];
//        [[HSLoadingView shareLoadingView] show];
//        [self.operation requestByUrl:[NSURL URLWithString:strUrl] successHandler:^(NSData *data) {
//            [[HSLoadingView shareLoadingView] close];
//            NSError* error;
//            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//            if ([jsonObject isKindOfClass:[NSArray class]]) {
//                NSArray* arr = [[NSArray alloc] initWithArray:(NSArray*)jsonObject];
//                if (arr && arr.count == 1) {
//                    NSDictionary* dic = [arr  firstObject];
//                    if ([[dic objectForKey:@"code"] boolValue]) {
//                        [self saveBasicInformation];
//                        [self.navigationController popViewControllerAnimated:YES];
//                        [[NSNotificationCenter defaultCenter] postNotificationName:KMessageLogin object:nil];
//                    }else{
//                        NSLog(@"login Err:%@",[dic objectForKey:@"result"]);
//                        [HSUtils showAlertMessage:@"提示" msg:[dic objectForKey:@"result"] delegate:nil];
//                    }
//                }
//            }
//        } errorHandler:^(NSError *error) {
//            [[HSLoadingView shareLoadingView] close];
//        }];
//    }
}

-(void)getVerificationCode:(UIButton*)sender{
    //开启定时器
    if (timerCount <= 0|| timerCount == KTimerCount) {
        timerCount = KTimerCount;
        [timer setFireDate:[NSDate distantPast]];
        NSString* strUrl = [[HSURLBusiness sharedURL] getSMSCheckUrl];
        strUrl = [strUrl stringByAppendingString:@"&"];
        strUrl = [strUrl stringByAppendingString:[@"userid=" stringByAppendingString:userid]];
        [self.operation requestByUrl:[NSURL URLWithString:strUrl] successHandler:^(NSData *data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSError* error;
                id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                if ([jsonObject isKindOfClass:[NSArray class]]) {
                    NSArray* arr = [[NSArray alloc] initWithArray:(NSArray*)jsonObject];
                    if (arr && arr.count == 1) {
                        NSDictionary* dic = [arr  firstObject];
                        if ([[dic objectForKey:@"code"] boolValue]) {
                            times = [[dic objectForKey:@"dic"] intValue];
                            NSMutableString* mobile = [dic objectForKey:@"mobile"];
                            if (mobile && mobile.length > 8) {
                                NSMutableString* mobile = [[NSMutableString alloc] initWithString:@"13516878567"];
                                [mobile replaceCharactersInRange:NSMakeRange(mobile.length - 8, 4) withString:@"****"];
                                mobileLab.text = mobile;
                            }
                        }else{
                            timerCount = KTimerCount;
                            [timer setFireDate:[NSDate distantFuture]];
                            [verBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
                            [HSUtils showAlertMessage:@"提示" msg:[dic objectForKey:@"result"] delegate:nil];
                            NSLog(@"login Err:%@",[dic objectForKey:@"result"]);
                        }
                    }
                }
            });
        } errorHandler:^(NSError *error) {
            NSLog(@"验证码发送失败，请重新获取");
        }];
    }
}

-(void)timerFunction:(id)sender{
    --timerCount;
    if (timerCount < 0) {
        [timer setFireDate:[NSDate distantFuture]];
    }else{
        [verBtn setTitle:[[NSString alloc] initWithFormat:@"重新获取验证码(%d)",timerCount] forState:UIControlStateNormal];
    }
    
}

#pragma mark  Keyboard
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag < 1000) {
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.view.frame = CGRectMake(0.0f, -98, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag < 1000) {
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag < 1000) {
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag < 1000) {
        return YES;
    }else{
        if (1) {//判断是不是数字和字母或删除 if ([string isEqualToString:@""])
            [self setFieldText:string];
            [self setFieldCursor:string];
            return NO;
        }else{
            return NO;
        }
    }
    return YES;
}

-(void)setFieldText:(NSString*)text{
    if ([text isEqualToString:@""]) {
        for (int i = textFieldArr.count - 1; i >= 0; --i) {
            UITextField* textField = [textFieldArr objectAtIndex:i];
            NSString* str = textField.text;
            if (str && ![str isEqualToString:@""]) {
                textField.text = nil;
                return;
            }
        }
    }else{
        for (int i = 0; i < textFieldArr.count; ++i) {
            UITextField* textField = [textFieldArr objectAtIndex:i];
            NSString* str = textField.text;
            if (str == nil || [str isEqualToString:@""]) {
                textField.text = text;
                return;
            }
        }
    }
}

-(void)setFieldCursor:(NSString*)text{
    if ([text isEqualToString:@""]) {
       for (int i = textFieldArr.count - 1; i >= 0; --i) {
            UITextField* textField = [textFieldArr objectAtIndex:i];
            NSString* str = textField.text;
            if (str && ![str isEqualToString:@""]) {
                [textField becomeFirstResponder];
                return;
            }
        }
    }else{
        for (int i = 0; i < textFieldArr.count; ++i) {
            UITextField* textField = [textFieldArr objectAtIndex:i];
            NSString* str = textField.text;
            if (str == nil || [str isEqualToString:@""]) {
                if (i - 1 > 0) {
                    [[textFieldArr objectAtIndex:(i - 1)] becomeFirstResponder];
                }
                return;
            }
        }
        [[textFieldArr lastObject] becomeFirstResponder];
    }
}

@end
