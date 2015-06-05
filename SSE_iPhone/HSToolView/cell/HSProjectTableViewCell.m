//
//  HSProjectTableViewCell.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/30.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSProjectTableViewCell.h"
#import "HSConfig.h"
#import "HSUtils.h"

//@property(nonatomic, strong)UILabel* titleLab;
//@property(nonatomic, strong, readonly)UILabel* stateLab;
//@property(nonatomic, strong)UILabel* stateContentLab;
//@property(nonatomic, strong, readonly)UILabel* scaleLab;
//@property(nonatomic, strong)UILabel* scaleContentLab;

#define KProportion          (0.7)


@interface HSProjectTableViewCell(){
    float cellHeight;
    UIView* buttomLinebView;
    UIView* lineView;
}
@end

@implementation HSProjectTableViewCell
@synthesize cellWidth;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        cellWidth = self.contentView.frame.size.width;
        cellHeight = KProjectCellHeight;
        [self addCellView];
    }
    return self;
}

-(void)addCellView{
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF, KBoundaryOFF - 6, cellWidth*KProportion -KBoundaryOFF - 1, 42)];
    [self.contentView addSubview:_titleLab];
    _titleLab.font = [UIFont systemFontOfSize:16];
    _titleLab.lineBreakMode = 0;
    _titleLab.numberOfLines = 2;
    _titleLab.text = @"恒生债券001项目";
    
    _stateLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF, KBoundaryOFF + 35, 70, 30)];
    [self.contentView addSubview:_stateLab];
    _stateLab.font = [UIFont systemFontOfSize:14];
    _stateLab.text = @"项目状态:";
    
    _stateContentLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF + 70, KBoundaryOFF + 35, cellWidth*KProportion -KBoundaryOFF - 70 - 1, 30)];
    [self.contentView addSubview:_stateContentLab];
    _stateContentLab.font = [UIFont systemFontOfSize:14];
    _stateContentLab.textColor = KCorolTextRed;
    _stateContentLab.text = @"材料上报审核中";
    
    //添加底线
    CGRect bottomlineRect = CGRectMake(0, cellHeight - 1, cellWidth , 1);
    buttomLinebView = [HSUtils drawLine:self.contentView type:HSRealizationLine rect:bottomlineRect color:KCorolTextLGray];
    
    //添加虚线
    CGRect lineRect = CGRectMake(cellWidth*KProportion, KBoundaryOFF, 1 , cellHeight - 2* KBoundaryOFF);
    lineView = [HSUtils drawLine:self.contentView type:HSRealizationLine rect:lineRect color:KCorolTextLLGray];

    
    _scaleLab = [[UILabel alloc] initWithFrame:CGRectMake(cellWidth*KProportion + 1, KBoundaryOFF, cellWidth*(1 -KProportion) -1, 38)];
    _scaleLab.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_scaleLab];
    _scaleLab.textAlignment = NSTextAlignmentCenter;
    _scaleLab.numberOfLines = 2;
    _scaleLab.text = @"3000万";
    
    
    _scaleContentLab = [[UILabel alloc] initWithFrame:CGRectMake(cellWidth*KProportion + 1,KBoundaryOFF + 35, cellWidth*(1 -KProportion) -1, 30)];
    [self.contentView addSubview:_scaleContentLab];
    _scaleContentLab.font = [UIFont systemFontOfSize:13];
    _scaleContentLab.textColor = [UIColor grayColor];
    _scaleContentLab.textAlignment = NSTextAlignmentCenter;
    _scaleContentLab.text = @"拟筹资额";
}

-(void)layout{
    _titleLab.frame = CGRectMake(KBoundaryOFF, KBoundaryOFF - 6, cellWidth*KProportion -KBoundaryOFF - 1, 42);
    _stateLab.frame = CGRectMake(KBoundaryOFF, KBoundaryOFF + 35, 70, 30);
    _stateContentLab.frame = CGRectMake(KBoundaryOFF + 70, KBoundaryOFF + 35, cellWidth*KProportion -KBoundaryOFF - 70 - 1, 30);
    buttomLinebView.frame = CGRectMake(0, cellHeight - 1, cellWidth , 1);
    lineView.frame = CGRectMake(cellWidth*KProportion, KBoundaryOFF, 1 , cellHeight - 2* KBoundaryOFF);
    _scaleLab.frame = CGRectMake(cellWidth*KProportion + 1, KBoundaryOFF - 5, cellWidth*(1 -KProportion) -1, 38 + 10);
    _scaleContentLab.frame = CGRectMake(cellWidth*KProportion + 1,KBoundaryOFF + 35, cellWidth*(1 -KProportion) -1, 30);
}

-(void)setCellWidth:(float)cellwidth{
    cellWidth = cellwidth;
    [self layout];
}

@end
