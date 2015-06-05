//
//  HSBusinessAnalytical.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/3.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSBusinessAnalytical.h"
#import "HSModel.h"

@implementation HSBusinessAnalytical

+ (HSBusinessAnalytical *)sharedBusinessAnalytical
{
    static HSBusinessAnalytical *sharedBusinessAnalytical = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedBusinessAnalytical = [[self alloc] init];
    });
    return sharedBusinessAnalytical;
}


-(NSArray*)getAnnexStringByHsstr:(NSString*)string{
    //例: string为--- ["窗口显示.jpg|147076|\\attach\\oa\\document\\201404\\139692382696886.jpg"]
    NSMutableArray* muArr = [[NSMutableArray alloc] init];
    NSString* targetStr = [string substringWithRange:NSMakeRange(1, string.length-1)];
    NSArray* strArr = [targetStr componentsSeparatedByString:@"\""];
    for (int i = 0; i < strArr.count; ++i) {
        NSString* addStr = [strArr objectAtIndex:i];
        NSArray* strItmeArr = [addStr componentsSeparatedByString:@"|"];
        if (strItmeArr && strItmeArr.count == 3) {  // x|x|x
            [muArr addObject:addStr];
        }
    }
    return muArr;
}

-(NSArray*)getAnnexDetailByHsstr:(NSString*)string{
    //例: string为--- 窗口显示.jpg|147076|\\attach\\oa\\document\\201404\\139692382696886.jpg
    return [string componentsSeparatedByString:@"|"];
}

-(NSString*)getSizeByLong:(long)lsize{
    float size = lsize;
    int index = 0;
    while (size >= 1024 && index < 9) {
        size /= 1024.0;
        ++index;
    }
    NSString* str = @"B";
    switch (index) {
        case 0:
            str = @"B";
            break;
        case 1:
            str = @"KB";
            break;
        case 2:
            str = @"MB";
            break;
        case 3:
            str = @"GB";
            break;
        case 4:
            str = @"TB";
            break;
        case 5:
            str = @"PB";
            break;
        case 6:
            str = @"EB";
            break;
        case 7:
            str = @"ZB";
            break;
        case 8:
            str = @"YB";
            break;
        default:
            break;
    }
    return [[NSString alloc] initWithFormat:@"%0.2f%@",size,str];
}

-(NSArray*)getFlowinfoArr:(NSArray*)flowinfoArr{
    NSMutableArray* muArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < flowinfoArr.count; ++i) {
        id addDic = [flowinfoArr objectAtIndex:i];
        if ([addDic isKindOfClass:[NSDictionary class]]) {
            id defvalue = [addDic objectForKey:@"defvalue"];
            if (defvalue != [NSNull null]) {
                [muArr addObject:addDic];
            }
        }
    }
    return muArr;
}

-(NSArray*)getRemarkArrByHsstr:(NSString*)string{
    return [string componentsSeparatedByString:@"</br>"];
}

-(UIColor*)getRemarkyColorHsstr:(NSString*)string{
    //同意，批准，否决，提交
//    UIColor* color = KCorolTextLGray;
    UIColor* color = KCorolBackViewBluePro;
    if ([string rangeOfString:@"同意"].location != NSNotFound ||
        [string rangeOfString:@"批准"].location != NSNotFound) {
        color = KCorolBackViewGreenPro;
    }else if ([string rangeOfString:@"否决"].location != NSNotFound){
        color = KCorolBackViewRedPro;
    }
    return color;
}

-(UIColor*)getProcessColorHsstr:(NSString*)string{
    //审批，投票，会签，协作
    UIColor* color = KCorolTextLBlue;
    if ([string rangeOfString:@"审批"].location != NSNotFound){
        color = KCorolBackViewGreenPro;
    }else if ([string rangeOfString:@"投票"].location != NSNotFound){
        color = KCorolBackViewBluePro;
    }else if ([string rangeOfString:@"会签"].location != NSNotFound){
        color = KCorolBackViewYellowPro;
    }else if ([string rangeOfString:@"协作"].location != NSNotFound){
        color = KCorolBackViewBrownPro;
    }
    return color;
}

-(UIImage*)getNewsIconHsint:(int)code{
    UIImage* img;
    if (code == 0) {//系统通知图标
        img = [[HSUtils sharedUtils] getImageNamed:@"square_02.png"];
    }else if (code == 1){//待办消息图标
        img = [[HSUtils sharedUtils] getImageNamed:@"square_01.png"];
    }
    return img;
}

- (BOOL)stringIsValidRequestStr:(NSString*)checkString{
    BOOL bl = YES;
    NSArray *arr = [checkString componentsSeparatedByString:@"="];
    if (arr && arr.count == 2) {
        for (NSString* str in arr) {
            if (!(str.length > 0)) {
                bl = NO;
                break;
            }
        }
    }else{
        bl = NO;
    }
    return bl;
}

@end
