//
//  HSPMACollectionViewCell.h
//  HSMoveApproval
//
//  Created by yons on 15-1-24.
//  Copyright (c) 2015年 pquanshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSPMACollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIView *topBackView;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;

-(void)setBackViewLayoutWidth:(CGFloat)fwidth;

@end
