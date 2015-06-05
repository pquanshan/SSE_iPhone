//
//  HSPublicInfoViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/18.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSPublicInfoViewController.h"
#import "HSConfig.h"
#import "HSModel.h"
#import "HSViewControllerFactory.h"
#import "HSRootViewController.h"
#import "HSDetailTableViewCell.h"
#import "HSPublicInfoDetailViewController.h"
#import "HSSearchViewController.h"
#import "HSLoadingView.h"
#import "HSDataModel.h"


@interface HSPublicInfoViewController ()<UITableViewDelegate, UITableViewDataSource>{
    HSDetailTableViewCell *cellHeight;
}

@end

@implementation HSPublicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    if ([[HSModel sharedHSModel] getMainSystemVC] == HSMPageStockSystemVC) {
        [self.view setBackgroundColor:KCorolBackViewLLWhite];
//    }else {
//        UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, KNavigationAddstatusHeight, self.view.frame.size.width,  self.view.frame.size.height -KNavigationAddstatusHeight)];
//        imgView.image = [[HSUtils sharedUtils] getImageNamed:@"index_bg.png"];
//        [self.view addSubview:imgView];
//    }

    self.isUseNoDataView = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* img = [[HSUtils sharedUtils] getImageNamed:@"icon_search.png"];
    [button setBackgroundImage:img forState:UIControlStateNormal];
    [button setBackgroundImage:img forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightButtonItemclick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    UIBarButtonItem* rightButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.pullTableView.frame = CGRectMake(1.2*KBoundaryOFF, 5, self.view.frame.size.width - 2.4*KBoundaryOFF, self.view.frame.size.height - 5 - KNavigationAddstatusHeight);
    [self.view bringSubviewToFront:self.pullTableView];
    
    cellHeight = [[HSDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    [cellHeight setIsTitleLong:YES];
    [self.pullTableView setBackgroundColor:[UIColor clearColor]];
    [cellHeight setCellWidth:self.pullTableView.frame.size.width];
    
    self.isAddData = YES;
    
    [self addNavigation];
}

-(void)addNavigation{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* img = [[HSUtils sharedUtils] getImageNamed:@"icon_drawdr.png"];
    [button setBackgroundImage:img forState:UIControlStateNormal];
    [button setBackgroundImage:img forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(leftButtonclick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    UIBarButtonItem* leftButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationItem.title = @"公示信息";
}

-(void)leftButtonclick:(id)sender{
    if ([[HSModel sharedHSModel] isShowMain]) {
        [(HSRootViewController*)[[HSViewControllerFactory sharedFactory] rootViewController] showLeftView];
    }else{
        [(HSRootViewController*)[[HSViewControllerFactory sharedFactory] rootViewController] showMainView];
    }
    
}

#pragma mark Subclassing
-(NSString*)requestStrUrl{
    return [[HSURLBusiness sharedURL] getPublicityListUrl];
}

-(NSMutableArray*)requestArrData{
    NSMutableArray* muArr =[super requestArrData];
    return muArr;
    
}

-(void)requestSafe{
    NSString* strUrl = [self requestStrUrl];
    HSPHttpOperationManagers* operation = [[HSPHttpOperationManagers alloc] init];
    operation.delegate = self;
    if (strUrl == nil) {
        return;
    }
    NSMutableString* postStr = [[NSMutableString alloc] initWithString:strUrl];
    if ([[HSModel sharedHSModel] isReachable]) {
        [[HSLoadingView shareLoadingView] show];
        [operation addRequestByKey:[NSURL URLWithString:postStr] type:[self requestType] data:[self requestArrData]];
        [operation executionQueue];
    }else{
        [HSUtils showAlertMessage:@"提示" msg:@"网络连接异常" delegate:nil];
    }
}

-(void)updateUI{
    
    [self.pullTableView reloadData];
}

#pragma mark UITableView的委托方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellString = @"Cell";
    HSDetailTableViewCell *cell =(HSDetailTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellString];
    
    if (cell == nil) {
        cell = [[HSDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellWidth:self.pullTableView.frame.size.width];
        [cell setIsLine:NO];
        [cell setIsTitleLong:YES];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    
    if (self.reDataArr && self.reDataArr.count > indexPath.row) {
        NSDictionary* dic = [self.reDataArr objectAtIndex:indexPath.row];
        [self setTableViewCell:cell dic:dic];
    }

    return cell;
}

-(void)setTableViewCell:(HSDetailTableViewCell*)cell dic:(NSDictionary*)dic{
    HSDataPublicInfoModel* modelData = [[HSDataPublicInfoModel alloc] init];
    [modelData setDataByDictionary:dic];
    [cell.titleLab setText:modelData.projectName];
    if([[HSModel sharedHSModel] appSystem] == HSAppSystemStock){
        [cell.detailsLab setText:@"拟筹资额"];
    }else if ([[HSModel sharedHSModel] appSystem] == HSAppSystemBond){
        [cell.detailsLab setText:@"拟发行金额"];
    }
    
    NSArray* arr;
    if ([[HSModel sharedHSModel] appSystem] == HSAppSystemStock) {
        NSString* plannedFundingAmt = modelData.plannedFundingAmt;
        cell.valueLab.textColor = KCorolTextRed;
        if (plannedFundingAmt) {
            [cell.valueLab setText:[plannedFundingAmt stringByAppendingString:@"亿元"]];
        }else{
            [cell.valueLab setText:@""];
        }
        
        NSString* projectOuterStatus = modelData.projectOuterStatus ? modelData.projectOuterStatus : @"";
        NSDictionary* dic1 = @{@"keyStr":@"项目状态:",@"dataStr":projectOuterStatus};
        NSString* listedCompanyName = modelData.listedCompanyName ? modelData.listedCompanyName : @"";
        NSDictionary* dic2 = @{@"keyStr":@"申报企业:",@"dataStr":listedCompanyName};
        NSString* sponsor = modelData.sponsor ? modelData.sponsor : @"";
        sponsor = [[HSDetailTableViewCell multiLineCode] stringByAppendingString:sponsor];
        NSDictionary* dic3 = @{@"keyStr":@"保荐机构:",@"dataStr":sponsor};
        NSString* lastestModifyDatetime = modelData.lastestModifyDatetime ? modelData.lastestModifyDatetime : @"";
        NSDictionary* dic4 = @{@"keyStr":@"更新日期:",@"dataStr":lastestModifyDatetime};
        arr = [[NSArray alloc] initWithObjects:dic1,dic2,dic3,dic4, nil];
    }else if ([[HSModel sharedHSModel] appSystem] == HSAppSystemBond){
        NSString* plannedFundingAmt = modelData.plannedFundingAmt;
        cell.valueLab.textColor = KCorolTextRed;
        if (plannedFundingAmt) {
            [cell.valueLab setText:[plannedFundingAmt stringByAppendingString:@"万元"]];
        }else{
            [cell.valueLab setText:@""];
        }
        
        NSString* issuer = modelData.issuer ? modelData.issuer : @"";
        NSDictionary* dic1 = @{@"keyStr":@"发起人:",@"dataStr":issuer};
        NSString* projectOuterStatus = modelData.projectOuterStatus ? modelData.projectOuterStatus : @"";
        NSDictionary* dic2 = @{@"keyStr":@"项目状态:",@"dataStr":projectOuterStatus};
        NSString* sponsor = modelData.sponsor ? modelData.sponsor : @"";
        sponsor = [[HSDetailTableViewCell multiLineCode] stringByAppendingString:sponsor];
        NSDictionary* dic3 = @{@"keyStr":@"承销机构:",@"dataStr":sponsor};
        NSString* lastestModifyDatetime = modelData.lastestModifyDatetime ? modelData.lastestModifyDatetime : @"";
        NSDictionary* dic4 = @{@"keyStr":@"更新日期:",@"dataStr":lastestModifyDatetime};
        arr = [[NSArray alloc] initWithObjects:dic1,dic2,dic3,dic4, nil];
    }
  
    [cell setListArr:arr];
}

//对应的section有多少行row
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reDataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.reDataArr && self.reDataArr.count > indexPath.row) {
        NSDictionary* dic = [self.reDataArr objectAtIndex:indexPath.row];
        [self setTableViewCell:cellHeight dic:dic];
        return [cellHeight cellHeight];
    }
    return 44;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HSPublicInfoDetailViewController * infoDetail = (HSPublicInfoDetailViewController*)[[HSViewControllerFactory sharedFactory] getViewController:HSMPagePublicInfoDetailVC isReload:YES];
    NSDictionary* dic = [self.reDataArr objectAtIndex:indexPath.row];
    HSDataPublicInfoModel* modelData = [[HSDataPublicInfoModel alloc] init];
    [modelData setDataByDictionary:dic];
    infoDetail.projectcode = modelData.projectCode;
    infoDetail.projectid = modelData.projectId;
    [self.navigationController pushViewController:infoDetail animated:YES];
}

-(void)rightButtonItemclick:(id)sender{
    HSSearchViewController * searchView = (HSSearchViewController*)[[HSViewControllerFactory sharedFactory] getViewController:HSMPageSearchVC isReload:YES];
    [self.navigationController pushViewController:searchView animated:YES];
}

@end
