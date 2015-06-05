//
//  HSHistoryTableViewCell.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/2.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSHistoryTableViewCell.h"
#import "HSUtils.h"
#import "HSModel.h"

#define KLabelMHeight       (30)
#define KLabelSHeight       (28)
#define KiconImgWH          (28)
#define KiconNameImgWH      (20)
#define KProportion         (0.4)


@interface HSHistoryTableViewCell(){
    UIView* cellBackView;
    UILabel* titleLab;
    UILabel* nameLab;
    UILabel* dateLab;
    UILabel* opinionLab;//意见
    UIView* triangleView;
    UILabel* explainLab;//说明
    UILabel* remarksLab;//备注
    
    
    UIImageView* iconImg;
    UIImageView* iconNameImg;
    UIView* leftLineView;
    UIView* middleLineView;
    UIView* bottomLineView;
    
    UIView* opinionbackView;
}
@end

@implementation HSHistoryTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellWidth = self.contentView.frame.size.width;
        _cellHeight = self.contentView.frame.size.height;
        _isExplain = NO;
        _isRemarks = NO;
        [self addCellView];
    }
    return self;
}

-(void)addCellView{
    if (cellBackView == nil) {
        cellBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _cellWidth, _cellHeight)];
        [self.contentView addSubview:cellBackView];
    }
    cellBackView.frame = CGRectMake(0, 0, _cellWidth, _cellHeight);
    //左边的线
    float cbWidth = cellBackView.frame.size.width;
    float cbHeight = cellBackView.frame.size.height;
    CGRect leftlineRect= CGRectMake(KBoundaryOFF*2, 0, 1, cbHeight);
    if (leftLineView == nil) {
        leftLineView = [HSUtils drawLine:cellBackView type:HSRealizationLine rect:leftlineRect color:KCorolTextLGray];
    }
    leftLineView.frame = leftlineRect;
    
    float h = 1.5 * KBoundaryOFF;
    //图标KLabelMHeight(固定)
    if (iconImg == nil) {
        UIImage* img = [[HSUtils sharedUtils] getImageNamed:@"conf_02.png"];
        iconImg = [[UIImageView alloc] initWithImage:img];
        iconImg.center = CGPointMake( KBoundaryOFF*2, KBoundaryOFF + KMiddleOFF + img.size.height/2);
        [cellBackView addSubview:iconImg];
    }
    //标题
    float x_off = 2*KBoundaryOFF + KiconImgWH;
    if (titleLab == nil) {
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(x_off, KBoundaryOFF, cbWidth - x_off - KBoundaryOFF, KLabelMHeight)];
        titleLab.lineBreakMode = 0;
        titleLab.numberOfLines = 0;
        titleLab.font = [UIFont boldSystemFontOfSize:18];
        [cellBackView addSubview:titleLab];
    }
    float titleLabWidth = titleLab.frame.size.width;
    CGRect rect = [_titleLabText boundingRectWithSize:CGSizeMake(titleLabWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:titleLab.font} context:nil];
    float titleLabHeight = rect.size.height + 5;
    if (titleLabHeight < KLabelMHeight) {
        titleLabHeight = KLabelMHeight;
    }
    titleLab.frame = CGRectMake(x_off, KBoundaryOFF, cbWidth - x_off - KBoundaryOFF, titleLabHeight);
    titleLab.text = _titleLabText;
    h += titleLab.frame.size.height;
    
    //人物图标
    float offw = KBoundaryOFF*2 + KiconImgWH;
    UIImage* img = [[HSUtils sharedUtils] getImageNamed:@"icongray_02.png"];
    if (iconNameImg == nil) {
        iconNameImg = [[UIImageView alloc] initWithImage:img];
        
        iconNameImg.center  = CGPointMake(KBoundaryOFF*2 + KiconImgWH , h + KLabelSHeight/2.0);
        [cellBackView addSubview:iconNameImg];
    }
    iconNameImg.center  = CGPointMake(KBoundaryOFF*2 + KiconImgWH + img.size.width/2, h + KLabelSHeight/2.0 - KMiddleOFF);
    
    
    //处理人员、时间
    float w = (cbWidth - KBoundaryOFF*3 - KiconImgWH);
    float mameAddDateW = (cbWidth - KBoundaryOFF*4 - KiconImgWH - KiconNameImgWH);
    offw += KiconNameImgWH + KMiddleOFF;
    if (nameLab == nil && dateLab == nil) {
        nameLab = [[UILabel alloc] initWithFrame:CGRectMake(offw, h - 5, mameAddDateW*KProportion, KLabelSHeight)];
        dateLab = [[UILabel alloc] initWithFrame:CGRectMake(offw + mameAddDateW*KProportion, h - 5, mameAddDateW*(1- KProportion), KLabelSHeight)];
        nameLab.font = [UIFont systemFontOfSize:16];
        dateLab.font = [UIFont systemFontOfSize:13];
        nameLab.textColor = [UIColor grayColor];
        dateLab.textColor = [UIColor lightGrayColor];
        dateLab.textAlignment = NSTextAlignmentRight;
        [cellBackView addSubview:nameLab];
        [cellBackView addSubview:dateLab];
    }
    nameLab.frame = CGRectMake(offw, h - 5, mameAddDateW*KProportion, KLabelSHeight);
    dateLab.frame = CGRectMake(offw + mameAddDateW*KProportion, h - 5, mameAddDateW*(1- KProportion), KLabelSHeight);
    nameLab.text = _nameLabText;
    dateLab.text = _dateLabText;
    h += nameLab.frame.size.height;
    
    //意见背景
    if (opinionbackView == nil) {
        opinionbackView = [[UIView alloc] initWithFrame:CGRectMake(KBoundaryOFF*2 + KiconImgWH, h, w, KLabelSHeight)];
        [opinionbackView setBackgroundColor:KCorolBackViewRed];
        opinionbackView.layer.masksToBounds = YES;
        opinionbackView.layer.cornerRadius = 2.0;
        [cellBackView addSubview:opinionbackView];
    }
    //意见
    if (opinionLab == nil) {
        opinionLab = [[UILabel alloc] initWithFrame:CGRectMake(KMiddleOFF, 0, w, KLabelSHeight)];
        opinionLab.textColor = [UIColor whiteColor];
        //        CGRect initialFrame = CGRectMake(0, 0, 100, 100);
        //        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        //        CGRect paddedFrame = UIEdgeInsetsInsetRect(initialFrame, contentInsets);
        //
        //        self.label = [[UILabel alloc] initWithFrame:paddedFrame];
        opinionLab.lineBreakMode = 0;
        opinionLab.numberOfLines = 0;
        opinionLab.font = [UIFont boldSystemFontOfSize:15];
        [opinionbackView addSubview:opinionLab];
    }
    opinionLab.text = _opinionLabText;
    
    if (_opinionLabText && _opinionLabText.length > 0) {
        //说明
        float opi_W = w;
        float opi_h = KLabelSHeight;
        float opi_H = KLabelSHeight;
        
        NSString* opitext = _opinionLabText;
        if ([_opinionLabText rangeOfString:@"\r\n"].location != NSNotFound) {
            opitext = [_opinionLabText stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        }
        CGRect rectS = [opitext boundingRectWithSize:CGSizeMake(MAXFLOAT, KLabelSHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:opinionLab.font} context:nil];
        CGRect rectOpiH = [_opinionLabText boundingRectWithSize:CGSizeMake(w - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:opinionLab.font} context:nil];
        
        if (_isExplain) {//存在说明
            if (explainLab == nil) {
                explainLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, opi_W, opi_h)];
                explainLab.lineBreakMode = 0;
                explainLab.numberOfLines = 0;
                explainLab.textColor = [UIColor whiteColor];
                explainLab.font = [UIFont boldSystemFontOfSize:15];
                [opinionbackView addSubview:explainLab];
            }
            explainLab.text = _explainLabText;
            CGRect rectw = [_explainLabText boundingRectWithSize:CGSizeMake(MAXFLOAT, KLabelSHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:explainLab.font} context:nil];
            if (rectw.size.width + KMiddleOFF + 16 > w) {
                CGRect recth = [_explainLabText boundingRectWithSize:CGSizeMake(w - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:explainLab.font} context:nil];
                if (recth.size.height + KMiddleOFF > KLabelSHeight) {
                    opi_H = recth.size.height + KMiddleOFF;
                }
            }else{
                if ( rectw.size.width + KMiddleOFF + 16  <  rectS.size.width + KMiddleOFF + 16) {
                    opi_W = rectS.size.width + KMiddleOFF + 16;
                }else{
                    opi_W = rectw.size.width + KMiddleOFF + 16;
                }
            }
            
            if (rectOpiH.size.height+ KMiddleOFF > opi_h) {
                opi_h = rectOpiH.size.height+ KMiddleOFF;
            }
            opi_W = opi_W > w ? w : opi_W;
            
            CGRect initialFrame = CGRectMake(KMiddleOFF, 0, opi_W - KMiddleOFF, opi_h);//CGRectMake(0, 0, 100, 100);
            UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 8, 0, 0);
            CGRect paddedFrame = UIEdgeInsetsInsetRect(initialFrame, contentInsets);
            opinionLab.frame = paddedFrame;//CGRectMake(KMiddleOFF, 0, opi_W - KMiddleOFF, opi_h);
            explainLab.frame = CGRectMake(KMiddleOFF, opi_h, opi_W - KMiddleOFF, opi_H);
            opinionbackView.frame = CGRectMake(KBoundaryOFF*2 + KiconImgWH, h, opi_W, opi_h + opi_H);
        }else{
            [explainLab removeFromSuperview];
            explainLab = nil;
            if (rectOpiH.size.height+ KMiddleOFF > opi_h) {
                opi_h = rectOpiH.size.height+ KMiddleOFF;
            }
            float opi_W = rectS.size.width + KMiddleOFF + 16;
            opi_W = opi_W > w ? w : opi_W;
            
            CGRect initialFrame = CGRectMake(0, 0, opi_W - KMiddleOFF, opi_h);//CGRectMake(0, 0, 100, 100);
            UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 8, 0, 0);
            CGRect paddedFrame = UIEdgeInsetsInsetRect(initialFrame, contentInsets);
            opinionLab.frame = paddedFrame;//CGRectMake(0, 0, opi_W - KMiddleOFF, opi_h);
            opinionbackView.frame = CGRectMake(KBoundaryOFF*2 + KiconImgWH, h, opi_W, opi_h);
        }
    }else{
        opinionbackView.frame = CGRectMake(KBoundaryOFF*2 + KiconImgWH, h, w, 0);
    }
    h += opinionbackView.frame.size.height;
    
    if (opinionbackView.frame.size.height > 0) {
        //添加向上的箭头。
        float ah =  h - opinionbackView.frame.size.height - 10 + 2;
        CGRect rect = CGRectMake(KBoundaryOFF*2 + KiconImgWH+KMiddleOFF + 2, ah, 10, 10);
        if (triangleView) {
            [triangleView removeFromSuperview];
        }
        triangleView =  [HSUtils drawTriangle1:cellBackView rect:rect color:opinionbackView.backgroundColor];
    }else{
        [triangleView removeFromSuperview];
    }
    
    if (_isRemarks) {// 存在备注
        h += KMiddleOFF;
        //中间线
        CGRect middlelineRect= CGRectMake(KBoundaryOFF*3, h, cbWidth - 3*KBoundaryOFF, 1);
        if (middleLineView == nil) {
            middleLineView = [HSUtils drawLine:cellBackView type:HSDottedLine rect:middlelineRect color:KCorolTextLGray];
        }
        middleLineView.frame = middlelineRect;
        h += middleLineView.frame.size.height;
        
        //备注
        if (remarksLab == nil) {
            remarksLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF*2 + KiconImgWH, h, w, KLabelSHeight)];
            remarksLab.font = [UIFont boldSystemFontOfSize:13];
            remarksLab.textColor = [UIColor lightGrayColor];
            remarksLab.lineBreakMode = 0;
            remarksLab.numberOfLines = 0;
            [cellBackView addSubview:remarksLab];
        }
        remarksLab.text = _remarksLabText;
        CGRect recth = [_remarksLabText boundingRectWithSize:CGSizeMake(w, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:remarksLab.font} context:nil];
        if (recth.size.height + KMiddleOFF > KLabelSHeight) {
            remarksLab.frame = CGRectMake(KBoundaryOFF*2 + KiconImgWH, h, w, recth.size.height + KMiddleOFF);
        }else{
            remarksLab.frame = CGRectMake(KBoundaryOFF*2 + KiconImgWH, h, w, KLabelSHeight);
        }
        h += remarksLab.frame.size.height;
    }else{
        [middleLineView removeFromSuperview];
        [remarksLab removeFromSuperview];
        middleLineView = nil;
        remarksLab = nil;
    }
    
    h += 2*KMiddleOFF;
    //底线
    CGRect bottomlineRect= CGRectMake(KBoundaryOFF*2, h, cbWidth - 2*KBoundaryOFF, 1);
    if (bottomLineView == nil) {
        bottomLineView = [HSUtils drawLine:cellBackView type:HSRealizationLine rect:bottomlineRect color:KCorolTextLGray];
    }
    bottomLineView.frame = bottomlineRect;
    
    leftLineView.frame = CGRectMake(KBoundaryOFF*2, 0, 1, h);
    cellBackView.frame = CGRectMake(0, 0, cbWidth, h + 1);
    
    _cellHeight = h + 1;
}

-(void)setCellWidth:(float)cellWidth{
    _cellWidth = cellWidth;
}

-(void)setCellHeight:(float)cellHeight{
    _cellHeight = cellHeight;
}

-(void)setIsExplain:(BOOL)isExplain{
    _isExplain = isExplain;
}

-(void)setIsRemarks:(BOOL)isRemarks{
    _isRemarks = isRemarks;
}

-(void)settitleLabText:(NSString*)titleLabText{
    _titleLabText = titleLabText;
}

-(void)setNameLabText:(NSString *)nameLabText{
    _nameLabText = nameLabText;
}

-(void)setDateLabText:(NSString *)dateLabText{
    _dateLabText = dateLabText;
}

-(void)setOpinionLabText:(NSString *)opinionLabText{
    _opinionLabText = opinionLabText;
}

-(void)setExplainLabText:(NSString *)explainLabText{
    _explainLabText = explainLabText;
}

-(void)setRemarksLabText:(NSString *)remarksLabText{
    _remarksLabText = remarksLabText;
}

-(void)synchronousCellView{
    [self addCellView];
}

-(void)setOpinionBackViewColor:(UIColor *)color{
    [opinionbackView setBackgroundColor:color];
}

-(float)getCellViewHeight{
    return _cellHeight;
}

@end
