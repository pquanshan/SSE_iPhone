//
//  HSLoginViewController.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/2/28.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSViewControllerBase.h"


@interface HSLoginViewController : HSViewControllerBase{
    UITextField* userNamefield;
    UITextField* passwordfield;
    
    NSString* userid;
}

@end
