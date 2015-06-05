//
//  HSPageSrollViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/20.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSPageSrollViewController.h"
#import "HSTabBarView.h"

@interface HSPageSrollViewController ()<UIScrollViewDelegate,HSTabBarViewDelegate>{
    UIScrollView* pScrollView;
    NSMutableArray* pageViews;
    HSTabBarView* tabBarView;

    int iPage;
    int idataIndex;
}

@end

@implementation HSPageSrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataArr = @[@"彭泉善 - 1",@"俞玛丽 - 2",@"小萝卜 - 3"];
    
    [self addTopView];
    [self addpScrollView];
    pageViews = (NSMutableArray*)@[[self addView1],[self addView2],[self addView3]];
    [self showPagebyIndex:0];
}

-(void)addTopView{
    tabBarView = [[HSTabBarView alloc] init];
    tabBarView.delegate = self;
    tabBarView.btnArr = (NSMutableArray*)@[@"彭泉善",@"俞玛丽",@"小萝卜"];
    
    [tabBarView setTabBarWidth:self.view.frame.size.width];
    tabBarView.frame = CGRectMake(0, KNavigationAddstatusHeight, self.view.frame.size.width, KTabBarHeight);
    [self.view addSubview:tabBarView];
}

-(void)addpScrollView{
    pScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KNavigationAddstatusHeight + tabBarView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - KNavigationAddstatusHeight - tabBarView.frame.size.height)];
    pScrollView.pagingEnabled = YES;
    pScrollView.delegate = self;
    pScrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, pScrollView.frame.size.height);
    [self.view addSubview:pScrollView];
    pScrollView.contentOffset = CGPointMake(pScrollView.frame.size.width, 0);
}

-(UIView* )addView1{
    UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, pScrollView.frame.size.width, pScrollView.frame.size.height)];
    [view1 setBackgroundColor:[UIColor redColor]];
    [pScrollView addSubview:view1];
    
    UILabel* lab = [[UILabel alloc] initWithFrame:view1.bounds];
    lab.tag = 1000;
    lab.font = [UIFont boldSystemFontOfSize:50];
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:lab];
    return view1;
}

-(UIView*)addView2{
    UIView* view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, pScrollView.frame.size.width, pScrollView.frame.size.height)];
    [view2 setBackgroundColor:[UIColor greenColor]];
    [pScrollView addSubview:view2];
    
    UILabel* lab = [[UILabel alloc] initWithFrame:view2.bounds];
    lab.tag = 1000;
    lab.font = [UIFont boldSystemFontOfSize:50];
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:lab];
    return view2;
}

-(UIView*)addView3{
    UIView* view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, pScrollView.frame.size.width, pScrollView.frame.size.height)];
    [view3 setBackgroundColor:[UIColor blueColor]];
    [pScrollView addSubview:view3];
    UILabel* lab = [[UILabel alloc] initWithFrame:view3.bounds];
    lab.tag = 1000;
    lab.font = [UIFont boldSystemFontOfSize:50];
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [view3 addSubview:lab];
    return view3;
}

-(void)addSubViews:(NSArray*)viewArr{
    if (viewArr && viewArr.count == 3) {
        for (int i = 0; i < viewArr.count; ++i) {
            UIView * view = [viewArr objectAtIndex:i];
            view.frame = CGRectMake(pScrollView.frame.size.width*i, 0, pScrollView.frame.size.width, pScrollView.frame.size.height);
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float off = scrollView.contentOffset.x;
    if (fabs(off) < 1) {
        idataIndex--;
        iPage--;
    }else if (fabs(off - scrollView.frame.size.width) < 1){
    }else if (fabs(off - 2*scrollView.frame.size.width) < 1){
        idataIndex++;
        iPage++;
    }
    [self showPagebyIndex:iPage];
    
    scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
}

//设置显示第几页（三个页面相关控制）
-(void)showPagebyIndex:(int)page{
    if (page < 0) {
        while (page < 0) {
            page += pageViews.count;
        }
    }else if (page >= pageViews.count) {
        page %= pageViews.count;
    }
    iPage = page;
    
    
    int first = (iPage - 1) < 0 ? (iPage - 1 + (int)pageViews.count) : (iPage - 1);
    int last = (iPage + 1) >= pageViews.count ? (iPage + 1)%(int)pageViews.count: (iPage + 1);
    NSLog(@"first =%d, iPage = %d, last = %d",first,iPage,last);
    UIView* view0 = [pageViews objectAtIndex:first];
    UIView* view1 = [pageViews objectAtIndex:iPage];
    UIView* view2 = [pageViews objectAtIndex:last];
    [self addSubViews:@[view0,view1,view2]];
    
    
    if (idataIndex < 0) {
        while (idataIndex < 0) {
            idataIndex += _dataArr.count;
        }
    }else if (idataIndex >= _dataArr.count) {
        idataIndex %= _dataArr.count;
    }
    int ifirst = (idataIndex - 1) < 0 ? (idataIndex - 1 + (int)_dataArr.count) : (idataIndex - 1);
    NSString* firstStr = [_dataArr objectAtIndex:ifirst];
    NSString* icurretStr = [_dataArr objectAtIndex:idataIndex];
    int ilast = (idataIndex + 1) >= (int)_dataArr.count ? ((idataIndex + 1 )%(int)_dataArr.count) : (idataIndex + 1);
    NSString* lastStr = [_dataArr objectAtIndex:ilast];
    
    UILabel *lab0 = (UILabel*)[view0 viewWithTag:1000];
    lab0.text = firstStr;
    
    UILabel *lab1 = (UILabel*)[view1 viewWithTag:1000];
    lab1.text = icurretStr;
    
    UILabel *lab2 = (UILabel*)[view2 viewWithTag:1000];
    lab2.text = lastStr;
    
    [tabBarView setSelectIndex:idataIndex];
}

//设置显示第几页（数据相关控制）
-(void)showdatabyIndex:(int)index{
    if (index < 0) {
        while (index < 0) {
            index += _dataArr.count;
        }
    }else if (idataIndex >= _dataArr.count) {
        index %= _dataArr.count;
    }
    idataIndex = index;
    int i = iPage;
    if (idataIndex < pageViews.count) {
        iPage = idataIndex;
    }else if (idataIndex >= pageViews.count){
        iPage = idataIndex%pageViews.count;
    }
    
    if (i < iPage) {//向左滑动iPage - 1个单位
        ;
    }else if (i > iPage){//向右滑动i － iPage个单位
        ;
    }
    [self showPagebyIndex:iPage];
}

-(int)getiPage{
    return iPage;
}


#pragma mack tabBarView
-(void)tabBarViewselcetButton:(int)index{
    [self showdatabyIndex:index];
}


@end
