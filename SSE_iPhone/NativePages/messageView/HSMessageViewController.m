//
//  HSMessageViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/5.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSMessageViewController.h"
#import "HSNewsTableViewCell.h"
#import "HSMsgDetailViewController.h"
#import "HSBusinessAnalytical.h"
#import "HSDataModel.h"

@interface HSMessageViewController ()<UITableViewDelegate, UITableViewDataSource>{
    HSNewsTableViewCell *cellHeight;
    NSMutableArray* modelDataArr;
}

@end

@implementation HSMessageViewController

- (void)viewWillAppear:(BOOL)animated{
    [self.pullTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isUseNoDataView = YES;
    // Do any additional setup after loading the view.
    modelDataArr = [[NSMutableArray alloc] init];
    self.navigationItem.title = @"消息";
    cellHeight = [[HSNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    [cellHeight setCellWidth:self.view.frame.size.width];
    self.isAddData = YES;
    
    self.pullTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - KBottomTabBarHeight - KNavigationAddstatusHeight);
}

#pragma mark Subclassing
-(NSString*)requestStrUrl{
    return [[HSURLBusiness sharedURL] getNewsListUrl];
}

-(void)updateUI{
    [modelDataArr removeAllObjects];
    for (NSDictionary* dic in self.reDataArr) {
        HSDataNewsModel* modelData = [[HSDataNewsModel alloc] init];
        [modelData setDataByDictionary:dic];
        [modelDataArr addObject:modelData];
    }
    [self.pullTableView reloadData];
}

#pragma mark UITableView的委托方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellString = @"Cell";
    HSNewsTableViewCell *cell =(HSNewsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellString];
    
    if (cell == nil) {
        cell = [[HSNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellWidth:self.view.frame.size.width];
    }
    if (modelDataArr && modelDataArr.count > indexPath.row) {
        HSDataNewsModel* modelData = [modelDataArr objectAtIndex:indexPath.row];
        [self setTableViewCell:cell modelData:modelData];
    }

    return cell;
}

-(void)setTableViewCell:(HSNewsTableViewCell*)cell modelData:(HSDataNewsModel*)modelData{
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
    [cell setIsMark:![modelData.isread boolValue]];
    
    int mack = [modelData.mark intValue];
    [cell.iconImg setImage:[[HSBusinessAnalytical sharedBusinessAnalytical] getNewsIconHsint:mack]];
    [cell layoutData];
}

//对应的section有多少行row
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reDataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (modelDataArr && modelDataArr.count > indexPath.row) {
        HSDataNewsModel* modelData = [modelDataArr objectAtIndex:indexPath.row];
        [self setTableViewCell:cellHeight modelData:modelData];
        return [cellHeight getCellViewHeight];
    }
    return 44;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HSDataNewsModel* modelData = [modelDataArr objectAtIndex:indexPath.row];
    modelData.isread = @"1";
    HSMsgDetailViewController * msgDetail = (HSMsgDetailViewController*)[[HSViewControllerFactory sharedFactory] getViewController:HSMPageMsgDetailVC isReload:YES];
    msgDetail.navTitle = @"消息详情";
    msgDetail.messageid = modelData.messageid;
    [self.navigationController pushViewController:msgDetail animated:YES];
}



@end
