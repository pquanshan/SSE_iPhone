//
//  HSSearchViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/4/5.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSSearchViewController.h"
//#import "HSDetailTableViewCell.h"
#import "HSDataModel.h"
#import "HSLoadingView.h"
#import "HSPublicInfoDetailViewController.h"
#import "MJRefresh.h"


@interface HSSearchViewController ()<UISearchBarDelegate,HSPHttpRequestDelegate>{
    UILabel* noDataLabell;
    UISearchBar* searchbar;
    NSMutableArray* itmeArr;
}

@end

@implementation HSSearchViewController

-(id)init{
    self = [super init];
    if (self) {
        self.isTopView = YES;
        itmeArr = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)viewDidDisappear:(BOOL)animated{
    [[HSLoadingView shareLoadingView] close];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:KCorolBackViewLLWhite];
    self.navigationItem.title = @"搜索";
    
    noDataLabell = [[UILabel alloc] initWithFrame:CGRectMake(10, searchbar.frame.size.height, self.view.frame.size.width - 20, 50)];
    noDataLabell.text = @"查询不到信息";
    noDataLabell.textAlignment = NSTextAlignmentCenter;
    noDataLabell.font = [UIFont boldSystemFontOfSize:18];
    noDataLabell.textColor = [UIColor lightGrayColor];
    noDataLabell.hidden = YES;
    [self.view addSubview:noDataLabell];
    self.pullTableView.tableFooterView = [[UIView alloc] init];
    self.pullTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.pullTableView.rowHeight = 60;
    
    [self.pullTableView removeHeader];
    [self.pullTableView removeFooter];
}

-(void)addTopView{
    [super addTopView];
    [self.topView  setBackgroundColor:[HSColor getColorByColorNavigation]];
    self.topView.frame = CGRectMake(self.topView.frame.origin.x, self.topView.frame.origin.y, self.topView.frame.size.width, self.topView.frame.size.height - 10);
    
    searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [searchbar setTranslucent:YES];
    [searchbar sizeToFit];
    searchbar.delegate = self;
    if ([[HSModel sharedHSModel] appSystem] == HSAppSystemStock) {
        searchbar.placeholder = @"搜索:项目、保荐机构";
    }else if ([[HSModel sharedHSModel] appSystem] == HSAppSystemBond){
        searchbar.placeholder = @"搜索:项目、承销机构";
    }
    
    [self.view addSubview:searchbar];
    [self.topView addSubview:searchbar];
}

#pragma mark Subclassing
-(BOOL)isAutomaticRequest{
    return NO;
}

-(void)requestSafe{
    NSString* strUrl = [[HSURLBusiness sharedURL] getPublicityListUrl];
    HSPHttpOperationManagers* operation = [[HSPHttpOperationManagers alloc] init];
    operation.delegate = self;
    if (strUrl == nil) {
        return;
    }
    NSMutableString* postStr = [[NSMutableString alloc] initWithString:strUrl];
    if ([[HSModel sharedHSModel] isReachable]) {
        [[HSLoadingView shareLoadingView] show];
        if (self.projectname) {
            NSMutableArray* muArr = [[NSMutableArray alloc] initWithArray:[self requestArrData]];
            [muArr addObject:[@"projectname=" stringByAppendingString:self.projectname]];
            [operation addRequestByKey:[NSURL URLWithString:postStr] type:[self requestType] data:muArr];
        }
        if ([[HSModel sharedHSModel] appSystem] == HSAppSystemStock) {
            if (self.sponsor) {
                NSMutableArray* muArr = [[NSMutableArray alloc] initWithArray:[self requestArrData]];
                [muArr addObject:[@"sponsor=" stringByAppendingString:self.sponsor]];
                [operation addRequestByKey:[NSURL URLWithString:postStr] type:[self requestType] data:muArr];
            }
        }else if ([[HSModel sharedHSModel] appSystem] == HSAppSystemBond){
            if (self.underwriter) {
                NSMutableArray* muArr = [[NSMutableArray alloc] initWithArray:[self requestArrData]];
                [muArr addObject:[@"underwriter=" stringByAppendingString:self.underwriter]];
                [operation addRequestByKey:[NSURL URLWithString:postStr] type:[self requestType] data:muArr];
            }
        }
        
        
        [operation executionQueue];
    }else{
        [HSUtils showAlertMessage:@"提示" msg:@"网络连接异常" delegate:nil];
    }
    
}

-(NSMutableArray*)requestArrData{
    return [super requestArrData];
}

#pragma mark UITableView的委托方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellString = @"Cell";
    //    HSDetailTableViewCell *cell =(HSDetailTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellString];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellString];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.textLabel.numberOfLines = 2;
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    
    if (self.reDataArr && self.reDataArr.count > indexPath.row) {
        HSDataPublicInfoModel* modelData = [self.reDataArr objectAtIndex:indexPath.row];
        cell.textLabel.text = modelData.projectName;
        NSArray* dataStrArr = [modelData.sponsor componentsSeparatedByString:@","];
        NSString* sponsor = @"";
        for (NSString* strItme in dataStrArr) {
            if([strItme rangeOfString:searchbar.text].location !=NSNotFound){
                sponsor = strItme;
                break;
            }
        }
        if (sponsor.length < 1) {
            sponsor = [dataStrArr firstObject];
        }
        
        cell.detailTextLabel.text = sponsor;
    }
    
    return cell;
}

//对应的section有多少行row
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reDataArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HSPublicInfoDetailViewController * infoDetail = (HSPublicInfoDetailViewController*)[[HSViewControllerFactory sharedFactory] getViewController:HSMPagePublicInfoDetailVC isReload:YES];
    HSDataPublicInfoModel* modelData = [self.reDataArr objectAtIndex:indexPath.row];
    infoDetail.projectcode = modelData.projectCode;
    infoDetail.projectid = modelData.projectId;
    [self.navigationController pushViewController:infoDetail animated:YES];
}

#pragma mark  UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString* searchStr = searchBar.text;
    if (![HSUtils isEmpty:searchStr isStrong:YES]) {
        [self resetData];
        //        [self.reDataArr removeAllObjects];
        //        [self.requestArr removeAllObjects];
        _projectname = searchStr;
        _sponsor = searchStr;
        _underwriter = searchStr;
        [self requestSafe];
    }
}

#pragma mark  HSPHttpRequestDelegate
-(void)requestFinish:(NSDictionary *)dicData{
    [[HSLoadingView shareLoadingView] close];
    [self.pullTableView headerEndRefreshing];
    [self.pullTableView footerEndRefreshing];
    self.isRereshing = NO;
    [searchbar resignFirstResponder];
    if (self.reDataArr.count < 1) {
        noDataLabell.hidden = NO;
        [self.pullTableView removeFooter];
    }else{
        noDataLabell.hidden = YES;
        [self.pullTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    }
    
    itmeArr.count > 0 ? NO: self.page--;
    [itmeArr removeAllObjects];
    
    [self.pullTableView reloadData];
}

- (void)footerRereshing{
    [super footerRereshing];
}


-(void)requestFailed:(NSDictionary *)dicData{
    [[HSLoadingView shareLoadingView] close];
    [self.pullTableView headerEndRefreshing];
    [self.pullTableView footerEndRefreshing];
    [itmeArr removeAllObjects];
    self.isRereshing = NO;
    self.page--;
    BOOL bl = [[dicData objectForKey:@"requestDataCode"] boolValue];
    if (bl) {
        id redata = [dicData objectForKey:@"requestData"];
        if ([redata isKindOfClass:[NSString class]]) {
            [HSUtils showAlertMessage:@"提示" msg:(NSString*)redata delegate:nil];
        }
    }else{
        NSError* error = [dicData objectForKey:@"error"];
        if (error) {
            NSString* errorStr = [[NSString alloc] initWithFormat:@"Error code = %d\n %@",error.code, [error.userInfo objectForKey:@"NSLocalizedDescription"]];
            [HSUtils showAlertMessage:@"提示" msg:errorStr delegate:nil];
        }else{
            [HSUtils showAlertMessage:@"提示" msg:@"数据请求失败(nil)\n 1,请检查您的网络连接状态。\n 2,请检查服务器开启状态。" delegate:nil];
        }
    }
}

-(void)requestItmeFinish:(NSDictionary *)dicData{
    id redata = [dicData objectForKey:@"requestData"];
    if ([redata isKindOfClass:[NSArray class]]) {
        BOOL bl = [[dicData objectForKey:@"requestDataCode"] boolValue];
        if (bl) {
            for (NSDictionary* newDic in (NSArray*)redata) {
                HSDataPublicInfoModel* newmodelData = [[HSDataPublicInfoModel alloc] init];
                [newmodelData setDataByDictionary:newDic];
                BOOL isAdd = YES;
                for (HSDataPublicInfoModel* modelData in self.reDataArr) {
                    if ([newmodelData.projectId isEqualToString:modelData.projectId] ||
                        [newmodelData.projectCode isEqualToString:modelData.projectCode]) {
                        isAdd = NO;
                        break;
                    }
                }
                isAdd ? [self.reDataArr addObject:newmodelData] : NO;
                [itmeArr addObject:newmodelData];
            }
        }
    }
}

@end
