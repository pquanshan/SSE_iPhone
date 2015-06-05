//
//  HSDoneListViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/2/26.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSDoneListViewController.h"
#import "HSPqsTableViewCell.h"
#import "HSDoneDetailViewController.h"

@interface HSDoneListViewController (){
    HSPqsTableViewCell *cellHeight;
}

@end

@implementation HSDoneListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"已办";
    cellHeight = [[HSPqsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    [cellHeight setCellWidth:self.view.frame.size.width];
    cellHeight.isRightView = YES;
    cellHeight.isAutomaticHeight = YES;
    self.isAddData = YES;
}
    

#pragma mark Subclassing
-(NSString*)requestStrUrl{
    return [[HSURLBusiness sharedURL] getProcDidDoListUrl];
}

-(void)updateUI{
    [self.pullTableView reloadData];
}

#pragma mark UITableView的委托方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellString = @"Cell";
    HSPqsTableViewCell *cell =(HSPqsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellString];
    
    if (cell == nil) {
        cell = [[HSPqsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellWidth:self.view.frame.size.width];
        cell.isRightView = YES;
        cell.isAutomaticHeight = YES;
    }
    NSDictionary* dic = [self.reDataArr objectAtIndex:indexPath.row];
    [self setTableViewCell:cell dic:dic];
    NSString* flowstatus = [dic objectForKey:@"flowstatus"];
    [self setRightView:cell status:flowstatus];
    
    return cell;
}

-(void)setRightView:(HSPqsTableViewCell *)tableViewCell status:(NSString *)status{
    UIImageView *imageStatus = (UIImageView *)[tableViewCell.rightView viewWithTag:1000];
    if (imageStatus == nil) {
        float w = [[HSUtils sharedUtils] getImageNamed:@"tipe_01"].size.width * 1.3 ;
        float h = [[HSUtils sharedUtils] getImageNamed:@"tipe_01"].size.height * 1.3;
        imageStatus = [[UIImageView alloc] initWithFrame:CGRectMake((tableViewCell.rightView.frame.size.width - w)/2.0, (tableViewCell.rightView.frame.size.height - h)/2.0 - 8, w, h)];
        imageStatus.transform = CGAffineTransformMakeRotation(-18.0f/180.0f);
        imageStatus.tag = 1000;
        imageStatus.contentMode = UIViewContentModeScaleToFill;
        imageStatus.layer.shadowOffset =CGSizeMake(0,2);
        imageStatus.layer.shadowRadius =2.0;
        imageStatus.layer.shadowColor =[UIColor whiteColor].CGColor;
        imageStatus.layer.shadowOpacity =0.8;
        imageStatus.layer.borderColor =[UIColor clearColor].CGColor;
        imageStatus.layer.borderWidth =2.0;
        imageStatus.layer.cornerRadius =3.0;
        [imageStatus.layer setShouldRasterize:YES];
        
        [tableViewCell.rightView addSubview:imageStatus];
    }
    
    UILabel *labelStatus = (UILabel *)[imageStatus viewWithTag:1001];
    if (labelStatus == nil) {
        labelStatus = [[UILabel alloc] init];
        labelStatus.transform = CGAffineTransformMakeRotation(-4.0f/180.0f);
        [labelStatus setTextColor:[UIColor whiteColor]];
        labelStatus.tag = 1001;
        labelStatus.textAlignment = NSTextAlignmentCenter;
        [imageStatus addSubview:labelStatus];
    }
    labelStatus.frame = imageStatus.bounds;
    labelStatus.text =status;
    if([@"批准" isEqualToString:status]){
        imageStatus.image = [[HSUtils sharedUtils] getImageNamed:@"tipe_01.png"];
    }else if([@"正在运行" isEqualToString:status]){
        imageStatus.image = [[HSUtils sharedUtils] getImageNamed:@"tipe_02.png"];
    }else if([@"否决" isEqualToString:status]){
        imageStatus.image = [[HSUtils sharedUtils] getImageNamed:@"tipe_03.png"];
    }else{
        imageStatus.image = [[HSUtils sharedUtils] getImageNamed:@"tipe_03.png"];
    }
}


-(void)setTableViewCell:(HSPqsTableViewCell*)cell dic:(NSDictionary*)dic{
    [cell.titleLabel setText:[dic objectForKey:@"flowname"]];
    NSString* starter = [dic objectForKey:@"starter"];
    starter != nil ? starter = [@"发起人:" stringByAppendingString:starter] : NO;
    NSString* starttime = [dic objectForKey:@"starttime"];
    starttime != nil ? starttime = [@"发起时间:" stringByAppendingString:starttime] : NO ;
    NSString* startorg = [dic objectForKey:@"startorg"];
    startorg != nil ? startorg = [@"发起人部门:" stringByAppendingString:startorg] : NO ;
    NSString* assigneename = [dic objectForKey:@"assigneename"];
    assigneename != nil ? assigneename = [@"当前处理人:" stringByAppendingString:assigneename] : NO ;
    NSString* nodename = [dic objectForKey:@"nodename"];
    nodename != nil ? nodename = [@"当前处理节点:" stringByAppendingString:nodename] : NO ;
    NSArray* arr = [[NSArray alloc] initWithObjects:starter,starttime,startorg,assigneename,nodename, nil];
    [cell setLabelArr:arr];
}

//对应的section有多少行row
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reDataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* dic = [self.reDataArr objectAtIndex:indexPath.row];
    [self setTableViewCell:cellHeight dic:dic];
    return [cellHeight getDetailTableViewCellHeight];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* dic = [self.reDataArr objectAtIndex:indexPath.row];
    NSString* instanceid =  [[NSString alloc] initWithFormat:@"instanceid=%@",[dic objectForKey:@"instanceid"]];
    HSDoneDetailViewController * todoDetail = (HSDoneDetailViewController*)[[HSViewControllerFactory sharedFactory] getViewController:HSMPageDoneDetailVC isReload:YES];
    todoDetail.navTitle = [dic objectForKey:@"processname"];
    todoDetail.instanceid = [dic objectForKey:@"instanceid"];
    todoDetail.instanceid = instanceid;
    [self.navigationController pushViewController:todoDetail animated:YES];
}

@end
