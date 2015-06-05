//
//  HSPickerView.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/12.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HSPickerViewDelegate <NSObject>
@optional
-(void)pickerViewClick:(NSArray*)array index:(int)index;

@end

@interface HSPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic, strong)UIPickerView* pickerView;
@property(nonatomic, strong)NSArray* pickerArr;
@property(nonatomic, weak) id<HSPickerViewDelegate> delegate;

+(HSPickerView *)sharePickerView;
-(void)show:(BOOL)animate;
-(void)close:(BOOL)animate;

@end
