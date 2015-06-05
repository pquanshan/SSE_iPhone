//
//  HSNewsTableViewCell.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/18.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSNewsTableViewCell : UITableViewCell

@property(nonatomic, assign)float cellWidth;
@property(nonatomic, assign, readonly)float cellHeight;

@property(nonatomic,strong) NSString* titleLabText;
@property(nonatomic,strong) NSString* nameLabText;
@property(nonatomic,strong) NSString* dateLabText;
@property(nonatomic,strong) UIImageView* iconImg;

@property(nonatomic,assign) BOOL islongl;
@property(nonatomic,assign) BOOL isMark;

-(void)layoutData;
-(float)getCellViewHeight;

@end
