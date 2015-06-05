//
//  HSTableViewCellBase.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/25.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSTableViewCellBase.h"

@interface HSTableViewCellBase(){
    float width;
    UILabel* titleLab;
    UILabel* detailLab;
    UILabel* dateLab;
}
@end

@implementation HSTableViewCellBase
@synthesize spacTop,spacBottom,spacLeft,spacRight,spacLabmiddle;
@synthesize cellBackView,topLineView,bottomLineView;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellWidth = self.contentView.frame.size.width;
        _cellHeight = self.contentView.frame.size.height;
        spacTop = KMiddleOFF/2;
        spacBottom = KMiddleOFF;
        spacLeft = 0;
        spacRight = 0;
        spacLabmiddle = -4;
        
        if (cellBackView == nil) {
            cellBackView = [[UIView alloc] initWithFrame:CGRectMake(spacLeft, spacTop, _cellWidth - spacLeft - spacRight, _cellHeight - spacTop - spacBottom)];
            [self.contentView addSubview:cellBackView];
            [self addLineView];
        }
        
        width = (cellBackView.frame.size.width - 2* KBoundaryOFF);
        [self addCellView];
    }
    return self;
}

-(void)setCellWidth:(float)cellWidth{
    _cellWidth = cellWidth;
    cellBackView = [[UIView alloc] initWithFrame:CGRectMake(spacLeft, spacTop, _cellWidth - spacLeft - spacRight, _cellHeight - spacTop - spacBottom)];
}

-(void)setBackViewCorlor:(UIColor*)color{
    [self.contentView setBackgroundColor:color];
}

-(void)setCellBackViewCorlor:(UIColor*)color{
    [cellBackView setBackgroundColor:color];
}

-(void)addCellView{
    float h = [self setCellView];
    cellBackView = [[UIView alloc] initWithFrame:CGRectMake(spacLeft, spacTop, _cellWidth - spacLeft - spacRight, h)];
    [self addLineView];
}

-(void)layoutData{
    float h = [self setCellView];
    cellBackView = [[UIView alloc] initWithFrame:CGRectMake(spacLeft, spacTop, _cellWidth - spacLeft - spacRight, h)];
    _cellHeight = h + spacTop + spacBottom;
    [self addLineView];
}

-(float)setCellView{
    float h = [self addTitleLab:0.0f];
    h += [self addDetailLab:h];
    h += [self addDateLab:h];
    return h;
}

-(float)addTitleLab:(float)off_y{
    float h = KMiddleOFF;//标题和topLineView保持间距
    //标题
    if (titleLab == nil) {
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF, h + off_y, width, KLabelMHeight)];
        titleLab.lineBreakMode = 0;
        titleLab.numberOfLines = 0;
        titleLab.font = [UIFont systemFontOfSize:19];
        [cellBackView addSubview:titleLab];
    }
    float titleLabWidth = titleLab.frame.size.width;
    _titleStr = _titleStr == nil ? @"" : _titleStr;
    CGRect rect = [_titleStr boundingRectWithSize:CGSizeMake(titleLabWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:titleLab.font} context:nil];
    float titleLabHeight = rect.size.height + 5;
    if (titleLabHeight < KLabelMHeight) {
        titleLabHeight = KLabelMHeight;
    }
    titleLab.frame = CGRectMake(KBoundaryOFF, h + off_y, width, titleLabHeight);
    titleLab.text = _titleStr;
    h += titleLab.frame.size.height + spacLabmiddle;
    return h;
}

-(float)addDetailLab:(float)off_y{
    float h = 0;
    if (detailLab == nil) {
        detailLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF, h + off_y, width, KLabelMHeight)];
        detailLab.lineBreakMode = 0;
        detailLab.numberOfLines = 0;
        detailLab.font = [UIFont systemFontOfSize:16];
        [cellBackView addSubview:detailLab];
    }
    
    float detailsLabWidth = detailLab.frame.size.width;
    _detailStr = _detailStr == nil ? @"" : _detailStr;
    
    CGRect rect = [_detailStr boundingRectWithSize:CGSizeMake(detailsLabWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:detailLab.font} context:nil];
    float detailsLabHeight = rect.size.height + 5;
    if (detailsLabHeight < KLabelMHeight) {
        detailsLabHeight = KLabelMHeight;
    }
    detailLab.frame = CGRectMake(KBoundaryOFF, h + off_y, width, detailsLabHeight);
    detailLab.text = _detailStr;
    h += detailLab.frame.size.height + spacLabmiddle;
    return h;
}

-(float)addDateLab:(float)off_y{
    float h = 0;
    if (dateLab == nil) {
        dateLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF, h + off_y, width, KLabelSHeight)];
        dateLab.lineBreakMode = 0;
        dateLab.numberOfLines = 0;
        dateLab.textColor = [UIColor grayColor];
        dateLab.font = [UIFont systemFontOfSize:16];
        [cellBackView addSubview:dateLab];
    }
    
    float dateLabWidth = dateLab.frame.size.width;
    _dateStr = _dateStr == nil ? @"" : _dateStr;
    
    CGRect rect = [_dateStr boundingRectWithSize:CGSizeMake(dateLabWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:dateLab.font} context:nil];
    float dateLabHeight = rect.size.height + 5;
    if (dateLabHeight < KLabelSHeight) {
        dateLabHeight = KLabelSHeight;
    }
    dateLab.frame = CGRectMake(KBoundaryOFF, h + off_y, width, dateLabHeight);
    dateLab.text = _titleStr;
    h += dateLab.frame.size.height;
    return h;
}

-(void)addLineView{
    float height = cellBackView.frame.size.height;
    //添加顶线
    if (spacTop > 0) {
        CGRect leftlineRect= CGRectMake(0, 0, cellBackView.frame.size.width , 1);
        if (topLineView == nil) {
            topLineView = [HSUtils drawLine:cellBackView type:HSRealizationLine rect:leftlineRect color:KCorolTextLGray];
        }
        topLineView.frame = leftlineRect;
    }else{
        [topLineView removeFromSuperview];
        topLineView = nil;
    }
    //添加底线
    CGRect bottomlineRect= CGRectMake(0, height - 1, cellBackView.frame.size.width , 1);
    if (bottomLineView == nil) {
        bottomLineView = [HSUtils drawLine:cellBackView type:HSRealizationLine rect:bottomlineRect color:KCorolTextLGray];
    }
    bottomLineView.frame = bottomlineRect;
}

-(float)getCellViewHeight{
    return _cellHeight;
}

@end
