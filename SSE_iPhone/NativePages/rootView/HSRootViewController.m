//
//  HSRootViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/2/26.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSRootViewController.h"
#import "HSViewControllerFactory.h"
#import "GesturePasswordController.h"
#import "KeychainItemWrapper.h"

#define KFtranProportion        (0.75)
#define KLeftOff                (40)

@interface HSRootViewController (){
    BOOL isautoPushPWD;
}

@end

@implementation HSRootViewController
@synthesize speedf,sideslipTapGes,isRightPan;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(login:) name:KMessageLogin object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(logout:) name:KMessageLogOut object:nil];

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"返回"
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:nil];
    speedf = 0.5;
    isRightPan = NO;
    [self showMainView];
    isautoPushPWD = YES;
    
}

-(void)autoPushPWD{
    if (isautoPushPWD) {
        NSString* accountid = [[NSUserDefaults standardUserDefaults] objectForKey:KAccountId];
        NSString* pass = [[NSUserDefaults standardUserDefaults] objectForKey:KPassword];
        if (accountid && pass) {
            NSString* gesturePassword  = [[NSUserDefaults standardUserDefaults] objectForKey:KGesturePassword];
            NSString* account = [[NSUserDefaults standardUserDefaults] objectForKey:KAccount];
            BOOL activationGP = [[[NSUserDefaults standardUserDefaults] objectForKey:KActivationGesturePassword] boolValue];
            if (gesturePassword && account && activationGP && [gesturePassword isEqualToString:account]) {
                [[HSViewControllerFactory sharedFactory] gotoGesturePasswordController];
            }
        }
        isautoPushPWD = NO;
    }
}

-(void)viewWillAppear:(BOOL)animated{
   [self.navigationController setNavigationBarHidden:YES animated:NO];
    if ([leftControl isKindOfClass:[HSLeftMenuViewController class]]) {
        [(HSLeftMenuViewController*)leftControl setLoginState];
    }
    [self autoPushPWD];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

-(instancetype)init{
    self = [super init];
    if (self) {
        HSMainTabBarViewController * main = (HSMainTabBarViewController*)[[HSViewControllerFactory  sharedFactory] getViewController:HSMPagePublicInfoVC isReload:NO];
        UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:main];
        navigation.navigationBar.barTintColor = [HSColor getColorByColorNavigation];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        NSDictionary* textAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                         NSForegroundColorAttributeName:[UIColor whiteColor]};
        navigation.navigationBar.titleTextAttributes = textAttributes;
        navigation.navigationBar.translucent = NO;
        [navigation.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        navigation.navigationBar.shadowImage = [[UIImage alloc] init];
        
        HSLeftMenuViewController * left = (HSLeftMenuViewController*)[[HSViewControllerFactory  sharedFactory] getViewController:HSMPageLeftMenuVC isReload:NO];
        UIViewController * right = [[HSViewControllerFactory  sharedFactory] getViewController:HSMPageViewControllerVC isReload:NO];
        
        self = [self initWithLeftView:left andMainView:navigation andRightView:right];
    }
    return self;
}

-(void)login:(id)sender{
    if ([leftControl isKindOfClass:[HSLeftMenuViewController class]]) {
        [(HSLeftMenuViewController*)leftControl setLoginState];
        [self leftMenuViewControllerTransformEvent:[[HSModel sharedHSModel] getMainSystemVC] isShowMain:NO];
    }
}

-(void)logout:(id)sender{
    if ([leftControl isKindOfClass:[HSLeftMenuViewController class]]) {
        [(HSLeftMenuViewController*)leftControl setLoginState];
    }
    [[HSViewControllerFactory sharedFactory] deletetCacheViewController:[[HSModel sharedHSModel] getMainSystemVC]];
    [self leftMenuViewControllerTransformEvent:HSMPagePublicInfoVC isShowMain:NO];
}


-(instancetype)initWithLeftView:(UIViewController *)LeftView
                    andMainView:(UIViewController *)MainView
                   andRightView:(UIViewController *)RighView;
{
    if(self){
        leftControl = LeftView;
        mainControl = MainView;
        righControl = RighView;
    

        if ([leftControl isKindOfClass:[HSLeftMenuViewController class]]) {
            HSLeftMenuViewController* pleftControl = (HSLeftMenuViewController*)leftControl;
            pleftControl.delegate = self;
        }
        
        //单击手势
        sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [sideslipTapGes setNumberOfTapsRequired:1];
        [mainControl.view addGestureRecognizer:sideslipTapGes];
        sideslipTapGes.enabled = NO;
        
        //滑动手势
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [mainControl.view addGestureRecognizer:pan];
        
        leftControl.view.alpha = 0;
        righControl.view.hidden = YES;
        
        [self.view addSubview:leftControl.view];
        [self.view addSubview:righControl.view];
        [self.view addSubview:mainControl.view];
        
    }
    return self;
}

#pragma mark - 滑动手势
//滑动手势
- (void) handlePan: (UIPanGestureRecognizer *)rec{
    switch (rec.state) {
        case UIGestureRecognizerStateBegan:
        {
        }
        break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint point = [rec translationInView:self.view];
            scalef = (point.x*speedf+scalef);
            //根据视图位置判断是左滑还是右边滑动
            if (rec.view.frame.origin.x>=0){
                rec.view.center = CGPointMake(rec.view.center.x + point.x*speedf,rec.view.center.y);
                [rec setTranslation:CGPointMake(0, 0) inView:self.view];
                righControl.view.hidden = YES;
                float ftran = KFtranProportion + rec.view.frame.origin.x * (1 - KFtranProportion)/KLeftShowWidth;
                ftran = ftran > 1 ? 1 : ftran;
                
                float leftW = ([UIScreen mainScreen].bounds.size.width * ftran);
                float leftCenter_x = leftW/2 - (KLeftOff - KLeftOff*(ftran - KFtranProportion)/(1 - KFtranProportion));
                leftControl.view.center = CGPointMake(leftCenter_x,[UIScreen mainScreen].bounds.size.height/2);
                leftControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,ftran,ftran);
                leftControl.view.alpha = 1 - (1-ftran)/(1 - KFtranProportion);
            }else{
//                        if (isRightPan) {
                rec.view.center = CGPointMake(rec.view.center.x + point.x*speedf,rec.view.center.y);
                [rec setTranslation:CGPointMake(0, 0) inView:self.view];
                
                righControl.view.hidden = NO;
                leftControl.view.alpha = 0;
//                        }

            }
        }
        break;
        case UIGestureRecognizerStateEnded:
        {
            if (scalef > KLeftShowWidth*speedf){
                [self showLeftView];
            }else if (scalef<-100*speedf) {
                if (isRightPan) {
                    [self showRighView];
                    scalef = 0;
                }else{
                    [self showMainView];
                    scalef = 0;
                }
            }else {
                [self showMainView];
                scalef = 0;
            }
        }
        break;
        
        default:
        break;
    }
}


#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    if (tap.state == UIGestureRecognizerStateEnded) {
        [self showMainView];
    }
}

#pragma mark - 修改视图位置
//恢复位置
-(void)showMainView{
    [[HSUtils sharedUtils] logEvent:KSeeMenuClose eventLabel:nil];
    
    [[HSModel sharedHSModel] setIsShowMain:YES];
    sideslipTapGes.enabled = NO;
    [UIView beginAnimations:nil context:nil];
    
    float leftCenter_x = [UIScreen mainScreen].bounds.size.width * KFtranProportion/2 - KLeftOff;
    leftControl.view.center = CGPointMake(leftCenter_x,[UIScreen mainScreen].bounds.size.height/2);
    leftControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,KFtranProportion,KFtranProportion);
    leftControl.view.alpha = 0;
    
    mainControl.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
    scalef = 0;
}

//显示左视图
-(void)showLeftView{
    [[HSUtils sharedUtils] logEvent:KSeeMenuOpen eventLabel:nil];
    
    [[HSModel sharedHSModel] setIsShowMain:NO];
    righControl.view.hidden = YES;
    sideslipTapGes.enabled = YES;
    float fw = [UIScreen mainScreen].bounds.size.width/2;
    
    [UIView beginAnimations:nil context:nil];
    leftControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    leftControl.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
    leftControl.view.alpha = 1;
    
    mainControl.view.center = CGPointMake(fw + KLeftShowWidth,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}

//显示右视图
-(void)showRighView{
    [[HSModel sharedHSModel] setIsShowMain:NO];
    righControl.view.hidden = NO;
//    leftControl.view.hidden = YES;
    sideslipTapGes.enabled = YES;
    float fw = [UIScreen mainScreen].bounds.size.width/2;
    
    [UIView beginAnimations:nil context:nil];
    righControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    righControl.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
    mainControl.view.center = CGPointMake(fw - 230,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}

-(void)setMainControl:(UIViewController*)viewController{
    CGPoint point =  mainControl.view.center;
    [mainControl.view removeFromSuperview];
    
    mainControl = viewController;
    mainControl.view.center = point;
    //单击手势
    sideslipTapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
    [sideslipTapGes setNumberOfTapsRequired:1];
    [mainControl.view addGestureRecognizer:sideslipTapGes];
    sideslipTapGes.enabled = NO;
    
    //滑动手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [mainControl.view addGestureRecognizer:pan];
    [self.view addSubview:mainControl.view];
    
}

//#warning 为了界面美观，所以隐藏了状态栏。如果需要显示则去掉此代码
//- (BOOL)prefersStatusBarHidden
//{
//    return YES; //返回NO表示要显示，返回YES将hiden
//}
//

#pragma mark - HSLeftMenuViewControllerDelegate
-(void)leftMenuViewControllerTransformEvent:(HSPageVCType)pageVCType isShowMain:(BOOL)isShowMain{
    UIViewController* viewController = [[HSViewControllerFactory sharedFactory] getViewController:pageVCType isReload:YES];
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:viewController];
    navigation.navigationBar.barTintColor = [HSColor getColorByColorNavigation];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    NSDictionary* textAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                     NSForegroundColorAttributeName:[UIColor whiteColor]};
    navigation.navigationBar.titleTextAttributes = textAttributes;
    navigation.navigationBar.translucent = NO;
    [navigation.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    navigation.navigationBar.shadowImage = [[UIImage alloc] init];
    [self setMainControl:navigation];
    if (isShowMain) {
         [self showMainView];
    }
}

-(void)leftMenuViewControllerPushEvent:(HSPageVCType)pageVCType{    
    UIViewController* viewController = [[HSViewControllerFactory sharedFactory] getViewController:pageVCType isReload:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
