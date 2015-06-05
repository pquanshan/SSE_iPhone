//
//  HSChoiceTableViewCell.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/7.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KChoiceCellHeight                 (50)

@class HSChoiceTableViewCell;

@protocol HSChoiceTableViewCellDelegate <NSObject>
@optional
-(void)choiceTableViewCellBtnSelect:(HSChoiceTableViewCell *)tableViewCell selected:(BOOL)selected;

@end

@interface HSChoiceTableViewCell : UITableViewCell

@property(nonatomic, assign)float cellWidth;
@property(nonatomic, assign, readonly)float cellHeight;

@property(nonatomic, strong)UILabel* titleLabel;
@property(nonatomic, strong)UILabel* detailsLabel;
@property(weak, nonatomic)  id<HSChoiceTableViewCellDelegate> delegate;


-(void)setBtnSelected;
-(void)setBtnSelected:(BOOL)selected;
-(void)setBtnHidden:(BOOL)hide;

@end
