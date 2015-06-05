//
//  HSTodoListViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/2/26.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSTodoListViewController.h"
#import "HSUtils.h"
#import "HSTodoDetailViewController.h"
#import "HSDoneDetailViewController.h"
#import "HSTodoCell.h"
#import "HSDetailTableViewCell.h"
#import "HSDataModel.h"
#import "MJRefresh.h"

@interface HSTodoListViewController(){
    HSTodoCell *cellHeight_db;
    HSDetailTableViewCell *cellHeight_yb;
    
    NSMutableArray* dataArr_db;
    NSMutableArray* dataArr_yb;
    
    int page_db;
    int page_yb;
}

@end

@implementation HSTodoListViewController

@synthesize pageType;

- (id)init{
    self = [super init];
    if (self) {
        self.isTopView = YES;
        self.isAddData = YES;
        self.isUseNoDataView = YES;
        page_db = 1;
        page_yb = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    cellHeight_db = [[HSTodoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell_db"];
    [cellHeight_db setCellWidth:self.view.frame.size.width];
    
    cellHeight_yb = [[HSDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell_yb"];
    [cellHeight_yb setMiddleOff:0.0f];
    [cellHeight_yb setIsTitleLong:YES];
    [cellHeight_yb setCellWidth:self.view.frame.size.width];
    
    dataArr_db = [[NSMutableArray alloc] init];
    dataArr_yb = [[NSMutableArray alloc] init];
    
    pageType = HSPageToDoType;
}

-(void)addTopView{
    [super addTopView];
    [self.topView  setBackgroundColor:[HSColor getColorByColorNavigation]];
    self.topView.frame = CGRectMake(self.topView.frame.origin.x, self.topView.frame.origin.y, self.topView.frame.size.width, self.topView.frame.size.height - 10);
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"待办",@"已办"]];
    segmentedControl.frame = CGRectMake(KBoundaryOFF, (self.topView.frame.size.height - 30)/2, self.topView.frame.size.width - 2*KBoundaryOFF, 30);
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    [self.topView addSubview:segmentedControl];
   
    segmentedControl.tintColor = [UIColor whiteColor];
    [segmentedControl addTarget:self action:@selector(segmentedClick:) forControlEvents:UIControlEventValueChanged];
    
    [self setNoDataViewRectY:self.topView.frame.size.height];
}

-(void)addNoDataView{
    [self.noDataView removeFromSuperview];
    self.noDataView = nil;
    self.noDataView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.noDataView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.noDataView];
    [self.view bringSubviewToFront:self.noDataView];
    [self noDataViewHide];
    
    UIImage* img = [[HSUtils sharedUtils] getImageNamed:@"default_01.png"];
    UIImageView* imgView = [[UIImageView alloc] initWithImage:img];
    imgView.center = CGPointMake(self.noDataView.frame.size.width/2, img.size.height/2 - 30 + KNavigationAddstatusHeight);
    [self.noDataView addSubview:imgView];
    
    UILabel* nodataLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.noDataView.frame.size.width, 30)];
    nodataLab.text= @"暂无待办事项！";
    nodataLab.textAlignment = NSTextAlignmentCenter;
    [nodataLab setFont:[UIFont systemFontOfSize:14]];
    [nodataLab setTextColor:[UIColor grayColor]];
    nodataLab.center = CGPointMake(self.noDataView.frame.size.width/2, img.size.height- 20 + KNavigationAddstatusHeight);
    [self.noDataView addSubview:nodataLab];
    
    [self setNoDataViewRectY:self.topView.frame.size.height];
}

-(void)addDoneNoDataView{
    [self.noDataView removeFromSuperview];
    self.noDataView = nil;
    self.noDataView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.noDataView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.noDataView];
    [self.view bringSubviewToFront:self.noDataView];
    [self noDataViewHide];
    
    UIImage* img = [[HSUtils sharedUtils] getImageNamed:@"default_02.png"];
    UIImageView* imgView = [[UIImageView alloc] initWithImage:img];
    imgView.center = CGPointMake(self.noDataView.frame.size.width/2 - 45, img.size.height/2 - 30 + KNavigationAddstatusHeight);
    [self.noDataView addSubview:imgView];
    
    UILabel* nodataLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
    nodataLab.text= @"没有数据 ";
    nodataLab.numberOfLines = 2;
    nodataLab.textAlignment = NSTextAlignmentLeft;
    [nodataLab setFont:[UIFont systemFontOfSize:13]];
    [nodataLab setTextColor:[UIColor grayColor]];
    nodataLab.center = CGPointMake(self.noDataView.frame.size.width/2 + 45, img.size.height/2 - 30 + KNavigationAddstatusHeight);
    [self.noDataView addSubview:nodataLab];
    
    [self setNoDataViewRectY:self.topView.frame.size.height];
}

#pragma mark Subclassing
-(NSString*)requestStrUrl{
    NSString* reStr = [[HSURLBusiness sharedURL] getProcWillDoListUrl];
    switch (pageType) {
        case HSPageToDoType:
            self.totalCount = _tempTotalCount;
            reStr = [[HSURLBusiness sharedURL] getProcWillDoListUrl];
            break;
        case HSPageDoneToDoType:
            self.totalCount = KDownLoadTotalCount;
            reStr = [[HSURLBusiness sharedURL] getProcDidDoListUrl];
            break;
        default:
            NSLog(@"页面信息错误");
            break;
    }
    return reStr;
}

-(BOOL)refreshData{
    switch (pageType) {
        case HSPageToDoType:
        {
            [self addNoDataView];
        }
            break;
        case HSPageDoneToDoType:
        {
            [self addDoneNoDataView];
        }
            break;
        default:
            break;
    }
    
    if (self.reDataArr && self.reDataArr.count > 0) {
        [self noDataViewHide];
        return YES;
    }else{
        [self noDataViewShow];
    }
    return NO;
}

-(void)updateUI{
    switch (pageType) {
        case HSPageToDoType:
        {
            page_db = self.page;
            [dataArr_db removeAllObjects];
            for (NSDictionary* dic in self.reDataArr) {
                HSDataWillDoModel* modelData = [[HSDataWillDoModel alloc] init];
                [modelData setDataByDictionary:dic];
                [dataArr_db addObject:modelData];
            }
        }
            break;
        case HSPageDoneToDoType:
        {
            [self noDataViewHide];
            page_yb = self.page;
            [dataArr_yb removeAllObjects];
            for (NSDictionary* dic in self.reDataArr) {
                HSDataDidDoModel* modelData = [[HSDataDidDoModel alloc] init];
                [modelData setDataByDictionary:dic];
                [dataArr_yb addObject:modelData];
            }
        }
            break;
        default:
            break;
    }
    [self.pullTableView reloadData];
}

-(NSMutableArray*)requestArrData{
    NSMutableArray* muArr =[super requestArrData];
    if (_flowtype) {
        muArr.count >= 3 ? [muArr removeLastObject] : NO;
        switch (pageType) {
            case HSPageToDoType:
                [muArr addObject:[@"flowtype=" stringByAppendingString:_flowtype]];
                break;
            case HSPageDoneToDoType:
                [muArr addObject:[@"flowtype=" stringByAppendingString:_flowtype]];
                break;
            default:
                break;
        }
    }

    return muArr;
}

#pragma mark UITableView的委托方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellString_db = @"Cell_db";
    static NSString *cellString_yb = @"Cell_yb";
    UITableViewCell* cell = nil;
    switch (pageType) {
        case HSPageToDoType:
        {
            cell = (HSTodoCell*)[tableView dequeueReusableCellWithIdentifier:cellString_db];
            if (cell == nil) {
                cell = [[HSTodoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString_db];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [(HSTodoCell*)cell setCellWidth:self.view.frame.size.width];
            }
            if (dataArr_db && dataArr_db.count > indexPath.row) {
                HSDataWillDoModel* modelData = [dataArr_db objectAtIndex:indexPath.row];
                [self setTableViewCell_db:(HSTodoCell*)cell modelData:modelData];
            }
        }
            break;
        case HSPageDoneToDoType:
        {
            cell =(HSDetailTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellString_yb];
            if (cell == nil) {
                cell = [[HSDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString_yb];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [(HSDetailTableViewCell*)cell setCellWidth:self.view.frame.size.width];
                [(HSDetailTableViewCell*)cell setMiddleOff:0.0f];
                [(HSDetailTableViewCell*)cell setIsTitleLong:YES];
            }
            if (dataArr_yb && dataArr_yb.count > indexPath.row) {
                HSDataDidDoModel* modelData = [dataArr_yb objectAtIndex:indexPath.row];
                [self setTableViewCell_yb:(HSDetailTableViewCell*)cell modelData:modelData];
            }
        }
            break;
            
        default:
            break;
    }

    return cell;
}


//对应的section有多少行row
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int integer = 0 ;
    switch (pageType) {
        case HSPageToDoType:
            integer = [dataArr_db count];
            break;
        case HSPageDoneToDoType:
            integer = [dataArr_yb count];
            break;
        default:
            break;
    }
    return integer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float h = KCellHeight;
  
    switch (pageType) {
        case HSPageToDoType:
        {
            HSDataWillDoModel* modelData = [dataArr_db objectAtIndex:indexPath.row];
            [self setTableViewCell_db:cellHeight_db modelData:modelData];
            h = [cellHeight_db getCellViewHeight];
        }
            break;
        case HSPageDoneToDoType:
        {
            HSDataDidDoModel* modelData = [dataArr_yb objectAtIndex:indexPath.row];
            [self setTableViewCell_yb:cellHeight_yb modelData:modelData];
            h = [cellHeight_yb cellHeight];
        }
            break;
        default:
            break;
    }
    
    return h;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (pageType) {
        case HSPageToDoType:
        {
            if (!(dataArr_db && dataArr_db.count > indexPath.row)) {
                return;
            }
            HSDataWillDoModel* modelData = [dataArr_db objectAtIndex:indexPath.row];
            HSTodoDetailViewController * todoDetail = (HSTodoDetailViewController*)[[HSViewControllerFactory sharedFactory] getViewController:HSMPageTodoDetailVC isReload:YES];
            todoDetail.taskid = modelData.taskId;
            todoDetail.flowtype = self.flowtype;
            todoDetail.instanceid = modelData.instanceId;
            [self.navigationController pushViewController:todoDetail animated:YES];
        }
            break;
        case HSPageDoneToDoType:
        {
            if (!(dataArr_yb && dataArr_yb.count > indexPath.row)) {
                return;
            }
            HSDataDidDoModel* modelData = [dataArr_yb objectAtIndex:indexPath.row];
            HSDoneDetailViewController * todoDetail = (HSDoneDetailViewController*)[[HSViewControllerFactory sharedFactory] getViewController:HSMPageDoneDetailVC isReload:YES];
            todoDetail.taskid = modelData.taskId;
            todoDetail.instanceid = modelData.instanceId;
            [self.navigationController pushViewController:todoDetail animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)setTableViewCell_db:(HSTodoCell*)cell modelData:(HSDataWillDoModel*)modelData{
    [cell setTitleStr:modelData.flowName];
    [cell setDetailStr:modelData.starterName?[@"发起人:" stringByAppendingString:modelData.starterName]:@""];
//    [cell setDateStr:modelData.startTime?[@"发起时间:" stringByAppendingString:modelData.startTime]:@""];
    [cell setDateStr:modelData.startTime];

    if ([[HSModel sharedHSModel] appSystem] == HSAppSystemStock) {
        [cell setProcessBackColor:[[HSBusinessAnalytical sharedBusinessAnalytical] getProcessColorHsstr:modelData.taskType]];
        [cell setProcessTypeStr:modelData.taskType.length > 1? modelData.taskType : @""];
    }else if([[HSModel sharedHSModel] appSystem] == HSAppSystemBond){
        [cell setProcessTypeStr:nil];
    }

    [cell layoutData];
}

-(void)setTableViewCell_yb:(HSDetailTableViewCell*)cell modelData:(HSDataDidDoModel*)modelData{
    [cell.titleLab setText:modelData.flowName];
    [cell.detailsLab setText:modelData.starterName?[@"发起人:" stringByAppendingString:modelData.starterName]:@""];
    [cell.valueLab setText:modelData.startTime?[@"发起时间:" stringByAppendingString:modelData.startTime]:@""];
    cell.valueLab.font = [UIFont systemFontOfSize:14];
//    cell.valueLab.textColor = [UIColor grayColor];
 
    [cell.imgView setImage:[[HSUtils sharedUtils] getImageNamed:@"label_01.png"]];
    [cell setImgStateLabel:modelData.flowStatus labcolor:nil];
    NSString* nodename = modelData.nodeName;
    if(nodename && nodename.length > 0 && ![nodename isEqualToString:@""]){
        [cell setCurrentNodeStr:[@"当前节点:" stringByAppendingString:nodename]];
    }else{
        [cell setCurrentNodeStr:nil];
    }
}

#pragma mack  segmentedClick
-(void)segmentedClick:(UISegmentedControl*)seg{
    int index = seg.selectedSegmentIndex;
    if (0 == index) {
        self.page = page_db;
        pageType = HSPageToDoType;
        self.totalCount = _tempTotalCount;

        if (dataArr_db == nil || dataArr_db.count < 1) {
            [self resetData];//重置数据
            [self requestSafe];
        }
    }else if (1 == index){
        [self noDataViewHide];
        self.page = page_yb;
        pageType = HSPageDoneToDoType;
        self.totalCount = KDownLoadTotalCount;
        if (dataArr_yb == nil || dataArr_yb.count < 1) {
            [self resetData];//重置数据
            [self requestSafe];
        }
    }
    [self.pullTableView reloadData];
}

@end
