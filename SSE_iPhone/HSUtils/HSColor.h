//
//  HSColor.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/5/9.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//债券------------------------------------------------------------------------------------------------------------------------------
//常用颜色
#define KCorolBackViewWhite         [UIColor colorWithRed:0xFF/255.0  green:0xFF/255.0 blue:0xFF/255.0 alpha:1]//白色
#define KCorolBackViewLWhite        [UIColor colorWithRed:0xF8/255.0  green:0xF8/255.0 blue:0xF8/255.0 alpha:1]//浅白色（可作为page背景）
#define KCorolBackViewLLWhite       [UIColor colorWithRed:0xEF/255.0  green:0xEF/255.0 blue:0xEF/255.0 alpha:1]

#define KCorolTextLBlue             [UIColor colorWithRed:78/255.0  green:149/255.0 blue:203/255.0 alpha:1]//浅蓝
#define KCorolTextLGray             [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1]//浅灰
#define KCorolTextLLGray            [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1]//浅浅灰
#define KCorolBackViewBlack         [UIColor colorWithRed:26/255.0  green:28/255.0  blue:31/255.0 alpha:1] //背景黑

#define KCorolBackViewDarkBlue      [UIColor colorWithRed:33/255.0   green:54/255.0  blue:75/255.0 alpha:1]//背景深蓝
#define KCorolBackViewDarkBack      [UIColor colorWithRed:30/255.0   green:30/255.0  blue:40/255.0 alpha:1]//背景深黑

#define KCorolBackViewBlue          [UIColor colorWithRed:0xD6/255.0  green:0x60/255.0 blue:0x4D/255.0 alpha:1]//背景蓝
#define KCorolNavBackViewBlue       [UIColor colorWithRed:0x21/255.0  green:0x66/255.0 blue:0xAC/255.0 alpha:1]//导航栏蓝

#define KCorolBackViewRed           [UIColor colorWithRed:0xD6/255.0  green:0x60/255.0 blue:0x4D/255.0 alpha:1]//背景红
#define KCorolNavBackViewRed        [UIColor colorWithRed:0xCE/255.0  green:0x2D/255.0 blue:0x2D/255.0 alpha:1]//导航栏红


//文本颜色
#define KCorolTextBlue              [UIColor colorWithRed:0x21/255.0  green:0x66/255.0  blue:0xAC/255.0 alpha:1]//文本蓝
#define KCorolTextRed               [UIColor colorWithRed:0xB2/255.0  green:0x18/255.0  blue:0x2B/255.0 alpha:1]//文本红
#define KCorolTextBWhite            [UIColor colorWithRed:0xD1/255.0  green:0xE5/255.0  blue:0xF0/255.0 alpha:1]//文本蓝白色
//文本背景颜色
#define KCorolTextBackViewYellow    [UIColor colorWithRed:0xFD/255.0  green:0xDB/255.0  blue:0xC7/255.0 alpha:1]//文本底色黄
#define KCorolTextBackViewAlpha     [UIColor colorWithRed:0xFF/255.0  green:0xFF/255.0  blue:0xFF/255.0 alpha:0.3]//文本底色0.3半透明
#define KCorolTextBackViewLAlpha    [UIColor colorWithRed:0xFF/255.0  green:0xFF/255.0  blue:0xFF/255.0 alpha:0.2]//文本底色0.2半透明
#define KCorolTextBackViewLLAlpha   [UIColor colorWithRed:0xFF/255.0  green:0xFF/255.0  blue:0xFF/255.0 alpha:0.1]//文本底色0.1半透明
//审批流程类型颜色
#define KCorolBackViewGreenPro      [UIColor colorWithRed:0x4A/255.0  green:0xAB/255.0  blue:0x5E/255.0 alpha:1]//审批绿色 同意
#define KCorolBackViewBluePro       [UIColor colorWithRed:0x35/255.0  green:0x74/255.0  blue:0xB3/255.0 alpha:1]//投票蓝色
#define KCorolBackViewYellowPro     [UIColor colorWithRed:0xF4/255.0  green:0xA5/255.0  blue:0x82/255.0 alpha:1]//会签黄色
#define KCorolBackViewBrownPro      [UIColor colorWithRed:0xBB/255.0  green:0x97/255.0  blue:0x7D/255.0 alpha:1]//协作棕色
#define KCorolBackViewRedPro        [UIColor colorWithRed:0xD6/255.0  green:0x60/255.0 blue:0x4D/255.0 alpha:1]//否决

////股票------------------------------------------------------------------------------------------------------------------------------
////常用颜色
//#define KCorolTextLBlue             [UIColor colorWithRed:78/255.0  green:149/255.0 blue:203/255.0 alpha:1]//浅蓝
//#define KCorolTextLGray             [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1]//浅灰
//#define KCorolTextLLGray            [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1]//浅浅灰
//#define KCorolBackViewBlack         [UIColor colorWithRed:26/255.0  green:28/255.0  blue:31/255.0 alpha:1] //背景黑
//#define KCorolBackViewDarkBlue      [UIColor colorWithRed:33/255.0   green:54/255.0  blue:75/255.0 alpha:1]//背景深蓝
//#define KCorolBackViewRed           [UIColor colorWithRed:0xD6/255.0  green:0x60/255.0 blue:0x4D/255.0 alpha:1]//背景红
//#define KCorolNavBackViewBlue       [UIColor colorWithRed:0x21/255.0  green:0x66/255.0 blue:0xAC/255.0 alpha:1]//导航栏蓝
//#define KCorolBasicBackViewWhite    [UIColor colorWithRed:0xF8/255.0  green:0xF8/255.0 blue:0xF8/255.0 alpha:1]//背景白色
//
////文本颜色
//#define KCorolTextBlue              [UIColor colorWithRed:0x21/255.0  green:0x66/255.0  blue:0xAC/255.0 alpha:1]//文本蓝
//#define KCorolTextRed               [UIColor colorWithRed:0xB2/255.0  green:0x18/255.0  blue:0x2B/255.0 alpha:1]//文本红
//#define KCorolTextBWhite            [UIColor colorWithRed:0xD1/255.0  green:0xE5/255.0  blue:0xF0/255.0 alpha:1]//文本蓝白色
////文本背景颜色
//#define KCorolTextBackViewYellow    [UIColor colorWithRed:0xFD/255.0  green:0xDB/255.0  blue:0xC7/255.0 alpha:1]//文本底色黄
//#define KCorolTextBackViewAlpha     [UIColor colorWithRed:0xFF/255.0  green:0xFF/255.0  blue:0xFF/255.0 alpha:0.3]//文本底色0.3半透明
//#define KCorolTextBackViewLAlpha    [UIColor colorWithRed:0xFF/255.0  green:0xFF/255.0  blue:0xFF/255.0 alpha:0.2]//文本底色0.2半透明
//#define KCorolTextBackViewLLAlpha   [UIColor colorWithRed:0xFF/255.0  green:0xFF/255.0  blue:0xFF/255.0 alpha:0.1]//文本底色0.1半透明
////审批流程类型颜色
//#define KCorolBackViewGreen         [UIColor colorWithRed:0x4A/255.0  green:0xAB/255.0  blue:0x5E/255.0 alpha:1]//审批绿色
//#define KCorolBackViewBlue          [UIColor colorWithRed:0x35/255.0  green:0x74/255.0  blue:0xB3/255.0 alpha:1]//投票蓝色
//#define KCorolBackViewYellow        [UIColor colorWithRed:0xF4/255.0  green:0xA5/255.0  blue:0x82/255.0 alpha:1]//会签黄色
//#define KCorolBackViewBrown         [UIColor colorWithRed:0xBB/255.0  green:0x97/255.0  blue:0x7D/255.0 alpha:1]//协作棕色


@interface HSColor : NSObject

+(UIColor*)getColorByColorPageWhite;
+(UIColor*)getColorByColorPageLightWhite;
+(UIColor*)getColorByColorPageBlack;
+(UIColor*)getColorByColorPageLightBlack;
+(UIColor*)getColorByColorNavigation;
+(UIColor*)getColorByColorNavigationView;
+(UIColor*)getColorByColorPageDarkBackView;

@end
