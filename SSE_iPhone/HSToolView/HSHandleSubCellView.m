//
//  HSHandleSubCellView.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/12.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSHandleSubCellView.h"
#import "HSConfig.h"
#import "HSUtils.h"
#import "HSPickerView.h"
#import "HSModel.h"

#define KLabelWidth                 (70)
#define KLabelHeight                (35)
#define KLabelMHeight               (40)
#define KTextViewHeight             (100)

@interface HSHandleSubCellView()<HSPickerViewDelegate>{
    HSSubCellType  _subCellType;
    float subCellHeight;
    
    //HSSubCellCommonLanguageType相关
    UIButton* ommonlanBtn;
    UITextView *opinionTextView;
    
    //HSSubCellTreatmentChoiceType相关
    UIButton* treatmentChoiceBtn;
}

@end

@implementation HSHandleSubCellView

-(id)init{
    self = [super init];
    if (self) {
        _subCellType = -1;
        _subCellWidth = KScreenWidth;
    }
    return self;
}

-(id)initWithHandleSubCell:(HSSubCellType)subCellType{
    self = [super init];
    if (self) {
        _subCellType = subCellType;
        [self setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
        [self getHandleSubCell:subCellType];
    }
    return self;
}

#pragma mark set
-(void)setSubCellWidth:(float)subCellWidth{
    if (_subCellWidth != subCellWidth) {
        _subCellWidth = subCellWidth;
        [self getHandleSubCell:_subCellType];
    }
}

-(void)setPickerArr:(NSArray *)pickerArr{
    _pickerArr = pickerArr;
}

-(void)setCommonLanguageOpinion:(NSString*)string{
    if (string) {
        [ommonlanBtn setTitle:string forState:UIControlStateNormal];
    }
}

-(void)setCommonLanguageOpiTextView:(NSString*)string{
    opinionTextView.text = string;
}

-(void)setTreatmentChoice:(NSString*)string{
    if (string) {
        [treatmentChoiceBtn setTitle:string forState:UIControlStateNormal];
    }
    
}

#pragma mark get Height
-(float)getSubCellHeight{
    return subCellHeight;
}

-(float)getSubCellHeight:(HSSubCellType)subCellType{
    float height = KBottomTabBarHeight;
    switch (subCellType) {
        case HSSubCellCommonLanguageType:
            height = KTextViewHeight + KLabelHeight + 1;
        break;
        case HSSubCellTreatmentChoiceType:
            height = KLabelHeight + KLabelMHeight;
        break;
        case HSSubCellSubmitType:
            height = KBottomTabBarHeight;
        break;
        default:
        break;
    }
    return height;

}

-(void)getHandleSubCell:(HSSubCellType)subCellType{
    NSArray* subviews = [self subviews];
    for (UIView* subview in subviews) {
        [subview removeFromSuperview];
    }
    _subCellType = subCellType;
    switch (_subCellType) {
        case HSSubCellCommonLanguageType:
            [self initSubCellViewCommonLanguage];
            break;
        case HSSubCellTreatmentChoiceType:
            [self initSubCellViewTreatmentChoice];
            break;
        case HSSubCellSubmitType:
            [self initSubCellViewSubmit];
            break;
        default:
            break;
    }
}

#pragma mark init
-(void)initSubCellViewCommonLanguage{
    UILabel* ommonlanLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF, 0, KLabelWidth, KLabelHeight)];
    ommonlanLab.text = @"常用语: ";
    ommonlanLab.font = [UIFont systemFontOfSize:15];
    ommonlanLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:ommonlanLab];
    ommonlanBtn = [[UIButton alloc] initWithFrame:CGRectMake(KBoundaryOFF + KLabelWidth + KMiddleOFF + 1, 0, _subCellWidth -KLabelWidth- 2*KBoundaryOFF - KMiddleOFF - 1, KLabelHeight)];
    [ommonlanBtn setTitle:@"" forState:UIControlStateNormal];
    ommonlanBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    ommonlanBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [ommonlanBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [ommonlanBtn addTarget:self action:@selector(omlBtnclicked:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:ommonlanBtn];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[[HSUtils sharedUtils] getImageNamed:@"icon_arrow_under.png"]];
    imgView.center = CGPointMake(ommonlanBtn.frame.size.width - KBoundaryOFF, ommonlanBtn.frame.size.height/2.0);
    [ommonlanBtn addSubview:imgView];
    
    UILabel* opinionLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF, KLabelHeight + 1, KLabelWidth, KTextViewHeight)];
    opinionLab.text = @"审批意见: ";
    opinionLab.textAlignment = NSTextAlignmentRight;
    opinionLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:opinionLab];
    
    opinionTextView = [[UITextView alloc] initWithFrame:CGRectMake(KBoundaryOFF + KLabelWidth + KMiddleOFF+ 1, KLabelHeight + 1,_subCellWidth - 2*KBoundaryOFF - KMiddleOFF - 1, KTextViewHeight)];
    opinionTextView.backgroundColor = [UIColor clearColor];
    opinionTextView.font = [UIFont systemFontOfSize:17];
    [self addSubview:opinionTextView];
    
    CGRect rect1 = CGRectMake(KBoundaryOFF + KLabelWidth + KMiddleOFF, 0, 1, KTextViewHeight + KLabelHeight + 1);
    [HSUtils drawLine:self type:HSRealizationLine rect:rect1 color:KCorolTextLLGray];
    CGRect rect2 = CGRectMake(0, KLabelHeight, _subCellWidth, 1);
    [HSUtils drawLine:self type:HSRealizationLine rect:rect2 color:KCorolTextLLGray];
    subCellHeight =  KTextViewHeight + KLabelHeight + 1;
}

-(void)initSubCellViewTreatmentChoice{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF + 5, 0, _subCellWidth - 2*KBoundaryOFF - 5, KLabelHeight)];
    label.text = @"请选择后续节点处理人";
    label.font = [UIFont systemFontOfSize:15];
    [self addSubview:label];
    
    treatmentChoiceBtn = [[UIButton alloc] initWithFrame:CGRectMake(KBoundaryOFF, KLabelHeight - 5, _subCellWidth - 2*KBoundaryOFF , KLabelMHeight)];
    [treatmentChoiceBtn setBackgroundColor:[UIColor whiteColor]];
    treatmentChoiceBtn.clipsToBounds = YES;
    treatmentChoiceBtn.layer.cornerRadius = 5;
    treatmentChoiceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    treatmentChoiceBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [treatmentChoiceBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [treatmentChoiceBtn setTitle:@"" forState:UIControlStateNormal];
    treatmentChoiceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [treatmentChoiceBtn addTarget:self action:@selector(tcBtnclicked:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:treatmentChoiceBtn];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[[HSUtils sharedUtils] getImageNamed:@"icon_arrow_right.png"]];
    imgView.center = CGPointMake(treatmentChoiceBtn.frame.size.width - KBoundaryOFF, treatmentChoiceBtn.frame.size.height/2.0);
    [treatmentChoiceBtn addSubview:imgView];
    
    subCellHeight = KLabelHeight + KLabelMHeight;
    
}

-(void)initSubCellViewSubmit{
    UIButton* submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, _subCellWidth , KBottomTabBarHeight)];
    [submitBtn addTarget:self action:@selector(submitBtnclicked:) forControlEvents:UIControlEventTouchDown];
    [submitBtn setBackgroundColor:[UIColor orangeColor]];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    submitBtn.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:submitBtn];
    subCellHeight = KBottomTabBarHeight;
}

#pragma mark btn click
-(void)omlBtnclicked:(id)sender{
    HSPickerView* pickerView = [HSPickerView sharePickerView];
    pickerView.pickerArr =  _pickerArr;
    pickerView.delegate = self;
    [pickerView show:YES];
}

-(void)tcBtnclicked:(id)sender{
    [self.delegate handleSubCellViewMessage:HSSubCellTreatmentChoiceType principalValue:treatmentChoiceBtn.titleLabel.text auxiliaryValue:nil];
}

-(void)submitBtnclicked:(id)sender{
    [self.delegate handleSubCellViewMessage:HSSubCellSubmitType principalValue:nil auxiliaryValue:nil];
}

#pragma mark pickerview function
-(void)pickerViewClick:(NSArray *)array index:(int)index{
    NSString* str = [array objectAtIndex:index];
    [ommonlanBtn setTitle:str forState:UIControlStateNormal];
    opinionTextView.text = str;
    [self.delegate handleSubCellViewMessage:HSSubCellCommonLanguageType principalValue:str auxiliaryValue:nil];
}

@end
