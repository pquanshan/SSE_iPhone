//
//  HSButtonsView.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/9.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSButtonsView.h"
#import "HSConfig.h"
#import "HSUtils.h"

static HSButtonsView *mButtonsView = nil;

@interface HSButtonsView()<UITableViewDelegate, UITableViewDataSource>{
    UITableView* tabview;
    UIButton* cancelBtn;
}

@end

@implementation HSButtonsView


+ (HSButtonsView *)shareButtonsView{
    @synchronized(self){
        if (mButtonsView==nil) {
            mButtonsView = [[self alloc] init];
        }
    }
    return mButtonsView;
}

-(id)init{
    self = [super initWithFrame:KScreenBounds];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:10.0/255 green:10.0/255 blue:10.0/255 alpha:0.5]];
        [self addTabview];
        [self addCancelBtn];
    }
    return self;
}

-(void)addTabview{
    tabview = [[UITableView alloc] initWithFrame:CGRectMake(20, KScreenHeight - KCellHeight - 20 - 0, KScreenWidth - 40, 0) style:UITableViewStylePlain];
    [tabview setBackgroundColor:[UIColor whiteColor]];
    tabview.separatorStyle=UITableViewCellSeparatorStyleNone;
    tabview.clipsToBounds = YES;
    tabview.layer.cornerRadius = 4.0;
    tabview.delegate = self;
    tabview.dataSource = self;
    tabview.rowHeight = KCellHeight;
    [self addSubview:tabview];
    [tabview reloadData];
}

-(void)addCancelBtn{
    cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, KScreenHeight - KCellHeight - 20, KScreenWidth - 40, KCellHeight)];
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchDown];
    cancelBtn.clipsToBounds = YES;
    cancelBtn.layer.cornerRadius = 4.0;
    [self addSubview:cancelBtn];
}

-(void)setBtnArr:(NSArray *)btnArr{
    _btnArr = btnArr;
    float h = 0;
    if (_btnArr) {
        h = _btnArr.count * KCellHeight;
    }
    (h + KCellHeight + 40 > KScreenHeight/2) ? h = KScreenHeight/2 -KCellHeight - 40 : h;
    tabview.frame = CGRectMake(20, KScreenHeight - KCellHeight - 40 - h, KScreenWidth - 40, h);
    [tabview reloadData];
}

#pragma mark UITableView的委托方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellString = @"Cell";
    UITableViewCell *cell =(UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellString];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[UIColor whiteColor]];
        //底线
        CGRect bottomlineRect= CGRectMake(0, KCellHeight -1, tabview.frame.size.width, 1);
        [HSUtils drawLine:cell type:HSRealizationLine rect:bottomlineRect color:KCorolTextLGray];
    }
    
    cell.textLabel.text = [_btnArr objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor blueColor];
    
    return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _btnArr.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate buttonsViewClickButton:self array:_btnArr index:(int)indexPath.row];
}

-(void)cancelBtnClick:(id)sender{
    [self close:YES];
}

-(void)show:(BOOL)animate{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    //动画效果
    if (animate) {
        tabview.frame = CGRectMake(20, KScreenHeight, KScreenWidth - 40, tabview.frame.size.height);
        cancelBtn.frame = CGRectMake(20,KScreenHeight + tabview.frame.size.height + 20, KScreenWidth - 40, KCellHeight);
        [UIView animateWithDuration:0.3 animations:^{
            tabview.frame = CGRectMake(20, KScreenHeight - KCellHeight - 40 - tabview.frame.size.height, KScreenWidth - 40, tabview.frame.size.height);
            cancelBtn.frame = CGRectMake(20, KScreenHeight - KCellHeight - 20, KScreenWidth - 40, KCellHeight);
        }];
    }else{
    }
}

-(void)close:(BOOL)animate{
    if (animate) {
        [UIView animateWithDuration:0.3 animations:^{
            tabview.frame = CGRectMake(20, KScreenHeight, KScreenWidth - 40, tabview.frame.size.height);
            cancelBtn.frame = CGRectMake(20,KScreenHeight + tabview.frame.size.height + 20, KScreenWidth - 40, KCellHeight);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else{
        [self removeFromSuperview];
    }
}

@end
