//
//  HSTodoListViewController.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/2/26.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSTabViewController.h"

typedef enum {
    HSPageToDoType = 0,
    HSPageDoneToDoType,
} HSPageType;

@interface HSTodoListViewController : HSTabViewController

@property(nonatomic, assign)HSPageType pageType;
@property(nonatomic, strong)NSString* flowtype;

@property(nonatomic,assign)int tempTotalCount;

@end
