//
//  HSProjectTableViewCell.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/30.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KProjectCellHeight     (80)

@interface HSProjectTableViewCell : UITableViewCell

@property(nonatomic, strong)UILabel* titleLab;
@property(nonatomic, strong, readonly)UILabel* stateLab;
@property(nonatomic, strong)UILabel* stateContentLab;
@property(nonatomic, strong, readonly)UILabel* scaleLab;
@property(nonatomic, strong)UILabel* scaleContentLab;

@property(nonatomic, assign)float cellWidth;;


@end
