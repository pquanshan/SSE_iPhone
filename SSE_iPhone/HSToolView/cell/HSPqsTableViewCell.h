//
//  HSPqsTableViewCell.h
//  HSMoveApproval
//
//  Created by yons on 15-1-24.
//  Copyright (c) 2015年 pquanshan. All rights reserved.
//

#import <UIKit/UIKit.h>

//HSPqsTableViewCells实现UI布局

/////////////////////////////////////////////////////////////////////////////////////
// 标题:titleLabel                                时间:dateLabel //                 //
//////////////////////////////////////////////////////////////////                 //
//                                //                            //按钮:rightButtons //
// 显示文本列表:labelArr            // 扩展视图:rightView          //                 //
//                                //                            //                 //
/////////////////////////////////////////////////////////////////////////////////////

@class HSPqsTableViewCell;

@protocol TableDetailCellDelegate <NSObject>

@optional
-(void)tableDetailCellClickButton:(HSPqsTableViewCell*)tableViewCell index:(int)index;
-(void)tableDetailCellShowButton:(HSPqsTableViewCell*)tableViewCell index:(int)index;

@end

@interface HSPqsTableViewCell : UITableViewCell<UIScrollViewDelegate>

//TableDetailViewCells布局,需要用到的元素
@property(strong, nonatomic) UILabel*  titleLabel;
@property(strong, nonatomic) NSArray*  labelArr;
@property(strong, nonatomic) NSArray*  rightButtons;
@property(strong, nonatomic) UILabel   *nodataLabel;
@property(strong, nonatomic, readonly) UIView*  rightView;


//lab或btn颜色设置
@property(strong, nonatomic) NSArray*  labelTextColorArr;
@property(strong, nonatomic) NSArray*  rightButtonsColor;
@property(assign, nonatomic) BOOL  isRightView;//右边的视图是否显示，默认为NO，设置为YES将显示扩展视图
@property(assign, nonatomic) BOOL  isAutomaticHeight;//高度是否自动，默认为NO，单行显示，设为YES所有Label支持多行显示
@property(assign, nonatomic) BOOL  isnodata;//有没有数据，默认为NO，设置为YES，将会一个nodataLabel覆盖整个Cell
@property(assign, nonatomic) float cellWidth;//cell的宽度
@property(assign, nonatomic) float buttonWidth;//右边显示的Btn宽度
@property(weak, nonatomic)   id<TableDetailCellDelegate> delegate;//点击btn时，通过此代理通知外部

-(void)setdateLabelText:(NSString*)dataStr;//设置dateLabel得值
-(float)getDetailTableViewCellHeight:(NSString*)titelStr dateStr:(NSString*)dateStr textArr:(NSArray*)textArr;//强烈建议外部使用此方法获cell的高度，不依赖对象
-(float)getDetailTableViewCellHeight;//依赖于对象
-(void)setShowButton:(int)index;

@end
