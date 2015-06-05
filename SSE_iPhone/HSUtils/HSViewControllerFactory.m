//
//  HSViewControllerFactory.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/11.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSViewControllerFactory.h"
#import "AppDelegate.h"
#import "HSLoginViewController.h"
#import "GesturePasswordController.h"
#import "HSRootViewController.h"
#import "HSTodoListViewController.h"
#import "HSTodoDetailViewController.h"
#import "HSDoneListViewController.h"
#import "HSDoneDetailViewController.h"
#import "HSHistoryViewController.h"
#import "HSProductsViewController.h"
#import "HSProDetailViewController.h"
#import "HSMessageViewController.h"
#import "HSMsgDetailViewController.h"
#import "HSSettingViewController.h"
#import "HSSetGesturePasswordController.h"
#import "HSAboutViewController.h"
#import "HSMainTabBarViewController.h"
#import "HSPublicInfoViewController.h"
#import "HSPublicInfoDetailViewController.h"
#import "HSSearchViewController.h"
#import "HSStockSystemViewController.h"
#import "HSBondSystemtViewController.h"
#import "ViewController.h"


#define KCacheViewControllerDicKey(a)       [@"CacheViewController" stringByAppendingString:[[NSString alloc] initWithFormat:@"%d",a]];

@implementation HSViewControllerFactory{
    NSMutableDictionary*  cacheViewControllerDic;
}

+(HSViewControllerFactory *)sharedFactory{
    static HSViewControllerFactory *sharedFactory = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedFactory = [[self alloc] init];
    });
    return sharedFactory;
}

-(id)init{
    self = [super init];
    if (self) {
        cacheViewControllerDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(UIViewController*)getViewController:(HSPageVCType)pageVCType isReload:(BOOL)isReload{
    if (isReload) {
        [self deletetCacheViewController:pageVCType];
    }
    UIViewController* viewController = [self getCacheViewController:pageVCType];
    if (viewController) {
        return viewController;
    }
    switch (pageVCType) {
        case HSMPageViewControllerVC:{
            viewController = [[ViewController alloc] init];
        };
            break;
        case HSMPageLoginVC:{
            viewController = [[HSLoginViewController alloc] init];
        };
        break;
        case HSMPageGesturePasswordVC:{
            viewController = [[GesturePasswordController alloc] init];
        };
        break;
        case HSMPageRootVC:{
            viewController = [[HSRootViewController alloc] init];
            _rootViewController = viewController;
        };
        break;
        case HSMPageLeftMenuVC:{
            viewController = [[HSLeftMenuViewController alloc] init];
        };
        break;
        case HSMPageToDoVC:{
            viewController = [[HSToDoViewController alloc] init];
        };
        break;
        case HSMPageTodoListVC:{
            viewController = [[HSTodoListViewController alloc] init];
        };
        break;
        case HSMPageTodoDetailVC:{
            viewController = [[HSTodoDetailViewController alloc] init];
        };
        break;
        case HSMPageHistoryVC:{
            viewController = [[HSHistoryViewController alloc] init];
        };
        break;
        case HSMPageDoneListVC:{
            viewController = [[HSDoneListViewController alloc] init];
        };
        break;
        case HSMPageDoneDetailVC:{
            viewController = [[HSDoneDetailViewController alloc] init];
        };
            break;
        case HSMPageMainTabBarVC:{
            viewController = [[HSMainTabBarViewController alloc] init];
        };
            break;
        case HSMPageBondSystemtVC:{
            viewController = [[HSBondSystemtViewController alloc] init];
        };
            break;
        case HSMPageStockSystemVC:{
            viewController = [[HSStockSystemViewController alloc] init];
        };
            break;
        case HSMPagePublicInfoVC:{
            viewController = [[HSPublicInfoViewController alloc] init];
        };
            break;
        case HSMPagePublicInfoDetailVC:{
            viewController = [[HSPublicInfoDetailViewController alloc] init];
        };
            break;
        case HSMPageSearchVC:{
            viewController = [[HSSearchViewController alloc] init];
        }
            break;
        case HSMPageProductsVC:{
            viewController = [[HSProductsViewController alloc] init];
        };
        break;
        case HSMPageProDetailVC:{
            viewController = [[HSProDetailViewController alloc] init];
        }
            break;
        case HSMPageMessageVC:{
            viewController = [[HSMessageViewController alloc] init];
        };
        break;
        case HSMPageMsgDetailVC:{
            viewController = [[HSMsgDetailViewController alloc] init];
        };
            break;
        case HSMPageSettingVC:{
            viewController = [[HSSettingViewController alloc] init];
        };
        break;
        case HSMPageSetGesturePasswordVC:{
            viewController = [[HSSetGesturePasswordController alloc] init];
        };
        break;
        case HSMPageAboutVC:{
            viewController = [[HSAboutViewController alloc] init];
        };
        break;
        default:{
            viewController = [[ViewController alloc] init];
        }
        break;
    }
    
    [self addCacheViewController:pageVCType viewController:viewController];
    
    return viewController;
}

-(BOOL)isViewController:(HSPageVCType)pageVCType{
    UIViewController* viewController = [self getCacheViewController:pageVCType];
    if (viewController) {
        return YES;
    }
    return NO;
}

-(void)deletetCacheViewController:(HSPageVCType)pageVCType{
    NSString* keyStr = KCacheViewControllerDicKey(pageVCType);
    UIViewController*  viewController =[cacheViewControllerDic objectForKey:keyStr];
    [cacheViewControllerDic removeObjectForKey:keyStr];
    viewController = nil;
}

-(UIViewController*)getCacheViewController:(HSPageVCType)pageVCType{
    NSString* keyStr = KCacheViewControllerDicKey(pageVCType);
    UIViewController*  viewController =[cacheViewControllerDic objectForKey:keyStr];
    return viewController;
}

-(void)addCacheViewController:(HSPageVCType)pageVCType viewController:(UIViewController*)viewController{
    NSString* keyStr = KCacheViewControllerDicKey(pageVCType);
    [cacheViewControllerDic setObject:viewController forKey:keyStr];
}

-(void)gotoGesturePasswordController{
    AppDelegate* app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    GesturePasswordController* gesturePassword = (GesturePasswordController*)[self getViewController:HSMPageGesturePasswordVC isReload:YES];
    gesturePassword.isLogin = NO;
    [app.navigation pushViewController:gesturePassword animated:NO];
}

-(void)gotoLoginController{
    AppDelegate* app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    HSLoginViewController* loginView = (HSLoginViewController*)[self getViewController:HSMPageLoginVC isReload:YES];
    [app.navigation pushViewController:loginView animated:YES];
}

-(UIViewController*)getRootViewController{
    return nil;
}

@end
