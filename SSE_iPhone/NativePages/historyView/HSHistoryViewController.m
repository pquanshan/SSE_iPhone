//
//  HSHistoryViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/2/26.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSHistoryViewController.h"
#import "HSHistoryTableViewCell.h"
#import "HSDataModel.h"

@interface HSHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tabview;
    HSHistoryTableViewCell* cellHeight;
    NSMutableArray* modelDataArr;
}

@end

@implementation HSHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"审批历史";
    modelDataArr = [[NSMutableArray alloc] init];
    cellHeight = [[HSHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    [cellHeight setCellWidth:self.view.frame.size.width];
    
    [self addTabview];
}

-(void)addTabview{
    tabview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - KNavigationAddstatusHeight) style:UITableViewStylePlain];
    [tabview setBackgroundColor:[UIColor whiteColor]];
    tabview.delegate=self;
    tabview.dataSource=self;
    tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tabview];
    [tabview reloadData];
}

#pragma mark Subclassing
-(NSString*)requestStrUrl{
    return [[HSURLBusiness sharedURL] getProcHistoryOpinionUrl];
}

-(void)updateUI{
    [modelDataArr removeAllObjects];
    for (NSDictionary* dic in self.reDataArr) {
        HSDataHistoryOpiModel* modelData = [[HSDataHistoryOpiModel alloc] init];
        [modelData setDataByDictionary:dic];
        [modelDataArr addObject:modelData];
    }
    [tabview reloadData];
}

-(NSMutableArray*)requestArrData{
    NSMutableArray* muArr =[super requestArrData];
    [muArr removeAllObjects];
    if (self.instanceid) {
        [muArr addObject:[@"instanceid=" stringByAppendingString:self.instanceid]];
    }
    return muArr;
}

#pragma mark UITableView的委托方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellString = @"Cell";
    HSHistoryTableViewCell *cell =(HSHistoryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellString];
    
    if (cell == nil) {
        cell = [[HSHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellWidth:tabview.frame.size.width];
    }
    HSDataHistoryOpiModel* modelData = [modelDataArr objectAtIndex:indexPath.row];
    [self setTableViewCell:cell modelData:modelData];
    
    return cell;
}

-(void)setTableViewCell:(HSHistoryTableViewCell*)cell modelData:(HSDataHistoryOpiModel*)modelData{
    [cell setTitleLabText:modelData.nodeName];
    [cell setNameLabText:modelData.approveUser];
    [cell setDateLabText:modelData.approveTime];
    NSString* remark = modelData.remark;
    NSArray* remarkArr = [[HSBusinessAnalytical sharedBusinessAnalytical]getRemarkArrByHsstr:remark];
    if (remarkArr && remarkArr.count == 2) {
        NSLog(@"remarkArr = %@",remarkArr);
        [cell setOpinionLabText:[remarkArr firstObject]];
        [cell setOpinionBackViewColor:[[HSBusinessAnalytical sharedBusinessAnalytical] getRemarkyColorHsstr:[remarkArr firstObject]]];
        [cell setIsExplain:YES];
        [cell setExplainLabText:[remarkArr lastObject]];
    }else{
        if (remark && remark.length > 0) {
            [cell setOpinionLabText:remark];
            [cell setOpinionBackViewColor:[[HSBusinessAnalytical sharedBusinessAnalytical] getRemarkyColorHsstr:remark]];
            [cell setIsExplain:NO];
        }else{
            [cell setOpinionLabText:nil];
            [cell setIsExplain:NO];
        }
    }
    
//    NSString* attach = modelData.attach;
//    if (attach && ![attach isEqualToString:@"[]"] ) {//存在附件
//        [cell setIsRemarks:YES];
//        [cell setRemarksLabText:attach];
//    }else{
//        [cell setIsRemarks:NO];
//    }
    [cell synchronousCellView];
}

//对应的section有多少行row
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reDataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HSDataHistoryOpiModel* modelData = [modelDataArr objectAtIndex:indexPath.row];
    [self setTableViewCell:cellHeight modelData:modelData];
    return [cellHeight getCellViewHeight];
}



@end
