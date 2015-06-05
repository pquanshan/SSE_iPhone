//
//  HSButtonsView.h
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/9.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HSButtonsView;

@protocol HSButtonsViewDelegate <NSObject>
@optional
-(void)buttonsViewClickButton:(HSButtonsView*)buttonsView array:(NSArray*)array index:(int)index;

@end


@interface HSButtonsView : UIView{

}

+ (HSButtonsView *)shareButtonsView;

@property(nonatomic, strong)NSArray* btnArr;
@property(nonatomic, weak) id<HSButtonsViewDelegate> delegate;

-(void)show:(BOOL)animate;
-(void)close:(BOOL)animate;

@end
