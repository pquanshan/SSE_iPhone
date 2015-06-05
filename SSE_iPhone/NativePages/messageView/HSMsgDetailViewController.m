//
//  HSMsgDetailViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/20.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSMsgDetailViewController.h"
#import "HSNewsTableViewCell.h"
#import "HSDataModel.h"

#define KLabelHeight    (28)

@interface HSMsgDetailViewController (){
    HSNewsTableViewCell* newsCell;
    
    UIView* addresseeView;
    NSArray* addresseeArr;
    UIView* addresseeLineView;
    UITextView* textView;
    
}

@end

@implementation HSMsgDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    newsCell = [[HSNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    [newsCell setBackgroundColor:[UIColor whiteColor]];
    [newsCell setIslongl:NO];
    [newsCell setCellWidth:self.view.frame.size.width];
    [self setTableViewCell:newsCell modelData:nil];
    [self.view addSubview:newsCell];
    newsCell.frame = CGRectMake(0, 0, self.view.frame.size.width, [newsCell getCellViewHeight]);
    
    addresseeArr = @[@"张飞",@"赵云",@"诸葛孔明",@"张飞"];
    
//    [self addResseeView];
    [self addTextView];
}

-(void)requestUrl:(NSString*)strUrl{
    if ([[HSModel sharedHSModel] isLogin]) {
        HSPHttpOperationManagers* operation = [[HSPHttpOperationManagers alloc] init];
        operation.delegate = self;
        if (strUrl == nil) {
            return;
        }
        NSMutableString* postStr = [[NSMutableString alloc] initWithString:strUrl];
        if ([[HSModel sharedHSModel] isReachable]) {
            [operation addRequestByKey:[NSURL URLWithString:postStr] type:[self requestType] data:[self requestArrData]];
            [operation executionQueue];
        }else{
            [HSUtils showAlertMessage:@"提示" msg:@"网络连接异常" delegate:nil];
        }
    }
}

-(void)setTableViewCell:(HSNewsTableViewCell*)cell modelData:(HSDataNewsDetailModel*)modelData{
    [cell setTitleLabText:modelData.title];
    [cell setNameLabText:modelData.sender];

    NSString *timeStr = modelData.sendtime;
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate* date =  [dateFormatter dateFromString:timeStr];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSString *sendtime = [dateFormatter stringFromDate:date];
//    [cell setDateLabText:sendtime];
    [cell setDateLabText:timeStr];
    
    if (modelData.title) {
        int mack = [modelData.mark intValue];
        [cell.iconImg setImage:[[HSBusinessAnalytical sharedBusinessAnalytical] getNewsIconHsint:mack]];
    }else{
        [cell.iconImg setImage:nil];
    }

    [cell layoutData];
}

- (void)addResseeView {
    float width = self.view.frame.size.width;
    if (addresseeView == nil) {
        addresseeView = [[UIView alloc] initWithFrame:CGRectMake(0, [newsCell getCellViewHeight], self.view.frame.size.width, 100)];
        [addresseeView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:addresseeView];
        
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF, KMiddleOFF, 100, KLabelHeight)];
        CGFloat nameWidth = [@"收件人" boundingRectWithSize:CGSizeMake(MAXFLOAT, KLabelHeight)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.width;
        lab.textColor = [UIColor grayColor];
        lab.text = @"收件人";
        lab.font = [UIFont systemFontOfSize:14];
        lab.frame = CGRectMake(KBoundaryOFF, KMiddleOFF, nameWidth, KLabelHeight);
        width -= (nameWidth + 2* KBoundaryOFF);
        [addresseeView addSubview:lab];
    }

    CGFloat sumWidth = KBoundaryOFF + addresseeView.frame.size.width - (width + 2*KBoundaryOFF) + 10;
    int row = 1;
    for (int i = 0;addresseeArr && i < addresseeArr.count; ++i) {
        NSString *strName = [addresseeArr objectAtIndex:i];
        CGFloat nameWidth = [strName boundingRectWithSize:CGSizeMake(MAXFLOAT, KLabelHeight)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.width;
        if (sumWidth + nameWidth + 20 > addresseeView.frame.size.width- KBoundaryOFF) {
            sumWidth = KBoundaryOFF + addresseeView.frame.size.width - (width + 2*KBoundaryOFF) + 10;
            row++;
        }

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(sumWidth, (row - 1) * KLabelHeight + KMiddleOFF + (KLabelHeight - 20)/2, nameWidth + 20, 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.text = strName;
        label.textAlignment = NSTextAlignmentCenter;
        label.clipsToBounds = YES;
        label.layer.cornerRadius = 10;
        [label setBackgroundColor:[UIColor lightGrayColor]];
        label.userInteractionEnabled = YES;
        [addresseeView addSubview:label];
        
        sumWidth += (nameWidth + 25);
    }
    
    CGFloat topViewHeight = 0;
    if (addresseeArr.count > 0) {
        topViewHeight = row * KLabelHeight + 2*KMiddleOFF;
    }
    addresseeView.frame = CGRectMake(0,[newsCell getCellViewHeight],self.view.frame.size.width, topViewHeight);
    
    CGRect lineRect= CGRectMake(0, topViewHeight - 1, addresseeView.frame.size.width, 1);
    
    if (addresseeLineView == nil) {
        addresseeLineView = [HSUtils drawLine:addresseeView type:HSRealizationLine rect:lineRect color:KCorolTextLGray];
    }
    addresseeLineView.frame = lineRect;
}

-(void)addTextView{
    float off_h = [newsCell getCellViewHeight] + addresseeView.frame.size.height;
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, off_h, self.view.frame.size.width, self.view.frame.size.height - off_h)];
    [self.view addSubview:textView];
    textView.text = @"";
    textView.font = [UIFont systemFontOfSize:14];
    textView.editable = NO;
    textView.textColor = [UIColor grayColor];
    textView.textContainerInset = UIEdgeInsetsMake(15, 10, 10, 10);
    [textView setBackgroundColor:[HSColor getColorByColorPageLightBlack]];
    
}


#pragma mark Subclassing
-(NSString*)requestStrUrl{
    return [[HSURLBusiness sharedURL] getNewsDetailsUrl];
}

-(NSMutableArray*)requestArrData{
    NSMutableArray* muArr =[super requestArrData];
    [muArr removeAllObjects];
    if (self.messageid) {
        [muArr addObject:[@"messageid=" stringByAppendingString:self.messageid]];
    }
    return muArr;
}


-(void)updateUI{
    if (self.reDataArr && self.reDataArr.count == 1) {
        //设置为已读
        NSString* strUrl = [[HSURLBusiness sharedURL] getNewsUnreadConvertReadUrl];
        strUrl = [strUrl stringByAppendingString:[@"&messageid=" stringByAppendingString:self.messageid]];
        [self.operation requestByUrl:[NSURL URLWithString:strUrl] successHandler:^(NSData *data) {
            [[NSNotificationCenter defaultCenter] postNotificationName:KNewsConvertRead object:nil];
        } errorHandler:^(NSError *error) {
            
        }];
        
        HSDataNewsDetailModel* modelData = [[HSDataNewsDetailModel alloc] init];
        [modelData setDataByDictionary:[self.reDataArr firstObject]];
        [self setTableViewCell:newsCell modelData:modelData];
        newsCell.frame = CGRectMake(0, 0, self.view.frame.size.width, [newsCell getCellViewHeight]);
        textView.text = modelData.content;
        
        float off_h = [newsCell getCellViewHeight] + addresseeView.frame.size.height;
        textView.frame = CGRectMake(0, off_h, self.view.frame.size.width, self.view.frame.size.height - off_h);
    }
  
}


@end
