//
//  HSNewsTableViewCell.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/18.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#define KLabelMHeight       (30)
#define KLabelSHeight       (28)
#define KiconImgWH          (40)
#define KMarkImgWH          (12)

#import "HSNewsTableViewCell.h"
#import "HSUtils.h"


@interface HSNewsTableViewCell(){
    UIView* cellBackView;
    UILabel* titleLab;
    UILabel* nameLab;
    UILabel* dateLab;
    UIView* topLineView;
    UIView* bottomLineView;
    
    UIImageView* imgMarkView;
}
@end

@implementation HSNewsTableViewCell
@synthesize iconImg;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellWidth = self.contentView.frame.size.width;
        _cellHeight = self.contentView.frame.size.height;
        _islongl = YES;
        _isMark = NO;
        [self addCellView];
    }
    return self;
}

-(void)layoutData{
    [self addCellView];
}

-(void)setIsMark:(BOOL)isMark{
    _isMark = isMark;
    imgMarkView.hidden =  _isMark ? NO: YES;
}

-(void)addCellView{
    if (cellBackView == nil) {
        cellBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _cellWidth, _cellHeight)];
        [self.contentView addSubview:cellBackView];
    }
    cellBackView.frame = CGRectMake(0, 0, _cellWidth, _cellHeight);
    
    //顶部的线
    float cbWidth = cellBackView.frame.size.width;
    float h = 1.5 * KBoundaryOFF;
    //图标KLabelMHeight(固定)
    if (iconImg == nil) {
        float offw = KBoundaryOFF;
        float offh = KBoundaryOFF + (KLabelMHeight + KLabelSHeight - KiconImgWH)/2.0 - KBoundaryOFF/2;
        iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(offw, offh, KiconImgWH, KiconImgWH)];
        [cellBackView addSubview:iconImg];
        
        imgMarkView = [[UIImageView alloc] initWithFrame:CGRectMake(KiconImgWH - KMarkImgWH/2 - 2, -KMarkImgWH/2 + 2, KMarkImgWH, KMarkImgWH)];
        [imgMarkView setBackgroundColor:[UIColor redColor]];
        imgMarkView.hidden = YES;
        imgMarkView.clipsToBounds = YES;
        imgMarkView.layer.cornerRadius = KMarkImgWH/2.0;
        [iconImg addSubview:imgMarkView];
    }
    //标题
    float x_off = KBoundaryOFF + KiconImgWH + 3*KMiddleOFF;
    if (titleLab == nil) {
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(x_off, KBoundaryOFF, cbWidth - x_off - KBoundaryOFF, KLabelMHeight)];
        titleLab.lineBreakMode = 0;
        titleLab.numberOfLines = 0;
        titleLab.font = [UIFont systemFontOfSize:16];
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
    float w = (cbWidth - x_off - KBoundaryOFF);
    if (nameLab == nil && dateLab == nil) {
        nameLab = [[UILabel alloc] initWithFrame:CGRectMake(x_off, h - 2, w/2.0 - 20, KLabelSHeight)];
        dateLab = [[UILabel alloc] initWithFrame:CGRectMake(x_off + w/2.0 - 20, h - 2, w/2.0 + 20, KLabelSHeight)];
        nameLab.font = [UIFont systemFontOfSize:14];
        dateLab.font = [UIFont systemFontOfSize:13];
        nameLab.textColor = [UIColor grayColor];
        dateLab.textColor = [UIColor lightGrayColor];
        dateLab.textAlignment = NSTextAlignmentRight;
        [cellBackView addSubview:nameLab];
        [cellBackView addSubview:dateLab];
    }
    nameLab.frame = CGRectMake(x_off, h - 2, w/2.0 - 20, KLabelSHeight);
    dateLab.frame = CGRectMake(x_off + w/2.0 - 20, h - 2, w/2.0 + 20, KLabelSHeight);
    nameLab.text = _nameLabText;
    dateLab.text = _dateLabText;
    h += nameLab.frame.size.height;
    
    //底线
    float lineoff_x =  _islongl ? 0 : KBoundaryOFF;
    
    CGRect bottomlineRect= CGRectMake(lineoff_x, h, cbWidth - 2*lineoff_x, 1);
    if (bottomLineView == nil) {
        bottomLineView = [HSUtils drawLine:cellBackView type:HSRealizationLine rect:bottomlineRect color:KCorolTextLGray];
    }
    bottomLineView.frame = bottomlineRect;
    cellBackView.frame = CGRectMake(0, 0, cbWidth, h + 1);
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
