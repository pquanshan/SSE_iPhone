//
//  HSCollectionViewCell.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/27.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSCollectionViewCell : UICollectionViewCell

@property(nonatomic, assign)float cellWidth;
@property(nonatomic, assign)float cellHeight;

@property (strong, nonatomic) UILabel *leftLabel;
@property (strong, nonatomic) UILabel *rightLabel;

@end
