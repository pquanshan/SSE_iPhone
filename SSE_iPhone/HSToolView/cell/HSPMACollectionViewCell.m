//
//  HSPMACollectionViewCell.m
//  HSMoveApproval
//
//  Created by yons on 15-1-24.
//  Copyright (c) 2015年 pquanshan. All rights reserved.
//

#import "HSPMACollectionViewCell.h"

@interface HSPMACollectionViewCell(){

}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftViewLayoutWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewLayoutSpace;

@end

@implementation HSPMACollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"HSPMACollectionViewCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
        
    
        self.topBackView.layer.masksToBounds = YES;
        self.topBackView.layer.cornerRadius = 3.0;
    }
    
    return self;

}

-(void)setBackViewLayoutWidth:(CGFloat)fwidth{
    self.leftViewLayoutWidth.constant = fwidth/3 - 1;
}

@end
