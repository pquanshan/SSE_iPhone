//
//  HSSettingViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/5.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

//#define KPersonalInfoHeight    (250)
#define KPersonalInfoHeight    (150)
#define KTabViewHeight         (300)
#define KTabViewRowHeight      (55)

//#define KBoundaryOFF            (10)
//#define KMiddleOFF              (5)
#define KLROFF                  (25)
#define KOFFWidth               (10)

#define KButtonHeight           (40)
#define KButtonWidth            (40)
#define KImageViewWHeight       (70)
#define KLabelHeight            (30)

#import "HSSettingViewController.h"
#import "HSModel.h"
#import "HSConfig.h"
#import "HSSetGesturePasswordController.h"
#import "HSAboutViewController.h"

@interface HSSettingViewController (){
    UITableView* tabview;
    NSMutableArray* menuArr;
    UILabel* nameLab;
}

@end

@implementation HSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(login:) name:KMessageLogin object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(logout:) name:KMessageLogOut object:nil];
    self.navigationItem.title = @"设置";
    [self.view setBackgroundColor:[HSColor getColorByColorPageLightWhite]];
    [self addPersonalInfoView];
    [self addTabview];
    [self initMenuArr];
}

-(void)initMenuArr{
    [self setmenuArr];
}

-(void)viewWillAppear:(BOOL)animated{
    [tabview reloadData];
}

-(void)setmenuArr{
//    if ([[HSModel sharedHSModel] isLogin]) {
//        BOOL bl = [[[NSUserDefaults standardUserDefaults] objectForKey:KActivationGesturePassword] boolValue];
//        if (bl) {
//            menuArr = [[NSMutableArray alloc] initWithObjects:@[@"启用手势密码",@"设置手势密码"],@[@"关于软件",@"当前版本"],@[@"注销登录"], nil];
//        }else{
//            menuArr = [[NSMutableArray alloc] initWithObjects:@[@"启用手势密码"],@[@"关于软件",@"当前版本"],@[@"注销登录"], nil];
//        }
//    }else{
//        menuArr = [[NSMutableArray alloc] initWithObjects:@[@"关于软件",@"当前版本"],@[@"登录"], nil];
//    }
    if ([[HSModel sharedHSModel] isLogin]) {
        BOOL bl = [[[NSUserDefaults standardUserDefaults] objectForKey:KActivationGesturePassword] boolValue];
        if (bl) {
            menuArr = [[NSMutableArray alloc] initWithObjects:@[@"启用手势密码",@"设置手势密码"],@[@"当前版本"],@[@"注销登录"], nil];
        }else{
            menuArr = [[NSMutableArray alloc] initWithObjects:@[@"启用手势密码"],@[@"当前版本"],@[@"注销登录"], nil];
        }
    }else{
        menuArr = [[NSMutableArray alloc] initWithObjects:@[@"当前版本"],@[@"登录"], nil];
    }
}

-(void)addPersonalInfoView{
    UIView* personalInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, KPersonalInfoHeight)];
    [personalInfoView setBackgroundColor:KCorolTextLGray];
    [self.view addSubview:personalInfoView];
    UIImageView* magView = [[UIImageView alloc] initWithFrame:CGRectMake((personalInfoView.frame.size.width - KImageViewWHeight)/2.0, KPersonalInfoHeight - KLabelHeight - KImageViewWHeight - KMiddleOFF, KImageViewWHeight, KImageViewWHeight)];
    magView.clipsToBounds = YES;
    magView.layer.cornerRadius = KImageViewWHeight/2.0;
    
    nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, KPersonalInfoHeight - KLabelHeight,personalInfoView.frame.size.width, KLabelHeight)];
    nameLab.textColor = [UIColor whiteColor];
    nameLab.textAlignment = NSTextAlignmentCenter;
    [personalInfoView addSubview:magView];
    [personalInfoView addSubview:nameLab];

    [magView setImage:[UIImage imageNamed:@"headPortrait.png"]];
    if ([[HSModel sharedHSModel] isLogin]) {
        [nameLab setText:[[HSModel sharedHSModel] userName]];
    }else{
        [nameLab setText:@"未登录"];
    }
}

-(void)addTabview{
    tabview = [[UITableView alloc] initWithFrame:CGRectMake(0, KPersonalInfoHeight, self.view.frame.size.width, self.view.frame.size.height - KPersonalInfoHeight) style:UITableViewStyleGrouped];
    [tabview setBackgroundColor:[UIColor clearColor]];
    tabview.delegate = self;
    tabview.dataSource = self;
    tabview.rowHeight = KTabViewRowHeight;
    [self.view addSubview:tabview];
}


#pragma mark UITableView
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    NSArray* sunArr = [menuArr objectAtIndex:indexPath.section];
    NSString* strType = [sunArr objectAtIndex:indexPath.row];
    if ([strType isEqualToString:@"启用手势密码"]) {
        cell.textLabel.text = [sunArr objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        BOOL bl = [[[NSUserDefaults standardUserDefaults]objectForKey:KActivationGesturePassword] boolValue];
        UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(tabview.frame.size.width - 65, 12 ,0, 0)];
        [switchButton setOn:bl];
        [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:switchButton];
    }else if ([strType isEqualToString:@"设置手势密码"]){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [sunArr objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }else if ([strType isEqualToString:@"关于软件"]){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [sunArr objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }else if ([strType isEqualToString:@"当前版本"]){
        cell.accessoryType = UITableViewCellAccessoryNone;
        UILabel* versionLab = [[UILabel alloc] initWithFrame:CGRectMake(tabview.frame.size.width - KBoundaryOFF - 100, 0 ,100, KTabViewRowHeight)];
        NSString* version =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        versionLab.text = version;
        [cell.contentView addSubview:versionLab];
        
        versionLab.textAlignment = NSTextAlignmentRight;
        versionLab.font = [UIFont systemFontOfSize:14];
        versionLab.textColor = [UIColor grayColor];
        cell.textLabel.text = strType;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }else if ([strType isEqualToString:@"注销登录"] || [strType isEqualToString:@"登录"]){
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
        [cell.textLabel setText:strType];
        if ([[HSModel sharedHSModel] isLogin]) {
            [cell setBackgroundColor:[UIColor orangeColor]];
        }else{
            [cell setBackgroundColor:[UIColor redColor]];
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[menuArr objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return menuArr.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray* sunArr = [menuArr objectAtIndex:indexPath.section];
    NSString* strType = [sunArr objectAtIndex:indexPath.row];
    if ([strType isEqualToString:@"启用手势密码"]) {
    }else if ([strType isEqualToString:@"设置手势密码"]) {
        HSSetGesturePasswordController *  gesturePassword = (HSSetGesturePasswordController*)[[HSViewControllerFactory sharedFactory] getViewController:HSMPageSetGesturePasswordVC isReload:YES];
        [self.navigationController pushViewController:gesturePassword animated:YES];
        
    }else if([strType isEqualToString:@"关于软件"]) {
//        HSAboutViewController* aboutView = (HSAboutViewController*)[[HSViewControllerFactory sharedFactory] getViewController:HSMPageAboutVC isReload:NO];
//        [self.navigationController pushViewController:aboutView animated:YES];
    }else if([strType isEqualToString:@"当前版本"]){
//        [HSUtils showAlertMessage:@"提示" msg:@"暂无法检查新版本" delegate:nil];
    }else if ([strType isEqualToString:@"注销登录"] || [strType isEqualToString:@"登录"]){
        if ([[HSModel sharedHSModel] isLogin]) {
            [self requestSafe];
        }else{
            [[HSViewControllerFactory sharedFactory] gotoLoginController];
        }
    }
}

-(void)switchAction:(id)sender{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:KActivationGesturePassword];
    }else {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:KActivationGesturePassword];
    }
    [self setmenuArr];
    [tabview reloadData];
}

#pragma mark Subclassing
-(BOOL)isAutomaticRequest{
    return NO;
}

-(NSString*)requestStrUrl{
    return [[HSURLBusiness sharedURL] getLogoutUrl];
}

-(void)updateUI{
    if (self.reDataArr &&[self.reDataArr count] == 1) {
        NSDictionary* dic = [(NSArray*)self.reDataArr  objectAtIndex:0];
        int icode = [[dic objectForKey:@"code"] intValue];
        if (icode == 0) {
            [HSUtils showAlertMessage:@"提示" msg:[dic objectForKey:@"result"] delegate:nil];
        }else{
            [[HSModel sharedHSModel] setIsLogin:NO];
            [[HSModel sharedHSModel] setUserName:@""];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:KAccountId];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:KAccount];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:KPassword];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:KGesturePassword];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:KActivationGesturePassword];
            [[NSNotificationCenter defaultCenter] postNotificationName:KMessageLogOut object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
    }
}

-(void)login:(id)sender{
    [self setmenuArr];
//    menuArr = [[NSMutableArray alloc] initWithObjects:@[@"启用手势密码"],@[@"关于软件",@"当前版本"],@[@"注销登录"], nil];
    if ([[HSModel sharedHSModel] userName]) {
        nameLab.text = [[HSModel sharedHSModel] userName];
    }else{
        nameLab.text = @"已登录";
    }
    
    [tabview reloadData];
}

-(void)logout:(id)sender{
    [self setmenuArr];
//    menuArr = [[NSMutableArray alloc] initWithObjects:@[@"关于软件",@"当前版本"],@[@"登录"], nil];
    nameLab.text= @"未登录";
    [tabview reloadData];
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

@end
