//
//  HSLeftMenuViewController.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/2/26.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSConfig.h"
#import "HSViewControllerFactory.h"

@protocol HSLeftMenuViewControllerDelegate <NSObject>
- (void)leftMenuViewControllerTransformEvent:(HSPageVCType)pageVCType isShowMain:(BOOL)isShowMain;
- (void)leftMenuViewControllerPushEvent:(HSPageVCType)pageVCType;
@end


@interface HSLeftMenuViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, weak) id <HSLeftMenuViewControllerDelegate> delegate;

- (void)setLoginState;

@end
