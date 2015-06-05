//
//  HSMainTabBarViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/13.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSMainTabBarViewController.h"
#import "HSModel.h"
#import "HSToDoViewController.h"
//#import "UITabBarItem+UITabBarItemCategory.h"
#import "HSRootViewController.h"


@interface HSMainTabBarViewController (){
    NSArray* titleArr;
}

@end

@implementation HSMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[HSColor getColorByColorPageLightBlack]];
    
    titleArr = @[@"流程",@"消息",@"项目"];
    
    UIViewController *c1 = [[HSViewControllerFactory sharedFactory] getViewController:HSMPageToDoVC isReload:YES];
    c1.tabBarItem.title=@"流程";
    c1.tabBarItem.image = [[HSUtils sharedUtils] getImageNamed:@"icon_nav01.png"];
    c1.tabBarItem.selectedImage = [[HSUtils sharedUtils] getImageNamed:@"icon_nav01_on.png"];
    UIViewController *c2 = [[HSViewControllerFactory sharedFactory] getViewController:HSMPageMessageVC isReload:YES];
    c2.tabBarItem.title=@"消息";
    c2.tabBarItem.image = [[HSUtils sharedUtils] getImageNamed:@"icon_nav02.png"];
    c2.tabBarItem.selectedImage = [[HSUtils sharedUtils] getImageNamed:@"icon_nav02_on.png"];

    UIViewController *c3 = [[HSViewControllerFactory sharedFactory] getViewController:HSMPageProductsVC isReload:YES];
    c3.tabBarItem.title=@"项目";
    c3.tabBarItem.image = [[HSUtils sharedUtils] getImageNamed:@"icon_nav03.png"];
    c3.tabBarItem.selectedImage = [[HSUtils sharedUtils] getImageNamed:@"icon_nav03_on.png"];

    [self addNavigation];
    
    self.viewControllers=@[c1,c2,c3];
    
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
    self.navigationItem.title = @"TCMP";
}

-(void)leftButtonclick:(id)sender{
    if ([[HSModel sharedHSModel] isShowMain]) {
        [(HSRootViewController*)[[HSViewControllerFactory sharedFactory] rootViewController] showLeftView];
    }else{
        [(HSRootViewController*)[[HSViewControllerFactory sharedFactory] rootViewController] showMainView];
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    viewController.navigationItem.title = [titleArr objectAtIndex:self.selectedIndex];
}

@end
