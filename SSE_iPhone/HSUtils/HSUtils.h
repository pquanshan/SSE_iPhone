//
//  HSUtils.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/1.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HSConfig.h"
#import "HSURLBusiness.h"
#import "HSBusinessAnalytical.h"
#import "HSViewControllerFactory.h"


#define APP_KEY     @"8HO4T0xG7taWMR9vSgDGfNId"
#define REPORT_ID   @"9ca41b63e5"

//百度自定义事件
#define KSeeMenuClose               @"see_menu_close"
#define KSeeMenuOpen                @"see_menu_open"
#define KSeeMenuPublicinfo          @"see_menu_publicinfo"
#define KSeeMenuSet                 @"see_menu_set"
#define KSeeMenuSystem              @"see_menu_system"


typedef enum {
    HSRealizationLine = 0,                  //实现
    HSDottedLine,                           //虚线
} HSLineType;

typedef enum {
    HSInterStyleDefault = 0,    //(蓝色风格)
    HSInterStyleBule = 0,       //Bond  债券（蓝色风格）
    HSInterStyleRed,            //Stock 股票（红色风格）
} HSInterStyleType;

typedef enum {
    HSColorPageWhite= 0,        //页面纯白背景
    HSColorPageLightWhite,      //页面白色背景
    HSColorPageBlack,           //页面纯黑背景
    HSColorPageLightBlack,      //页面黑色背景
    HSColorNavigation,          //导航栏背景
    HSColorNavigationView,      //模拟导航栏背景颜色
} HSBackgroundColorType;

@interface HSUtils : NSObject

+ (HSUtils *)sharedUtils;

//设备系统相关----------------------------------------------------------------------------------------
//获取设备版本号.P为生产编号
+(NSString*)getDeviceVersion;
//获取设备型号
+(NSString*)getDeviceString;
//获取Token值
+(NSString*)getDeviceToken;
//获取UDID-clientsign
+(NSString*)getUUID;

//常用方法-------------------------------------------------------------------------------------------
//画线,返回View
+(UIView*)drawLine:(UIView*)view type:(HSLineType)lineType rect:(CGRect)rect color:(UIColor*)color;
//画三角(左上角45度),返回View
+(UIView *)drawTriangle:(UIView *)view rect:(CGRect)rect color:(UIColor *)color title:(NSString *)title;
//画三角(正方形，上边中点，下边两端点),返回View
+(UIView *)drawTriangle1:(UIView *)view rect:(CGRect)rect color:(UIColor *)color;
//提示对话框，默认确定按钮
+(void)showAlertMessage:(NSString *)title msg:(NSString *)message delegate:(id)delegate;
//提示对话框，默认和取消按钮
+(void)showAlertMessage_OK:(NSString *)title msg:(NSString *)message delegate:(id)delegate;
//对列表索引进行分组（＃A～Z）
+(NSDictionary*)getIndexesByArray:(NSArray*)array;
//改变img大小CGSize
+(UIImage*) originImage:(UIImage *)image scaleToSize:(CGSize)size;
//判断字符是不是空
+(BOOL)isEmpty:(NSString*)str isStrong:(BOOL)isStrong;

//业务相关-------------------------------------------------------------------------------------------
//获取图片
-(UIImage*)getImageNamed:(NSString *)name;
//获取颜色
-(UIColor*)getColorByColorType:(HSBackgroundColorType)backgroundColorType;


//百度统计相关-----------------------------------------------------------------------------------------
//注册百度统计
+(void)registeredBaiduStatistics;
//事件统计点击
-(void)logEvent:(NSString*)eventId eventLabel:(NSString*)eventLabel;
//页面统计开始
-(void)pageviewStartWithName:(NSString*)name;
//页面统计结束
-(void)pageviewEndWithName:(NSString*)name;

@end
