//
//  HSTodoCell.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/25.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#define KImgWidth           (48)
#define KImgHeight          (60)

#import "HSTodoCell.h"


@interface HSTodoCell(){
    float width;
    UILabel* titleLab;
    UILabel* detailLab;
    UILabel* dateLab;
    UILabel* processTypeLab;
    
    float imgWidth;
    float off_x;
}
@end

@implementation HSTodoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imgWidth = KImgWidth;
        off_x = 2*KBoundaryOFF + imgWidth;
        width = self.cellBackView.frame.size.width - 3* KBoundaryOFF - imgWidth;
        _processBackColor = KCorolBackViewGreenPro;
    }
    return self;
}


-(float)setCellView{
    float h = [self addTitleLab:0.0f];
    h += [self addDetailLab:h];
    h += [self addDateLab:h];
    [self addProcessTypeLab:KMiddleOFF];
    [self addLineView];
    return h;
}

-(float)addTitleLab:(float)off_y{
    float h = KMiddleOFF;//标题和topLineView保持间距
    //标题
    if (titleLab == nil) {
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(off_x, h + off_y + 1, width, KLabelMHeight)];
        titleLab.lineBreakMode = 0;
        titleLab.numberOfLines = 0;
        titleLab.font = [UIFont systemFontOfSize:16];
        [self.cellBackView addSubview:titleLab];
    }
    self.titleStr = self.titleStr == nil ? @"" : self.titleStr;
    CGRect rect = [self.titleStr boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:titleLab.font} context:nil];
    float titleLabHeight = rect.size.height + 5;
    if (titleLabHeight < KLabelMHeight) {
        titleLabHeight = KLabelMHeight;
    }
    titleLab.frame = CGRectMake(off_x, h + off_y, width, titleLabHeight);
    titleLab.text = self.titleStr;
    h += titleLab.frame.size.height + self.spacLabmiddle;
    return h;
}

-(float)addDetailLab:(float)off_y{
    float h = 0;
    if (detailLab == nil) {
        detailLab = [[UILabel alloc] initWithFrame:CGRectMake(off_x, h + off_y , width, KLabelMHeight)];
        detailLab.lineBreakMode = 0;
        detailLab.numberOfLines = 0;
        detailLab.font = [UIFont systemFontOfSize:14];
        [self.cellBackView addSubview:detailLab];
    }
    
    self.detailStr = self.detailStr == nil ? @"" : self.detailStr;
    CGRect rect = [self.detailStr boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:detailLab.font} context:nil];
    float detailsLabHeight = rect.size.height + 5;
    if (detailsLabHeight < KLabelMHeight) {
        detailsLabHeight = KLabelMHeight;
    }
    detailLab.frame = CGRectMake(off_x, h + off_y, width, detailsLabHeight);
    detailLab.text = self.detailStr;
    h += detailLab.frame.size.height + self.spacLabmiddle;
    return h;
}

-(float)addDateLab:(float)off_y{
    float h = 0;
    if (dateLab == nil) {
        dateLab = [[UILabel alloc] initWithFrame:CGRectMake(off_x, h + off_y - 1, width, KLabelSHeight)];
        dateLab.lineBreakMode = 0;
        dateLab.numberOfLines = 0;
        dateLab.textColor = [UIColor grayColor];
        dateLab.font = [UIFont systemFontOfSize:14];
        [self.cellBackView addSubview:dateLab];
    }
    self.dateStr = self.dateStr == nil ? @"" : self.dateStr;
    
    CGRect rect = [self.dateStr boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:dateLab.font} context:nil];
    float dateLabHeight = rect.size.height + 5;
    if (dateLabHeight < KLabelSHeight) {
        dateLabHeight = KLabelSHeight;
    }
    dateLab.frame = CGRectMake(off_x, h + off_y - 5, width, dateLabHeight);
    dateLab.text = self.dateStr ;
    h += dateLab.frame.size.height;
    return h;
}

-(void)addProcessTypeLab:(float)off_y{
    float h = KMiddleOFF;
    if (_processBackView == nil || processTypeLab == nil) {
        _processBackView = [[UIView alloc] initWithFrame:CGRectMake(0, h + off_y, imgWidth, KImgHeight)];
        [self.cellBackView addSubview:_processBackView];
        
        processTypeLab = [[UILabel alloc] initWithFrame:_processBackView.bounds];
        processTypeLab.numberOfLines=0;
        processTypeLab.font = [UIFont boldSystemFontOfSize:16];
        processTypeLab.textColor = [UIColor whiteColor];
        processTypeLab.textAlignment = NSTextAlignmentCenter;
        [_processBackView addSubview:processTypeLab];
    }
    _processBackView.frame = CGRectMake(0, h + off_y, imgWidth, KImgHeight);
    [_processBackView setBackgroundColor:_processBackColor];
    CGRect rect = [@"审" boundingRectWithSize:CGSizeMake(imgWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:processTypeLab.font} context:nil];
    float lab_h = rect.size.height;
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    _processTypeStr = _processTypeStr == nil ? @"" : _processTypeStr;
    NSString *title = [_processTypeStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    for (int i = 0; title && i < title.length ; i++) {
        NSString *str1 = [title substringWithRange:NSMakeRange(i, 1)];
        NSString *str2 = [str1 stringByAppendingString:@"\n"];
        [arr addObject:str2];
    }
    NSString *str3;
    for (int i = 0;arr.count > 0 && i<arr.count - 1; i++) {
        if (i == 0) {
            str3 = [arr[i] stringByAppendingString:arr[i+1]];
        }else{
            str3 = [str3 stringByAppendingString:arr[i+1]];
        }
    }
    processTypeLab.frame = CGRectMake(0, (KImgHeight - lab_h* arr.count)/2 - 2, imgWidth, KImgHeight);
    processTypeLab.text = str3;
    
}

-(void)addLineView{
    float height = self.cellBackView.frame.size.height;
    //添加底线
    CGRect bottomlineRect= CGRectMake(0, height - 1, self.cellBackView.frame.size.width , 1);
    if (self.bottomLineView == nil) {
        self.bottomLineView = [HSUtils drawLine:self.cellBackView type:HSRealizationLine rect:bottomlineRect color:KCorolTextLGray];
    }
    self.bottomLineView.frame = bottomlineRect;
}

-(void)setProcessBackColor:(UIColor *)processBackColor{
    if (processBackColor && _processBackColor != processBackColor) {
        _processBackColor = processBackColor;
        [_processBackView setBackgroundColor:_processBackColor];
    }
}

-(void)setProcessTypeStr:(NSString *)processTypeStr{
    _processTypeStr = processTypeStr;
    if (processTypeStr) {
        imgWidth = KImgWidth;
        off_x = 2*KBoundaryOFF + imgWidth;
        width = self.cellBackView.frame.size.width - 3* KBoundaryOFF - imgWidth;
        [self setCellView];
    }else{
        imgWidth = 0;
        off_x = KBoundaryOFF + imgWidth;
        width = self.cellBackView.frame.size.width - 2* KBoundaryOFF - imgWidth;
        [self setCellView];
    }
}

@end
