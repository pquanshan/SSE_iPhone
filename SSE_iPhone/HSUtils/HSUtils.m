//
//  HSUtils.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/1.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSUtils.h"
#import <UIKit/UIKit.h>
#import "sys/utsname.h"
#import "HsUUID.h"
#import "HSFirstLetter.h"
#import "HSModel.h"
#import <Frontia/Frontia.h>

//static NSMutableArray* huaSenderArr;
//static NSMutableArray* huarArr;
static FrontiaStatistics *statTracker;

@implementation HSUtils

+ (HSUtils *)sharedUtils{
    static HSUtils *sharedUtils = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedUtils = [[self alloc] init];
    });
    return sharedUtils;
}

+(NSString*)getDeviceVersion{
    return [NSString stringWithFormat:@"P%@",[[UIDevice currentDevice] systemVersion]];
}

+(NSString*)getDeviceString{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    NSLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}

+(NSString*)getDeviceToken{
    NSString* tokenStr = [[NSUserDefaults standardUserDefaults] objectForKey:KDeviceToken];
    if (tokenStr == nil) {
        NSString *clientsign = [HsUUID UDID];
        tokenStr = [NSString stringWithFormat:@"%@%@",@"simulator_",clientsign];
    }
    return tokenStr;
}

+(NSString*)getUUID{
    return [HsUUID UDID];
}

+(UIView*)drawLine:(UIView*)view type:(HSLineType)lineType rect:(CGRect)rect color:(UIColor*)color{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    [view addSubview:imageView];
    
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    if (lineType == HSDottedLine) {
        CGFloat lengths[] = {2,2};
        CGContextRef line = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(line, color.CGColor);
        CGContextSetLineDash(line, 0, lengths, 1);  //画虚线
        CGContextMoveToPoint(line, 0.0, 0.0);    //开始画线
        CGContextAddLineToPoint(line, imageView.frame.size.width, 0.0);
        CGContextStrokePath(line);
        imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    }else{
        [imageView setBackgroundColor:color];
    }
    return imageView;
}

+(UIView *)drawTriangle:(UIView *)view rect:(CGRect)rect color:(UIColor *)color title:(NSString *)title {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    [imageView setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:imageView];
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    
    UIGraphicsBeginImageContext(imageView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //利用path进行绘制三角形
    CGContextMoveToPoint(context, 0, 0);//设置起点
    CGContextAddLineToPoint(context, 70, 0);
    CGContextAddLineToPoint(context, 70, 70);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [color setFill]; //设置填充色
    [color setStroke]; //设置边框颜色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    //添加文本
    if (title) {
        float titleLabWidth = imageView.frame.size.width;
        float titleLabHeight = 30;
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, (imageView.frame.size.height - titleLabHeight) / 2, titleLabWidth, 30)];
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = [UIFont boldSystemFontOfSize:14];
        titleLab.text = title;
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.transform = CGAffineTransformMakeRotation(45 * M_PI / 180.0);
        titleLab.center = CGPointMake(titleLabWidth / 2.0 + titleLabWidth / 8.0, titleLabWidth / 2.0 - titleLabWidth / 8.0);
        [imageView addSubview:titleLab];
    }
    
    return imageView;
}

+(UIView *)drawTriangle1:(UIView *)view rect:(CGRect)rect color:(UIColor *)color{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    [imageView setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:imageView];
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    
    UIGraphicsBeginImageContext(imageView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //利用path进行绘制三角形
    CGContextMoveToPoint(context, rect.size.width/2, 0);//设置起点
    CGContextAddLineToPoint(context, 0, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [color setFill]; //设置填充色
    [color setStroke]; //设置边框颜色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    return imageView;
}

+(void)showAlertMessage:(NSString *)title msg:(NSString *)message delegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

+(void)showAlertMessage_OK:(NSString *)title msg:(NSString *)message delegate:(id)delegate{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    [alert show];
}


+(NSDictionary*)getIndexesByArray:(NSArray*)array{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    NSMutableArray* indexArr = [[NSMutableArray alloc] init];
    NSMutableDictionary* indexDetailsDic = [[NSMutableDictionary alloc] init];
    
    NSArray *sortedArray = [array sortedArrayUsingComparator:^(id a, id b) {
        NSString* stra = [(NSDictionary*)a objectForKey:@"username"];
        NSString* strb = [(NSDictionary*)b objectForKey:@"username"];
        char c1 = pinyinFirstLetter([stra characterAtIndex:0]);
        char c2 = pinyinFirstLetter([strb characterAtIndex:0]);
        
//        char c1 = pinyinFirstLetter([(NSString*)a characterAtIndex:0]);
//        char c2 = pinyinFirstLetter([(NSString*)b characterAtIndex:0]);
        NSString* s1=[[NSString stringWithFormat:@"%c",c1] uppercaseString];
        NSString* s2=[[NSString stringWithFormat:@"%c",c2] uppercaseString];
        return [s1 compare:s2];
        
    }];
    
    for(int i = 0; sortedArray && i < sortedArray.count; ++i) {
//        NSString* str = [sortedArray objectAtIndex:i];
        NSDictionary* idic = [sortedArray objectAtIndex:i];
        NSString* str = [idic objectForKey:@"username"];
        
        char ch = pinyinFirstLetter([str characterAtIndex:0]);
        NSString* indexStr = @"";
        if (ch <= '0' && ch <= '9') {
            indexStr =[@"#" uppercaseString];
        }else{
            indexStr =[[NSString stringWithFormat:@"%c",(ch - 32)] uppercaseString];
        }
        if (![indexArr containsObject:indexStr]) {
            [indexArr addObject:indexStr];//加入字符号
            NSMutableArray* itmeArr = [[NSMutableArray alloc] init];
            [indexDetailsDic setObject:itmeArr forKey:indexStr];
        }
        NSMutableArray* muArr = [indexDetailsDic objectForKey:indexStr];
//        [muArr addObject:str];
        [muArr addObject:idic];
    }
    [dic setObject:indexArr forKey:KIndexArr];
    [dic setObject:indexDetailsDic forKey:KIndexDetailsDic];

    
    return dic;
}

char pinyinFirstLetter(unsigned short hanzi){
    if (hanzi < HANZI_START) {//不是汉字
        if (hanzi > 64 && hanzi < 91) {//大学字母转换成小写的
            hanzi += 32;
        }
        return hanzi;
    }else{
        int index = hanzi - HANZI_START;
        return firstLetterArray[index];
    }
}

+(UIImage*) originImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+(BOOL)isEmpty:(NSString*)str isStrong:(BOOL)isStrong{
    BOOL bl = YES;
    if ([str isKindOfClass:[NSString class]]) {
        if (isStrong) {
            str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        if (str.length > 0) {
            bl = NO;
        }
    }
    return bl;
}

-(UIImage*)getImageNamed:(NSString *)name{
    if (!name) {
        return nil;
    }
    NSString *result = @"";
    NSString* imgPathStr = @"";
    switch ([HSModel sharedHSModel].appSystem) {
        case HSAppSystemBond:
            imgPathStr = @"债券系统切图.bundle";
            break;
        case HSAppSystemStock:
            imgPathStr = @"股票系统切图.bundle";
            break;
        default:
            imgPathStr = @"债券系统切图.bundle";
            break;
    }
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:imgPathStr];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSArray* nameArr = [name componentsSeparatedByString:@"."];
    if (nameArr && nameArr.count == 2) {
        result = [bundle pathForResource:[nameArr firstObject] ofType:[nameArr lastObject]];
        if (result == nil) {
            result = [bundle pathForResource:[[nameArr firstObject] stringByAppendingString:@"@2x"] ofType:[nameArr lastObject]];
        }
    }
    result = result == nil ? @"" : result;
    return [UIImage imageWithContentsOfFile:result];
}

-(UIColor*)getColorByColorType:(HSBackgroundColorType)backgroundColorType{
    UIColor* color = [UIColor clearColor];
    switch (backgroundColorType) {
        case HSColorPageWhite:{
          
        }
            break;
        case HSColorPageLightWhite:{
        }
            break;
        case HSColorPageBlack:{
        }
            break;
        case HSColorPageLightBlack:{
        }
            break;
        case HSColorNavigation:{
        }
            break;
        case HSColorNavigationView:{
        }
            break;
            
        default:
            break;
    };
    return color;
}

+(void)registeredBaiduStatistics{
    [Frontia initWithApiKey:APP_KEY];
    statTracker = [Frontia getStatistics];
    [statTracker startWithReportId:REPORT_ID];
}

-(void)logEvent:(NSString*)eventId eventLabel:(NSString*)eventLabel{
    [statTracker logEvent:eventId eventLabel:eventLabel];
}

-(void)pageviewStartWithName:(NSString*)name{
    [statTracker pageviewStartWithName:name];
}

-(void)pageviewEndWithName:(NSString*)name{
    [statTracker pageviewEndWithName:name];
}

@end
