//
//  HSProcessTableViewCell.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/1.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#define KLabelMHeight       (30)
#define KLabelSHeight       (28)

#define KiconImgWH          (30)

#import "HSProcessTableViewCell.h"
#import "HSUtils.h"
#import "HSModel.h"

@interface HSProcessTableViewCell(){
    UIView* cellBackView;
    UILabel* titleLab;
    UILabel* nameLab;
    UILabel* dateLab;
    
    UIImageView* iconImg;
    UIView* leftLineView;
    UIView* bottomLineView;
}
@end

@implementation HSProcessTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellWidth = self.contentView.frame.size.width;
        _cellHeight = self.contentView.frame.size.height;
        [self addCellView];
    }
    return self;
}

-(void)setCellWidth:(float)cellWidth{
    _cellWidth = cellWidth;
}

-(void)setCellHeight:(float)cellHeight{
    _cellHeight = cellHeight;
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

-(void)synchronousCellView{
    [self addCellView];
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
        float offw = KBoundaryOFF*2 - KiconImgWH/2.0;
        float offh = KBoundaryOFF + (KLabelMHeight - KiconImgWH)/2.0;
        iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(offw, offh, KiconImgWH, KiconImgWH)];
        iconImg.image = [[HSUtils sharedUtils] getImageNamed:@"icon_pro.png"];
        [cellBackView addSubview:iconImg];
    }
    //标题
    float x_off = 2*KBoundaryOFF + KiconImgWH;
    if (titleLab == nil) {
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(x_off, KBoundaryOFF, cbWidth - x_off - KBoundaryOFF, KLabelMHeight)];
        titleLab.lineBreakMode = 0;
        titleLab.numberOfLines = 0;
        titleLab.font = [UIFont systemFontOfSize:18];
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
    
    //处理人员、时间
    float w = (cbWidth - KBoundaryOFF*3 - KiconImgWH);
    if (nameLab == nil && dateLab == nil) {
        nameLab = [[UILabel alloc] initWithFrame:CGRectMake(x_off, h - 2, w/2.0, KLabelSHeight)];
        dateLab = [[UILabel alloc] initWithFrame:CGRectMake(x_off + w/2.0, h - 2, w/2.0, KLabelSHeight)];
        nameLab.font = [UIFont systemFontOfSize:16];
        dateLab.font = [UIFont systemFontOfSize:13];
        nameLab.textColor = [UIColor grayColor];
        dateLab.textColor = [UIColor lightGrayColor];
        dateLab.textAlignment = NSTextAlignmentRight;
        [cellBackView addSubview:nameLab];
        [cellBackView addSubview:dateLab];
    }
    nameLab.frame = CGRectMake(x_off, h - 2, w/2.0, KLabelSHeight);
    dateLab.frame = CGRectMake(x_off + w/2.0, h - 2, w/2.0, KLabelSHeight);
    nameLab.text = _nameLabText;
    dateLab.text = _dateLabText;
    h += nameLab.frame.size.height;
    
    //底线
    CGRect bottomlineRect= CGRectMake(KBoundaryOFF*2, h, cbWidth - 2*KBoundaryOFF, 1);
    if (bottomLineView == nil) {
        bottomLineView = [HSUtils drawLine:cellBackView type:HSRealizationLine rect:bottomlineRect color:KCorolTextLGray];
    }
    bottomLineView.frame = bottomlineRect;
    leftLineView.frame = CGRectMake(KBoundaryOFF*2, 0, 1, h);
    cellBackView.frame = CGRectMake(0, 0, cbWidth, h + 1);
//    NSLog(@"-----h = %f",h + 1);
}

-(float)getCellViewHeight{
    float h = 1.5 * KBoundaryOFF;
    //标题
    float titleLabWidth = _cellWidth - 3*KBoundaryOFF - KiconImgWH;
    CGRect rect = [_titleLabText boundingRectWithSize:CGSizeMake(titleLabWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:titleLab.font} context:nil];
    if (rect.size.height + KMiddleOFF < KLabelMHeight) {
        h += KLabelMHeight;
    }else{
        h += rect.size.height + KMiddleOFF;
    }
    //处理人员、时间
    h += KLabelSHeight + 1;
    return h;
}

@end
