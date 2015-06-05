//
//  HSDetailTableViewCell.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/18.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#define KLabelMHeight           (34)
#define KLabelSHeight           (30)
#define KImgWHeight             (60)
#define KImgProportion          (0.25)

#define KLabProportion          (0.26)


#import "HSDetailTableViewCell.h"
#import "HSConfig.h"
#import "HSUtils.h"

@interface HSDetailTableViewCell(){
    UIView* basicView;
    UIView* extendedView;
    
    UIView* topLineView;
    UIView* bottomLineView;
    
    UILabel* imgStateLabel;
}
@end

@implementation HSDetailTableViewCell
@synthesize titleLab,detailsLab,valueLab,imgView,middleOff,cellBackView;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellWidth = self.contentView.frame.size.width;
        _cellHeight = self.contentView.frame.size.height;
        middleOff = 2*KMiddleOFF;
        _isTitleLong = NO;
        _isLine = YES;
        if (cellBackView == nil) {
            cellBackView = [[UIView alloc] initWithFrame:CGRectMake(0, middleOff, _cellWidth, _cellHeight - middleOff)];
            [self.contentView addSubview:cellBackView];
        }
        float h = [self addCellTopView];
        [self addCellListView:h];
        [cellBackView setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

-(float)addCellTopView{
    cellBackView.frame = CGRectMake(0, middleOff, _cellWidth, _cellHeight - 2*middleOff);
    float cbWidth = (cellBackView.frame.size.width - 2* KBoundaryOFF)*(1- KImgProportion);
    //顶部的线
    if (middleOff > 0) {
        CGRect leftlineRect= CGRectMake(0, 0, cellBackView.frame.size.width , 1);
        if (topLineView == nil) {
            topLineView = [HSUtils drawLine:cellBackView type:HSRealizationLine rect:leftlineRect color:KCorolTextLGray];
        }
        topLineView.frame = leftlineRect;
    }
    if (!_isLine) {
        [topLineView removeFromSuperview];
    }
    float h = KMiddleOFF;
    //标题
    float titleWidth = _isTitleLong ? (cellBackView.frame.size.width - 2* KBoundaryOFF) : cbWidth;
    if (titleLab == nil) {
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF, h, titleWidth, KLabelMHeight)];
        titleLab.lineBreakMode = 0;
        titleLab.numberOfLines = 0;
        titleLab.font = [UIFont systemFontOfSize:17];
        [cellBackView addSubview:titleLab];
    }
    NSString* titleLabText = titleLab.text;
    titleLabText = titleLabText == nil ? @"" : titleLabText;
    CGRect rect = [titleLabText boundingRectWithSize:CGSizeMake(titleWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:titleLab.font} context:nil];
    float titleLabHeight = rect.size.height + 5;
    if (titleLabHeight < KLabelMHeight) {
        titleLabHeight = KLabelMHeight;
    }
    titleLab.frame = CGRectMake(KBoundaryOFF, KBoundaryOFF, titleWidth, titleLabHeight);
    
    h += titleLab.frame.size.height;
    
    //说明－拟发行金额(亿元)
    if (detailsLab == nil) {
        detailsLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF, h + 4, cbWidth, KLabelSHeight)];
        detailsLab.lineBreakMode = 0;
        detailsLab.numberOfLines = 0;
        detailsLab.font = [UIFont systemFontOfSize:14];
        [cellBackView addSubview:detailsLab];
    }
    
    float detailsLabWidth = detailsLab.frame.size.width;
    NSString* detailsLabText = detailsLab.text;
    detailsLabText = detailsLabText == nil ? @"" : detailsLabText;
    
    rect = [detailsLabText boundingRectWithSize:CGSizeMake(detailsLabWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:titleLab.font} context:nil];
    float detailsLabHeight = rect.size.height + 5;
    if (detailsLabHeight < KLabelMHeight) {
        detailsLabHeight = KLabelMHeight;
    }
    detailsLab.frame = CGRectMake(KBoundaryOFF, h + 4, cbWidth, detailsLabHeight);
    h += detailsLab.frame.size.height;
    
    //值
    float off = 10;
    h -= off;
    if (valueLab == nil) {
        valueLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF, h, cbWidth, KLabelMHeight)];
        valueLab.lineBreakMode = 0;
        valueLab.numberOfLines = 0;
        valueLab.font = [UIFont systemFontOfSize:17];
        [cellBackView addSubview:valueLab];
    }
    
    float valueLabWidth = valueLab.frame.size.width;
    NSString* valueLabLabText = valueLab.text;
    valueLabLabText = valueLabLabText == nil ? @"" : valueLabLabText;
    
    rect = [valueLabLabText boundingRectWithSize:CGSizeMake(valueLabWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:titleLab.font} context:nil];
    float valueLabHeight = rect.size.height + 5;
    if (valueLabHeight < KLabelMHeight) {
        valueLabHeight = KLabelMHeight;
    }
    valueLab.frame = CGRectMake(KBoundaryOFF, h, cbWidth, valueLabHeight);
    h += valueLab.frame.size.height;
    
    //图片
    float imgWidth = (cellBackView.frame.size.width - 2* KBoundaryOFF)*KImgProportion;
    float off_x = KBoundaryOFF + cbWidth + (imgWidth - KImgWHeight)/2.0;
    float off_y = (h - KImgWHeight)/2.0;
    if (imgView == nil) {
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(off_x, off_y, KImgWHeight, KImgWHeight)];
        [cellBackView addSubview:imgView];
    }
    [cellBackView bringSubviewToFront:imgView];
    CGSize size;
    if (imgView.image) {
        size = imgView.image.size;
        off_x = KBoundaryOFF + cbWidth + (imgWidth - size.width)/2.0;
        off_y = (h - size.height)/2.0;
        imgView.frame = CGRectMake(off_x, off_y, size.width, size.height);
    }else{
        size = imgView.frame.size;
        imgView.frame = CGRectMake(off_x, off_y, KImgWHeight, KImgWHeight);
    }
    
    //图片文本
    if (imgStateLabel == nil) {
        imgStateLabel = [[UILabel alloc] initWithFrame:imgView.bounds];
        imgStateLabel.font = [UIFont systemFontOfSize:12];
        imgStateLabel.textAlignment = NSTextAlignmentCenter;
        imgStateLabel.transform = CGAffineTransformMakeRotation(-30 * M_PI / 180.0);
        [imgView addSubview:imgStateLabel];
    }

    float staLabW = sqrt(size.width*size.width + size.height*size.height);
    float staLab_off_x = (size.width - staLabW)/2;
    imgStateLabel.frame = CGRectMake(staLab_off_x, (imgView.frame.size.height -20)/2, staLabW, 20);
    

    return h;
}

-(void)addCellListView:(float)off_h{
    if (_listArr == nil || _listArr.count < 1) {
        _cellHeight = off_h + 2*middleOff;
    }else{
        float cbWidth = (cellBackView.frame.size.width - 2* KBoundaryOFF);
        float listh = 0;
        for (int i = 0; i < _listArr.count; ++i) {
            NSDictionary* dic = [_listArr objectAtIndex:i];
            if (dic) {
                float itmeh = KLabelSHeight;
                NSString* keyStr = [dic objectForKey:@"keyStr"];
                NSString* dataStr = [dic objectForKey:@"dataStr"];
                if (keyStr) {
                    UILabel * keyLab = (UILabel*)[cellBackView viewWithTag:10000 + i];
                    if (keyLab == nil) {
                        keyLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF, off_h+listh, cbWidth*KLabProportion, KLabelSHeight)];
                        keyLab.tag = 10000 + i;
                        keyLab.textAlignment = NSTextAlignmentLeft;
                        keyLab.font = [UIFont systemFontOfSize:14];
                        keyLab.textColor = [UIColor grayColor];
                        
                    }
                    [cellBackView addSubview:keyLab];
                    keyLab.text = keyStr;
                    
                    
                    BOOL isLocation = NO;
                    if([dataStr rangeOfString:[HSDetailTableViewCell multiLineCode]].location != NSNotFound){
                        isLocation = YES;
                    } else {
                        isLocation = NO;
                    }
                    
                    if (isLocation) {
                        dataStr = [dataStr stringByReplacingOccurrencesOfString:[HSDetailTableViewCell multiLineCode] withString:@""];
                        NSArray* dataStrArr = [dataStr componentsSeparatedByString:@","];
                        itmeh = 6;//dataStrArr.count*(KLabelSHeight - 10);
                        for (int i = 0; i < dataStrArr.count; ++i) {
                            NSString* itmeStr = [dataStrArr objectAtIndex:i];
                            UILabel * itmeLab = (UILabel*)[cellBackView viewWithTag:13000 + i];
                            if (itmeLab == nil) {
                                itmeLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF + cbWidth*KLabProportion, off_h+listh + itmeh, cbWidth*(1 -KLabProportion), KLabelSHeight - 10)];
                                itmeLab.tag = 13000 + i;
                                itmeLab.numberOfLines = 2;
                                itmeLab.textAlignment = NSTextAlignmentRight;
                                itmeLab.font = [UIFont systemFontOfSize:14];
                                itmeLab.textColor = [UIColor grayColor];
                            }
                            itmeh += KLabelSHeight - 10;
                            [cellBackView addSubview:itmeLab];
                            itmeLab.text = itmeStr;
                        }
                        itmeh += 6;
                    }else{
                        UILabel * dataLab = (UILabel*)[cellBackView viewWithTag:11000 + i];
                        if (dataLab == nil) {
                            dataLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF + cbWidth*KLabProportion, off_h+listh, cbWidth*(1 -KLabProportion), KLabelSHeight)];
                            dataLab.tag = 11000 + i;
                            dataLab.numberOfLines = 2;
                            dataLab.textAlignment = NSTextAlignmentRight;
                            dataLab.font = [UIFont systemFontOfSize:14];
                            dataLab.textColor = [UIColor grayColor];
                        }
                        [cellBackView addSubview:dataLab];
                        dataLab.text = dataStr;
                    }
                    
                    listh += itmeh;
                    //虚线
                    if (i < _listArr.count- 1) {
                        UIView * lineView = (UIView*)[cellBackView viewWithTag:12000 + i];
                        CGRect lineRect= CGRectMake(KBoundaryOFF,  off_h + listh - 1, cbWidth, 1);
                        if (lineView == nil) {
                            lineView = [HSUtils drawLine:cellBackView type:HSDottedLine rect:lineRect color:KCorolTextLGray];
                            lineView.tag = 12000 + i;
                        }
                        [cellBackView addSubview:lineView];
                    }
                }
            }
        }
        _cellHeight = off_h + listh + 2*middleOff;
    }
   
    cellBackView.frame = CGRectMake(0, middleOff, _cellWidth, _cellHeight - 2*middleOff);
    //添加底线
    CGRect bottomlineRect= CGRectMake(0, cellBackView.frame.size.height - 1, cellBackView.frame.size.width , 1);
    if (bottomLineView == nil) {
        bottomLineView = [HSUtils drawLine:cellBackView type:HSRealizationLine rect:bottomlineRect color:KCorolTextLGray];
    }
    if (!_isLine) {
        [bottomLineView removeFromSuperview];
    }
    bottomLineView.frame = bottomlineRect;
}

//currentNodeStr
-(void)setCurrentNodeStr:(NSString *)currentNodeStr{
    float h = [self addCellTopView];
    if (currentNodeStr) {
        _currentNodeStr = currentNodeStr;
        NSArray* subviews = [cellBackView subviews];
        for (UIView * view in subviews) {
            if (view.tag >= 10000) {
                [view removeFromSuperview];
            }
        }
    
        UILabel * lab = (UILabel*)[cellBackView viewWithTag:12345];
        if (lab == nil) {
            float cbWidth = (cellBackView.frame.size.width - 2* KBoundaryOFF);
            lab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF, h, cbWidth, KLabelSHeight - KMiddleOFF)];
            lab.tag = 12345;
            lab.textAlignment = NSTextAlignmentLeft;
            lab.font = [UIFont systemFontOfSize:12];
            lab.textColor = [UIColor grayColor];
            [lab setBackgroundColor:KCorolTextBackViewYellow];
            [cellBackView addSubview:lab];
        }
        lab.text = _currentNodeStr;
        h += KLabelSHeight + KMiddleOFF;
    }else{
        UILabel * lab = (UILabel*)[cellBackView viewWithTag:12345];
        [lab removeFromSuperview];
        lab = nil;
    }
    
    _cellHeight = h + 2*middleOff;
    cellBackView.frame = CGRectMake(0, middleOff, _cellWidth, _cellHeight - 2*middleOff);
    //添加底线
    CGRect bottomlineRect= CGRectMake(0, h, cellBackView.frame.size.width , 1);
    if (bottomLineView == nil) {
        bottomLineView = [HSUtils drawLine:cellBackView type:HSRealizationLine rect:bottomlineRect color:KCorolTextLGray];
    }
    if (!_isLine) {
        [bottomLineView removeFromSuperview];
    }
    bottomLineView.frame = bottomlineRect;
}

-(void)setListArr:(NSArray *)listArr{
    if (_listArr != listArr) {
        _listArr = listArr;
        NSArray* subviews = [cellBackView subviews];
        for (UIView * view in subviews) {
            if (view.tag >= 10000) {
                [view removeFromSuperview];
            }
        }
        float h = [self addCellTopView];
        [self addCellListView:h];
    }
}

-(void)setImgStateLabel:(NSString*)labtext labcolor:(UIColor*)labcolor{
    imgStateLabel.text = labtext;
    if (labcolor) {
        imgStateLabel.textColor = labcolor;
    }
}

+(NSString*)multiLineCode{
    return @"pquanshan:";
}


@end
