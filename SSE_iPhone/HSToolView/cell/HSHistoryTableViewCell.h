//
//  HSHistoryTableViewCell.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/2.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSHistoryTableViewCell : UITableViewCell

@property(nonatomic, assign)float cellWidth;
@property(nonatomic, assign)float cellHeight;

@property(nonatomic, assign)BOOL isExplain;//存不存在说明
@property(nonatomic, assign)BOOL isRemarks;//存不存在备注

@property(nonatomic,strong) NSString* titleLabText;
@property(nonatomic,strong) NSString* nameLabText;
@property(nonatomic,strong) NSString* dateLabText;
@property(nonatomic,strong) NSString* opinionLabText;
@property(nonatomic,strong) NSString* explainLabText;
@property(nonatomic,strong) NSString* remarksLabText;

-(void)setOpinionBackViewColor:(UIColor *)color;
-(void)synchronousCellView;
-(float)getCellViewHeight;

@end
