//
//  HSCollectionViewCell.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/27.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSCollectionViewCell.h"
#import "HSConfig.h"
#import "HSUtils.h"

#define KProportion         (0.35)

@interface HSCollectionViewCell (){
    UIView* bottomLineView;
}
@end

@implementation HSCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        _cellWidth = frame.size.width;
        _cellHeight = frame.size.height;
        [self addCollCellView];
    }
    
    return self;
}

-(void)addCollCellView{
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _cellWidth*KProportion, _cellHeight)];
        _leftLabel.font = [UIFont boldSystemFontOfSize:24];
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.textColor = [UIColor whiteColor];
        _leftLabel.backgroundColor = KCorolBackViewGreenPro;
        [self.contentView addSubview:_leftLabel];
    }
    _leftLabel.frame = CGRectMake(0, 0, _cellWidth*KProportion, _cellHeight);
    
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(_cellWidth*KProportion, 0, _cellWidth*(1-KProportion), _cellHeight - 1)];
        _rightLabel.font = [UIFont systemFontOfSize:16];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.textColor = [UIColor blackColor];
        _rightLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_rightLabel];
    }
    _rightLabel.frame = CGRectMake(_cellWidth*KProportion, 0, _cellWidth*(1-KProportion), _cellHeight - 1);
    
    CGRect rect = CGRectMake(_cellWidth*KProportion, _cellHeight - 1, _cellWidth*(1-KProportion), 1);
    if (bottomLineView == nil) {
        bottomLineView = [HSUtils drawLine:self.contentView type:HSRealizationLine rect:rect color:KCorolTextLLGray];
    }
    bottomLineView.frame = rect;
}

-(void)setCellWidth:(float)cellWidth{
    if (_cellHeight != cellWidth) {
        [self addCollCellView];
    }
}

-(void)setCellHeight:(float)cellHeight{
    if (_cellHeight != cellHeight) {
         [self addCollCellView];
    }
}

@end
