//
//  HSDetailTableViewCell.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/18.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSDetailTableViewCell : UITableViewCell

@property(nonatomic, assign)float cellWidth;
@property(nonatomic, assign, readonly )float cellHeight;

@property(nonatomic, strong)UIView* cellBackView;
@property(nonatomic, strong)UILabel* titleLab;
@property(nonatomic, strong)UILabel* detailsLab;
@property(nonatomic, strong)UILabel* valueLab;
@property(nonatomic, strong)UIImageView* imgView;

@property(nonatomic, assign)float middleOff;
@property(nonatomic, assign)BOOL isTitleLong;
@property(nonatomic, assign)BOOL isLine;

-(void)setImgStateLabel:(NSString*)labtext labcolor:(UIColor*)labcolor;

//存在listArr时，外部调用必须最后设置，用来计算高度
@property(nonatomic, strong)NSArray* listArr;
//存在当前节点时，外部调用必须最后设置，用来计算高度
@property(nonatomic, strong)NSString* currentNodeStr;

+(NSString*)multiLineCode;


@end
