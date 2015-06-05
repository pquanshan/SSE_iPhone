//
//  HSPickerView.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/12.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSPickerView.h"
#import "HSConfig.h"

static HSPickerView *mPickerView = nil;

@implementation HSPickerView

+ (HSPickerView *)sharePickerView{
    @synchronized(self){
        if (mPickerView==nil) {
            mPickerView = [[self alloc] init];
        }
    }
    return mPickerView;
}

-(id)init{
    self = [super initWithFrame:KScreenBounds];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:10.0/255 green:10.0/255 blue:10.0/255 alpha:0.5]];
//        _pickerArr = @[@"",@"同意",@"批准",@"否决"];
        [self addPickerView];
    }
    return self;
}

-(void)addPickerView{
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(2*KBoundaryOFF, 0, KScreenWidth - 4*KBoundaryOFF, 200)];
    _pickerView.center = [UIApplication sharedApplication].keyWindow.center;
    _pickerView.clipsToBounds = YES;
    _pickerView.layer.cornerRadius = 5;
    [_pickerView setBackgroundColor:[UIColor whiteColor]];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self addSubview:_pickerView];
}

-(void)show:(BOOL)animate{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    //动画效果
    if (animate) {
        self.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1;
        }];
    }else{
    }
}

-(void)close:(BOOL)animate{
    if (animate) {
        self.alpha = 1;
        [UIView animateWithDuration:0.3 animations:^{
           self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else{
        [self removeFromSuperview];
    }
}


#pragma mark pickerview function
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_pickerArr count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_pickerArr objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.delegate pickerViewClick:_pickerArr index:(int)row];
    [self close:YES];
}


@end
