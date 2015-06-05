//
//  HSTableViewCellBase.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/25.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSConfig.h"
#import "HSUtils.h"

#define KLabelMHeight           (32)
#define KLabelSHeight           (28)


@interface HSTableViewCellBase : UITableViewCell

@property(nonatomic, assign)float cellWidth;
@property(nonatomic, assign, readonly)float cellHeight;

@property(nonatomic,strong) NSString* titleStr;
@property(nonatomic,strong) NSString* detailStr;
@property(nonatomic,strong) NSString* dateStr;

@property(nonatomic,assign) float spacTop;//上间距
@property(nonatomic,assign) float spacBottom;//下间距
@property(nonatomic,assign) float spacLeft;//左间距
@property(nonatomic,assign) float spacRight;//右间距
@property(nonatomic,assign) float spacLabmiddle;//lab上下间距

@property(nonatomic,strong)UIView* cellBackView;
@property(nonatomic,strong)UIView* topLineView;
@property(nonatomic,strong)UIView* bottomLineView;


-(void)setCellBackViewCorlor:(UIColor*)color;
-(void)setBackViewCorlor:(UIColor*)color;


-(float)setCellView;//添加你的cell
-(void)layoutData;//对数据进行布局

-(void)addLineView;

-(float)getCellViewHeight;


@end
