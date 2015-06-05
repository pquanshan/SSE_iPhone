//
//  HSColor.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/5/9.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSColor.h"
#import "HSConfig.h"
#import "HSModel.h"

@implementation HSColor


+(UIColor*)getColorByColorPageWhite{
    UIColor* color = [UIColor clearColor];
    switch ([HSModel sharedHSModel].appSystem) {
        case HSAppSystemBond:
            
            break;
        case HSAppSystemStock:
            
            break;
        case HSAppSystemTCMP:
            
            break;
            
        default:
            break;
    }
    return color;
}

+(UIColor*)getColorByColorPageLightWhite{
    UIColor* color = [UIColor clearColor];
    switch ([HSModel sharedHSModel].appSystem) {
        case HSAppSystemBond:
            color = KCorolBackViewLWhite;
            break;
        case HSAppSystemStock:
            color = KCorolBackViewLWhite;
            break;
        case HSAppSystemTCMP:
            color = KCorolBackViewLWhite;
            break;
            
        default:
            break;
    }
    return color;
}

+(UIColor*)getColorByColorPageBlack{
    UIColor* color = [UIColor clearColor];
    switch ([HSModel sharedHSModel].appSystem) {
        case HSAppSystemBond:
             color = KCorolBackViewLWhite;
            break;
        case HSAppSystemStock:
            
            break;
        case HSAppSystemTCMP:
            
            break;
            
        default:
            break;
    }
    return color;
}

+(UIColor*)getColorByColorPageLightBlack{
    UIColor* color = [UIColor clearColor];
    switch ([HSModel sharedHSModel].appSystem) {
        case HSAppSystemBond:
            color = KCorolBackViewLWhite;
            break;
        case HSAppSystemStock:
            color = KCorolBackViewLWhite;
            break;
        case HSAppSystemTCMP:
            color = KCorolBackViewLWhite;
            break;
            
        default:
            break;
    }
    return color;
}

+(UIColor*)getColorByColorNavigation{
    UIColor* color = [UIColor clearColor];
    switch ([HSModel sharedHSModel].appSystem) {
        case HSAppSystemBond:
            color = KCorolNavBackViewBlue;
            break;
        case HSAppSystemStock:
            color = KCorolNavBackViewRed;
            break;
        case HSAppSystemTCMP:
            color = KCorolNavBackViewBlue;
            break;
            
        default:
            break;
    }
    return color;
}

+(UIColor*)getColorByColorNavigationView{
    UIColor* color = [UIColor clearColor];
    switch ([HSModel sharedHSModel].appSystem) {
        case HSAppSystemBond:
            
            break;
        case HSAppSystemStock:
            
            break;
        case HSAppSystemTCMP:
            
            break;
            
        default:
            break;
    }
    return color;
}

+(UIColor*)getColorByColorPageDarkBackView{
    UIColor* color = [UIColor clearColor];
    switch ([HSModel sharedHSModel].appSystem) {
        case HSAppSystemBond:
            color = KCorolBackViewDarkBlue;
            break;
        case HSAppSystemStock:
            color = KCorolBackViewDarkBack;
            break;
        case HSAppSystemTCMP:
            color = KCorolBackViewDarkBlue;
            break;
            
        default:
            break;
    }
    return color;
}

@end
