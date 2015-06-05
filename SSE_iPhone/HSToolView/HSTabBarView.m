//
//  HSTabBarView.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/16.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#define KBtnMinWidth        (60)
#define KSLineViewHeight    (4)

#import "HSTabBarView.h"
#import "HSConfig.h"
#import "HSUtils.h"

@interface HSTabBarView ()<UIScrollViewDelegate>{
    UIScrollView* scrollView;
    UIView* lineView1;
    UIView* lineView2;
    
    UIView* sLineView;//滑动指示器
}

@end

@implementation HSTabBarView


-(id)init{
    self = [super init];
    if (self) {
        _tabBarWidth = KScreenWidth;
        _tabBarHeight = KTabBarHeight;
        _selectIndex = 0;
        _btnArr = [[NSMutableArray alloc] init];
        [self initScrollView];
        [self initLineView];
    }
    return self;
}

-(void)initScrollView{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _tabBarWidth, _tabBarHeight)];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(_tabBarWidth, _tabBarHeight);
    [scrollView setBackgroundColor:KCorolTextLLGray];
    [self addSubview:scrollView];
    
    sLineView = [[UIView alloc] initWithFrame:CGRectMake(0, scrollView.frame.size.height - KSLineViewHeight, scrollView.frame.size.width, KSLineViewHeight)];
    [sLineView setBackgroundColor:KCorolBackViewBlue];
    [scrollView addSubview:sLineView];
    [scrollView bringSubviewToFront:sLineView];
}

-(void)initLineView{
    CGRect rect1 = CGRectMake(0, 0, _tabBarWidth, 1);
    lineView1 = [HSUtils drawLine:self type:HSRealizationLine rect:rect1 color:KCorolTextLLGray];
    
    CGRect rect2 = CGRectMake(0, _tabBarHeight - 1, _tabBarWidth, 1);
    lineView2 = [HSUtils drawLine:self type:HSRealizationLine rect:rect2 color:KCorolTextLLGray];
}

-(void)setBtnArr:(NSMutableArray *)btnArr{
    if (_btnArr != btnArr) {
        _btnArr = btnArr;
    }
    
    NSArray* viewArr = [scrollView subviews];
    for (UIView* view in viewArr) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    
    [self adjustBasicsLayout];

}

-(void)setTabBarWidth:(float)tabBarWidth{
    if (_tabBarWidth != tabBarWidth) {
        _tabBarWidth = tabBarWidth;
        [self adjustBasicsLayout];
    }
}

-(void)setSelectIndex:(int)selectIndex{
    if (_selectIndex != selectIndex) {
        _selectIndex = selectIndex;
        [self selectButton:_selectIndex];
    }
}

#pragma mark 动态布局
-(void)adjustBasicsLayout{
    if (_btnArr) {
        float sizeW = _btnArr.count*KBtnMinWidth + _btnArr.count - 1;//一个宽度中间线
        float btnW = KBtnMinWidth;
        if (sizeW < _tabBarWidth) {
//            btnW = _tabBarWidth/_btnArr.count;
            btnW = (_tabBarWidth - _btnArr.count + 1)/_btnArr.count;
            sizeW = _tabBarWidth;
        }
        scrollView.frame = CGRectMake(0, 0, _tabBarWidth, _tabBarHeight);
        scrollView.contentSize = CGSizeMake(sizeW, _tabBarHeight);
        lineView1.frame = CGRectMake(0, 0, _tabBarWidth, 1);
        lineView2.frame = CGRectMake(0, _tabBarHeight - 1, _tabBarWidth, 1);
        sLineView.frame = CGRectMake(0, 0, btnW, KSLineViewHeight);
        
        for (int i = 0; _btnArr && i < _btnArr.count; ++i) {
            id object = [_btnArr objectAtIndex:i];
            UIButton* btn = nil;
            if ([object isKindOfClass:[NSString class]]) {
                btn = [[UIButton alloc] initWithFrame:CGRectMake((btnW+1)*i, 0, btnW, scrollView.frame.size.height)];
                btn.tag = 1000 + i;
                [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchDown];
                [btn setTitle:(NSString*)object forState:UIControlStateNormal];
                [btn setTitleColor:KCorolBackViewBlack forState:UIControlStateNormal];
                [btn setTitleColor:KCorolBackViewBlue forState:UIControlStateHighlighted];
                [btn setTitleColor:KCorolBackViewBlue forState:UIControlStateSelected];
                [scrollView addSubview:btn];
            }else if ([object isKindOfClass:[UIButton class]]){
                btn = (UIButton*)object;
                btn.tag = 1000 + i;
                btn.frame = CGRectMake((btnW+1)*i, 0, btnW, scrollView.frame.size.height);
                [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchDown];
                [scrollView addSubview:btn];
            }else{
            
            }
            [btn setBackgroundColor:[UIColor whiteColor]];
            
            if (_selectIndex == i) {
                btn.selected = YES;
                sLineView.frame = CGRectMake((btnW+1)*i, scrollView.frame.size.height - KSLineViewHeight, btnW, KSLineViewHeight);
                [scrollView bringSubviewToFront:sLineView];
            }else{
                btn.selected = NO;
            }
        }
    }
}

-(void)btnclick:(UIButton*)sendBtn{
    int index = (int)[sendBtn tag] - 1000;
    if (_btnArr && index >= 0 && index < _btnArr.count) {
        if (_selectIndex != index) {
            _selectIndex = index;
            [self selectButton:_selectIndex];
        }
    }
}

-(void)selectButton:(int)selectIndex{
    for (int  i = 0; _btnArr && i < _btnArr.count; ++i) {
        UIButton* btn = (UIButton*)[scrollView viewWithTag:1000 + i];
        if (i != selectIndex) {
            btn.selected = NO;
        }else{
            btn.selected = YES;
        }
    }
    
    float sizeW = _btnArr.count*KBtnMinWidth + _btnArr.count - 1;//一个宽度中间线
    float btnW = KBtnMinWidth;
    if (sizeW < _tabBarWidth) {
        btnW = (_tabBarWidth - _btnArr.count + 1)/_btnArr.count;
        sizeW = _tabBarWidth;
    }
    [scrollView bringSubviewToFront:sLineView];
    [UIView animateWithDuration:0.3 animations:^{
        sLineView.frame = CGRectMake((btnW+1)*selectIndex, scrollView.frame.size.height - KSLineViewHeight, btnW, KSLineViewHeight);
    }];

    
    [self.delegate tabBarViewselcetButton:selectIndex];
}

-(void)setTabBarButton:(UIButton*)button index:(int)index{
    if (button && _btnArr && index >= 0 && index < _btnArr.count) {
        UIButton* btn = (UIButton*)[scrollView viewWithTag:1000 + index];
        if (btn) {
            [btn removeFromSuperview];
            btn = nil;
        }
        float btnW =  ( _btnArr.count*KBtnMinWidth + _btnArr.count - 1 < _tabBarWidth) ? (_tabBarWidth - _btnArr.count + 1)/_btnArr.count : KBtnMinWidth;
        button.frame = CGRectMake((btnW+1)*index, 0, btnW, scrollView.frame.size.height);
        button.tag = 1000 + index;
        [button addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchDown];
        [scrollView addSubview:button];
    }
}

-(void)addTabBarButton:(UIButton*)button{
    if (_btnArr) {
        [_btnArr addObject:button];
        NSArray* viewArr = [scrollView subviews];
        for (UIView* view in viewArr) {
            [view removeFromSuperview];
        }
        [self adjustBasicsLayout];
    }
}

@end
