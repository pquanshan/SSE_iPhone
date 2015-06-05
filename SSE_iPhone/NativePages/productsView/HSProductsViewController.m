//
//  HSProductsViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/5.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSProductsViewController.h"
#import "HSProjectTableViewCell.h"
#import "HSProDetailViewController.h"
#import "HSRegisterDataKey.h"
#import "HSDataModel.h"

@interface HSProductsViewController ()<UISearchBarDelegate>{
    UISearchBar* searchBar;
    NSArray *productTypeArr;
    NSMutableDictionary* tempDicData;//tab下的数据
    NSMutableDictionary* tempDicDataPage;//当前tab下显示多少页
    NSMutableDictionary* searTitelDicData;
    NSArray* currentDataArr;
    
    NSString* productType;
    NSString* projectname;
    
}

@end

@implementation HSProductsViewController

- (id)init{
    self = [super init];
    if (self) {
        self.isTopView = YES;
        self.isAddData = YES;
        if ([[HSModel sharedHSModel] appSystem] == HSAppSystemStock) {
            productType = @"1";
        }else if ([[HSModel sharedHSModel] appSystem] == HSAppSystemBond){
            productType = @"0";
        }
       
        projectname = nil;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"产品";
    
    searchBar = [[UISearchBar alloc] init];
    [searchBar setTranslucent:YES];
    [searchBar sizeToFit];
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索";
    self.pullTableView.tableHeaderView = searchBar;
    
    tempDicData = [[NSMutableDictionary alloc] init];
    tempDicDataPage = [[NSMutableDictionary alloc] init];
    searTitelDicData = [[NSMutableDictionary alloc] init];
}

-(void)viewDidAppear:(BOOL)animated{
    self.pullTableView.frame = CGRectMake(0, self.topView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.topView.frame.size.height);
}

//-(void)viewWillAppear:(BOOL)animated{
//    [searchBar resignFirstResponder];
//}

-(void)viewDidDisappear:(BOOL)animated{
    [searchBar resignFirstResponder];
}

-(void)addTopView{
    [super addTopView];
    [self.topView  setBackgroundColor:[HSColor getColorByColorNavigation]];
    self.topView.frame = CGRectMake(self.topView.frame.origin.x, self.topView.frame.origin.y, self.topView.frame.size.width, self.topView.frame.size.height - 10);
    
    productTypeArr = [[HSRegisterDataKey sharedRegisterDataKey] getProjectTypeKey];
    NSMutableArray* segmentedArray = [[NSMutableArray alloc] init];
    for (NSDictionary* dic in productTypeArr) {
        [segmentedArray addObject:[dic.allKeys firstObject]];
    }
    
    NSDictionary* dic = [productTypeArr objectAtIndex:0];
    productType = [dic objectForKey: [[dic allKeys] firstObject]];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(KBoundaryOFF, (self.topView.frame.size.height - 30)/2, self.topView.frame.size.width - 2*KBoundaryOFF, 30);
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    [self.topView addSubview:segmentedControl];
    segmentedControl.tintColor = [UIColor whiteColor];
    [segmentedControl addTarget:self action:@selector(segmentedClick:) forControlEvents:UIControlEventValueChanged];
    
}

-(NSString*)requestStrUrl{
    return [[HSURLBusiness sharedURL] getProjectListUrl];
}

-(BOOL)refreshData{
    return YES;
}

-(void)updateUI{
    if (self.reDataArr) {
        NSMutableArray* muArr =[[NSMutableArray alloc] init];
        for (NSDictionary* dic in self.reDataArr) {
            HSDataProjectModel* modelData = [[HSDataProjectModel alloc] init];
            [modelData setDataByDictionary:dic];
            [muArr addObject:modelData];
            
        }
        [tempDicData setObject:muArr forKey:productType];
        currentDataArr = [[NSArray alloc] initWithArray:muArr];
        [self.pullTableView reloadData];
    }
    if (![HSUtils isEmpty:projectname isStrong:YES]) {
        [tempDicDataPage setObject:[NSNumber numberWithInt:self.page] forKey:productType];
    }
    
    if(self.reDataArr&& self.reDataArr.count > 0){
        [searchBar resignFirstResponder];
    }
}

-(NSMutableArray*)requestArrData{
    NSMutableArray* muArr =[super requestArrData];
    if (productType) {
        while ( muArr.count >= 3) {
            [muArr removeLastObject];
        }
        [muArr addObject:[@"projecttype=" stringByAppendingString:productType]];
        if (projectname) {
            [muArr addObject:[@"projectname=" stringByAppendingString:projectname]];
        }
    }
    return muArr;
}

-(void)segmentedClick:(UISegmentedControl*)seg{
    int index = seg.selectedSegmentIndex;
    BOOL reque = NO;
    NSDictionary* dic = [productTypeArr objectAtIndex:index];
    productType = [dic objectForKey: [[dic allKeys] firstObject]];
    projectname = [searTitelDicData objectForKey:productType];
    if (![HSUtils isEmpty:projectname isStrong:YES]) {
        [searTitelDicData removeObjectForKey:productType];
        reque = YES;
    }
    projectname = nil;
    searchBar.text =nil;

    if ([tempDicDataPage objectForKey:productType]) {
         self.page = [[tempDicDataPage objectForKey:productType] intValue];
    }
    currentDataArr = [tempDicData objectForKey:productType];
    if (reque || currentDataArr == nil || currentDataArr.count < 1) {
        projectname = nil;
        [self resetData];//请求数据
        [self requestSafe];
    }
    [searchBar resignFirstResponder];
    [self.pullTableView reloadData];
}

//返回给定分区显示的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return currentDataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KProjectCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    HSProjectTableViewCell *cell = (HSProjectTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HSProjectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellWidth:tableView.frame.size.width];
    }
    HSDataProjectModel* modelData = [currentDataArr objectAtIndex:indexPath.row];
    cell.titleLab.text = modelData.projectName;
    cell.stateContentLab.text = modelData.projectOuterStatus;
    NSString* plannedFundingAmt = modelData.plannedFundingAmt;
    if ([[HSModel sharedHSModel] appSystem] == HSAppSystemStock) {
        cell.scaleContentLab.text = @"拟筹资额";
        cell.scaleLab.text = [plannedFundingAmt stringByAppendingString:@"亿"];
    }else if ([[HSModel sharedHSModel] appSystem] == HSAppSystemBond){
        cell.scaleContentLab.text = @"募集规模";
        if ([productType intValue] == 2) {
            cell.scaleLab.text = [plannedFundingAmt stringByAppendingString:@"亿"];
        }else{
            cell.scaleLab.text = [plannedFundingAmt stringByAppendingString:@"万"];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HSDataProjectModel* modelData = [currentDataArr objectAtIndex:indexPath.row];
    HSProDetailViewController * proDetail = (HSProDetailViewController*)[[HSViewControllerFactory sharedFactory] getViewController:HSMPageProDetailVC isReload:YES];
    proDetail.navTitle = @"项目详情";
    proDetail.projectcode = modelData.projectCode;
    proDetail.projectid = modelData.projectId;
    if ([[HSModel sharedHSModel] appSystem] == HSAppSystemBond && [productType intValue] == 2) {
        proDetail.isABS = YES;
    }
    
    [self.navigationController pushViewController:proDetail animated:YES];
}

#pragma mark  UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchbar{
    [self.reDataArr removeAllObjects];
    NSString* searchStr = searchbar.text;
    if (![HSUtils isEmpty:searchStr isStrong:YES]) {
        projectname = searchStr;
        [searTitelDicData setObject:projectname forKey:productType];
        [self resetData];
        [self requestSafe];
    }
}

- (void)searchBar:(UISearchBar *)searchbar textDidChange:(NSString *)searchText{
    NSString* searchStr = searchbar.text;
    if ([HSUtils isEmpty:searchStr isStrong:YES]) {//空的时候，请求所有
        [searchBar resignFirstResponder];
        if ([searTitelDicData objectForKey:productType]) {
            [self.reDataArr removeAllObjects];
            projectname = nil;
            [searTitelDicData removeObjectForKey:productType];
            if ([tempDicDataPage objectForKey:productType]) {
                self.page = [[tempDicDataPage objectForKey:productType] intValue];
            }
            [self requestSafe];
        }
    }
}

@end
