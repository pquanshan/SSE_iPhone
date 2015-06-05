//
//  HSChoiceTableViewCell.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/7.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#define KCONTENT_LEFT_INSET         (16)
#define KSelectBtnWidth             (80)
#define KSelectBtnHeight            (24)



#import "HSChoiceTableViewCell.h"
#import "HSConfig.h"
#import "HSUtils.h"

@interface HSChoiceTableViewCell(){
    UIButton* selectBtn;
    UIView* bottomlineView;
}
@end

@implementation HSChoiceTableViewCell
@synthesize titleLabel,detailsLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        _cellWidth = self.contentView.bounds.size.width;
        _cellHeight = KChoiceCellHeight;
        [self initializer];
    }
    
    return self;
}

- (void)initializer{
    //名称
    if (titleLabel == nil) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KCONTENT_LEFT_INSET, 2, _cellWidth- KSelectBtnWidth - 2*KCONTENT_LEFT_INSET, 28)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font=[UIFont systemFontOfSize:17];
        [self.contentView addSubview:titleLabel];
    }
    if (detailsLabel == nil) {
        detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(KCONTENT_LEFT_INSET, 26, _cellWidth - KSelectBtnWidth - 2*KCONTENT_LEFT_INSET, 22)];
        detailsLabel.textColor = [UIColor grayColor];
        detailsLabel.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:detailsLabel];
    }
    
    if (selectBtn == nil) {
        selectBtn  = [[UIButton alloc] initWithFrame:CGRectMake(_cellWidth - KSelectBtnWidth - KCONTENT_LEFT_INSET, (_cellHeight - KSelectBtnHeight)/2.0, KSelectBtnWidth, KSelectBtnHeight)];
        selectBtn.clipsToBounds = YES;
        selectBtn.layer.cornerRadius = 10.0;
        selectBtn.selected = NO;
        [selectBtn setBackgroundColor:KCorolBackViewBlue];
        selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [selectBtn setTitle:@"未选择" forState:UIControlStateNormal];
        [selectBtn setTitle:@"已选择" forState:UIControlStateSelected];
        [selectBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:selectBtn];
    }
    
//    if (bottomlineView == nil) {
//        CGRect bottomlineRect= CGRectMake(KCONTENT_LEFT_INSET, _cellHeight - 1, self.cellWidth - 2*KCONTENT_LEFT_INSET, 1);
//        bottomlineView = [HSUtils drawLine:self.contentView type:HSRealizationLine rect:bottomlineRect color:KCorolTextLGray];
//    }
}

-(void)setCellWidth:(float)cellWidth{
    _cellWidth = cellWidth;
    titleLabel.frame = CGRectMake(KCONTENT_LEFT_INSET, 2, _cellWidth - KSelectBtnWidth - 2*KCONTENT_LEFT_INSET, 28);
    detailsLabel.frame = CGRectMake(KCONTENT_LEFT_INSET, 26, _cellWidth - KSelectBtnWidth - 2*KCONTENT_LEFT_INSET, 22);
    selectBtn.frame = CGRectMake(_cellWidth - KSelectBtnWidth - KCONTENT_LEFT_INSET, (_cellHeight - KSelectBtnHeight)/2.0, KSelectBtnWidth, KSelectBtnHeight);
    bottomlineView.frame = CGRectMake(KCONTENT_LEFT_INSET, _cellHeight - 1, self.cellWidth - 2*KCONTENT_LEFT_INSET, 1);
}

-(void)setBtnSelected:(BOOL)selected{
    if (!selectBtn.hidden) {
        selectBtn.selected = selected;
        if (selected == YES) {
            [selectBtn setBackgroundColor:KCorolBackViewRed];
        }else{
            [selectBtn setBackgroundColor:KCorolBackViewBlue];
        }
    }
}

-(void)setBtnSelected{
    if (!selectBtn.hidden) {
        [self btnClick:selectBtn];
    }
}

-(void)setBtnHidden:(BOOL)hide{
    selectBtn.hidden = hide;
}

-(void)btnClick:(UIButton*)btn{
    selectBtn.selected = !btn.selected;
    if (selectBtn.selected == YES) {
        [selectBtn setBackgroundColor:KCorolBackViewRed];
    }else{
        [selectBtn setBackgroundColor:KCorolBackViewBlue];
    }
    [self.delegate choiceTableViewCellBtnSelect:self  selected:selectBtn.selected];
}

@end
