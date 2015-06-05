//
//  HSHandleSubCellView.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/12.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HSSubCellCommonLanguageType = 0,        //常用语
    HSSubCellTreatmentChoiceType,           //处理人选择
    HSSubCellSubmitType,                    //提交
} HSSubCellType;

@protocol HSHandleSubCellViewDelegate <NSObject>
@optional
-(void)handleSubCellViewMessage:(HSSubCellType)subCellType principalValue:(NSString*)principalValue auxiliaryValue:(NSString*)auxiliaryValue;

@end

@interface HSHandleSubCellView : UIView

@property(nonatomic, assign)float subCellWidth;
@property(nonatomic, strong)NSArray* pickerArr;
@property(nonatomic, weak) id<HSHandleSubCellViewDelegate> delegate;

-(id)initWithHandleSubCell:(HSSubCellType)subCellType;

-(float)getSubCellHeight;
-(float)getSubCellHeight:(HSSubCellType)subCellType;

//设置方法
//HSSubCellCommonLanguageType
-(void)setCommonLanguageOpinion:(NSString*)string;
-(void)setCommonLanguageOpiTextView:(NSString*)string;
//HSSubCellTreatmentChoiceType
-(void)setTreatmentChoice:(NSString*)string;
//HSSubCellSubmitType


@end
