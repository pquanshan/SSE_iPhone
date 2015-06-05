//
//  HSTabViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/9.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSTabViewController.h"
#import "MJRefresh.h"

@interface HSTabViewController (){
    BOOL isIncreasePage;//上拉加载时
}

@end

@implementation HSTabViewController
@synthesize isRereshing;

- (id)init{
    self = [super init];
    if (self) {
        _isTopView = NO;
        _isBottomView = NO;
        isRereshing = NO;
        isIncreasePage = NO;
        _page = 1;
    }
    return self;
}

- (void)viewDidLoad {
//    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self adjustmentLayout];
    [super viewDidLoad];
}

-(void)addTopView{
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, KTabBarHeight)];
        [self.view addSubview:_topView];
    }
    
    float height = _isTopView ? KTabBarHeight : 0;
    [_topView setFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
}

-(void)addTabView{
    if (_pullTableView == nil) {
        _pullTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _topView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - _topView.frame.size.height - KBottomTabBarHeight - _bottomView.frame.size.height) style:UITableViewStylePlain];
        [_pullTableView setBackgroundColor:[UIColor clearColor]];
        _pullTableView.delegate = self;
        _pullTableView.dataSource = self;
        _pullTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_pullTableView];
        //下拉刷新(进入刷新状态就会调用self的headerRereshing)
        [self.pullTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
        //上拉加载更多(进入刷新状态就会调用self的footerRereshing)
        [self.pullTableView addFooterWithTarget:self action:@selector(footerRereshing)];
        
        self.pullTableView.headerPullToRefreshText = @"下拉可以刷新了";
        self.pullTableView.headerReleaseToRefreshText = @"松开马上刷新了";
        self.pullTableView.headerRefreshingText = @"正在刷新...";
        
        self.pullTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
        self.pullTableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
        self.pullTableView.footerRefreshingText = @"正在加载数据...";
        
    }
    
    float hoff = _isTopView ? _topView.frame.size.height : 0;
    float height = self.view.frame.size.height - _topView.frame.size.height - KNavigationAddstatusHeight;
    _isBottomView ? height -= KBottomTabBarHeight : NO ;
    _pullTableView.frame = CGRectMake(0, hoff, self.view.frame.size.width, height);
}

-(void)addBottomView{
    if (_bottomView == nil && _isBottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - KBottomTabBarHeight, self.view.frame.size.width, KBottomTabBarHeight)];
        [self.view addSubview:_bottomView];
    }else{
        [_bottomView removeFromSuperview];
        _bottomView = nil;
    }
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, 1);
    [HSUtils drawLine:_bottomView type:HSRealizationLine rect:rect color:KCorolTextLLGray];
    [_bottomView setFrame:CGRectMake(0, self.view.frame.size.height - KBottomTabBarHeight, self.view.frame.size.width, KBottomTabBarHeight)];
}

-(void)setIsBottomView:(BOOL)isBottomView{
    _isBottomView = isBottomView;
    [self adjustmentLayout];
}

-(void)setIsTopView:(BOOL)isTopView{
    _isTopView = isTopView;
    [self adjustmentLayout];
}

-(void)resetData{
    [self.reDataArr removeAllObjects];
    [self.requestArr removeAllObjects];
    NSString* start = @"start=1";
    NSString* limit = [[NSString alloc] initWithFormat:@"limit=%d",KDownLoadLimit];
    [self.requestArr addObject:start];
    [self.requestArr addObject:limit];
    _page = 1;
    isRereshing = NO;
    isIncreasePage = NO;
}

-(void)adjustmentLayout{
    [self addTopView];
    [self addTabView];
    [self addBottomView];
}

-(NSMutableArray*)requestArrData{
    NSMutableArray* muArr =[super requestArrData];
    if (muArr.count < 1) {
        NSString* start = @"start=1";
        NSString* limit = [[NSString alloc] initWithFormat:@"limit=%d",KDownLoadLimit];
        [self.requestArr addObject:start];
        [self.requestArr addObject:limit];
    }
    return muArr;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"需要子类化 %ld",(long)indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reDataArr.count;
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing{
    if (!isRereshing) {
        isRereshing = YES;
        //向下拉时晴空数据
        [self.reDataArr removeAllObjects];
        [self.requestArr removeAllObjects];
        NSString* start = @"start=1";
         NSString* limit = [[NSString alloc] initWithFormat:@"limit=%d",KDownLoadLimit*_page];
        [self.requestArr addObject:start];
        [self.requestArr addObject:limit];
        [self requestSafe];
    }
}

- (void)footerRereshing{
    if (!isRereshing) {
        isRereshing = YES;
        isIncreasePage = YES;
        [self.requestArr removeAllObjects];
        NSString* start = [[NSString alloc] initWithFormat:@"start=%d",++_page];
        NSString* limit = [[NSString alloc] initWithFormat:@"limit=%d",KDownLoadLimit];
        [self.requestArr addObject:start];
        [self.requestArr addObject:limit];
        [self requestSafe];
    }
}

#pragma mark  HSPHttpRequestDelegate
-(void)requestFinish:(NSDictionary *)dicData{
    [super requestFinish:dicData];
    [self.pullTableView headerEndRefreshing];
    [self.pullTableView footerEndRefreshing];
    isRereshing = NO;
    
    if ([self isTotalCount:_totalCount]) {//判断总条数
        isIncreasePage ? _page-- : NO ;
        [self.pullTableView removeFooter];
    }else{
        [self.pullTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    }
    
    if (isIncreasePage) {
        isIncreasePage = NO;
        BOOL iibl = NO;//不需要 --
        id redata = [dicData objectForKey:@"requestData"];
        if ([redata isKindOfClass:[NSArray class]]) {
            BOOL bl = [[dicData objectForKey:@"requestDataCode"] boolValue];
            if (bl) {
                NSArray* array = [[NSArray alloc] initWithArray:(NSArray*)redata];
                if (array.count > 0) {
                    iibl = YES;
                }
            }
        }
        iibl ? NO : _page--;
    }
}

-(void)requestFailed:(NSDictionary *)dicData{
    [super requestFailed:dicData];
    [self.pullTableView headerEndRefreshing];
    [self.pullTableView footerEndRefreshing];
    isRereshing = NO;
    if (isIncreasePage) {
        _page--;
        isIncreasePage = NO;
    }
}

-(void)requestItmeFinish:(NSDictionary *)dicData{
    [super requestItmeFinish:dicData];

}

-(BOOL)isTotalCount:(int)iTotalCount{
    BOOL isTotalCount = NO;
    if (self.reDataArr && self.reDataArr.count == iTotalCount) {
        isTotalCount = YES;
    }
    return isTotalCount;
}

@end
