//
//  HSProcessTableViewCell.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/1.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSProcessTableViewCell : UITableViewCell

@property(nonatomic, assign)float cellWidth;
@property(nonatomic, assign)float cellHeight;

@property(nonatomic,strong) NSString* titleLabText;
@property(nonatomic,strong) NSString* nameLabText;
@property(nonatomic,strong) NSString* dateLabText;

-(void)synchronousCellView;
-(float)getCellViewHeight;
@end
