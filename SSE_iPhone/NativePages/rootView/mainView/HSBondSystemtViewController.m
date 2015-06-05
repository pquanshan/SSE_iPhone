//
//  HSBondSystemtViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/18.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSBondSystemtViewController.h"
#import "HSConfig.h"
#import "HSModel.h"
#import "HSViewControllerFactory.h"
#import "HSRootViewController.h"

@interface HSBondSystemtViewController ()<HSPHttpRequestDelegate>{
    NSArray* titleArr;
    UIViewController* Controller1;
    UIViewController* Controller2;
    UIViewController* Controller3;
}

@end

@implementation HSBondSystemtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[HSColor getColorByColorPageLightBlack]];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(newsConvertRead:) name:KNewsConvertRead object:nil];
    
    titleArr = @[@"流程",@"消息",@"项目"];
    
    Controller1 = [[HSViewControllerFactory sharedFactory] getViewController:HSMPageToDoVC isReload:YES];
    Controller1.tabBarItem.title=@"流程";
    Controller1.tabBarItem.image = [[HSUtils sharedUtils] getImageNamed:@"icon_nav01.png"];
    Controller1.tabBarItem.selectedImage = [[HSUtils sharedUtils] getImageNamed:@"icon_nav01_on.png"];
    
    Controller2 = [[HSViewControllerFactory sharedFactory] getViewController:HSMPageMessageVC isReload:YES];
    Controller2.tabBarItem.title=@"消息";
    Controller2.tabBarItem.image = [[HSUtils sharedUtils] getImageNamed:@"icon_nav02.png"];
    Controller2.tabBarItem.selectedImage = [[HSUtils sharedUtils] getImageNamed:@"icon_nav02_on.png"];

    Controller3 = [[HSViewControllerFactory sharedFactory] getViewController:HSMPageProductsVC isReload:YES];
    Controller3.tabBarItem.title=@"项目";
    Controller3.tabBarItem.image = [[HSUtils sharedUtils]  getImageNamed:@"icon_nav03.png"];
    Controller3.tabBarItem.selectedImage = [[HSUtils sharedUtils] getImageNamed:@"icon_nav03_on.png"];
    
    self.viewControllers=@[Controller1,Controller2,Controller3];
    
    self.tabBar.translucent = NO;
    [self addNavigation];
    [self requestUrl:[[HSURLBusiness sharedURL] getNewsUnreadStatisticsUrl]];
}

-(void)requestUrl:(NSString*)strUrl{
    if ([[HSModel sharedHSModel] isLogin]) {
        HSPHttpOperationManagers* operation = [[HSPHttpOperationManagers alloc] init];
        operation.delegate = self;
        if (strUrl == nil) {
            return;
        }
        NSMutableString* postStr = [[NSMutableString alloc] initWithString:strUrl];
        if ([[HSModel sharedHSModel] isReachable]) {
            [operation addRequestByKey:[NSURL URLWithString:postStr] type:HSRequestTypeGET data:nil];
            [operation executionQueue];
        }else{
            [HSUtils showAlertMessage:@"提示" msg:@"网络连接异常" delegate:nil];
        }
    }
}

-(void)addNavigation{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* img = [[HSUtils sharedUtils] getImageNamed:@"icon_drawdr.png"];
    [button setBackgroundImage:img forState:UIControlStateNormal];
    [button setBackgroundImage:img forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(leftButtonclick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    UIBarButtonItem* leftButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationItem.title = @"流程";
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    self.navigationItem.title = item.title;
}

-(void)leftButtonclick:(id)sender{
    if ([[HSModel sharedHSModel] isShowMain]) {
        [(HSRootViewController*)[[HSViewControllerFactory sharedFactory] rootViewController] showLeftView];
    }else{
        [(HSRootViewController*)[[HSViewControllerFactory sharedFactory] rootViewController] showMainView];
    }
}

-(void)requestFinish:(NSDictionary*)dicData{
    id redata = [dicData objectForKey:@"requestData"];
    if ([redata isKindOfClass:[NSArray class]]) {
        BOOL bl = [[dicData objectForKey:@"requestDataCode"] boolValue];
        if (bl) {
            NSArray* arr =[[NSArray alloc] initWithArray:(NSArray*)redata];
            if (arr.count == 1) {
                int total = [[[arr firstObject] objectForKey:@"total"] intValue];
                if (total > 99) {
                    Controller2.tabBarItem.badgeValue = @"99+";
                }else if (total > 0){
                    Controller2.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",total];
                }
            }
        }
    }
}

-(void)newsConvertRead:(id)sender{
    [self requestUrl:[[HSURLBusiness sharedURL] getNewsUnreadStatisticsUrl]];
}

@end
