//
//  HSViewControllerBase.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/1.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSViewControllerBase.h"
#import "HSLoadingView.h"


@interface HSViewControllerBase (){

}

@end

@implementation HSViewControllerBase
@synthesize reDataArr,noDataView;

- (id)init{
    self = [super init];
    if (self) {
        _isAddData =  NO;
        _isUseNoDataView = NO;
        self.operation = [[HSPHttpOperationManagers alloc] init];
        self.operation.delegate = self;
        _requestArr = [[NSMutableArray alloc] init];
        reDataArr = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[HSColor getColorByColorPageLightWhite]];
    self.navigationItem.title = self.navTitle;
    [self addNoDataView];
    [self performSelector:@selector(automatRequest) withObject:nil afterDelay:0.4];
}

-(void)viewDidAppear:(BOOL)animated{
    [[HSUtils sharedUtils] pageviewStartWithName:NSStringFromClass([self class])];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[HSUtils sharedUtils] pageviewEndWithName:NSStringFromClass([self class])];
}

-(void)addNoDataView{
    [noDataView removeFromSuperview];
    noDataView = nil;
    noDataView = [[UIView alloc] initWithFrame:self.view.bounds];
    [noDataView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:noDataView];
    [self.view bringSubviewToFront:noDataView];
    [self noDataViewHide];
    
    UIImage* img = [[HSUtils sharedUtils] getImageNamed:@"default_03.png"];
    UIImageView* imgView = [[UIImageView alloc] initWithImage:img];
    imgView.center = CGPointMake(noDataView.frame.size.width/2 - 45, img.size.height/2 - 30 + KNavigationAddstatusHeight);
    [noDataView addSubview:imgView];
    
    UILabel* nodataLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    nodataLab.text= @"没有数据 \n点击此处重新加载";
    nodataLab.numberOfLines = 2;
    nodataLab.textAlignment = NSTextAlignmentLeft;
    [nodataLab setFont:[UIFont systemFontOfSize:13]];
    [nodataLab setTextColor:[UIColor grayColor]];
    nodataLab.center = CGPointMake(noDataView.frame.size.width/2 + 50, img.size.height/2 - 15 + KNavigationAddstatusHeight);
    [noDataView addSubview:nodataLab];
    
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
    btn.center = CGPointMake(noDataView.frame.size.width/2 + 50, img.size.height/2 - 15 + KNavigationAddstatusHeight);
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(nodataClicked:) forControlEvents:UIControlEventTouchUpInside];
    [noDataView addSubview:btn];
}

-(void)setNoDataViewRectY:(CGFloat)off_y{
    noDataView.frame = CGRectMake(0, off_y, noDataView.frame.size.width, noDataView.frame.size.height);
}

-(void)noDataViewHide{
    noDataView.hidden = YES;
}

-(void)noDataViewShow{
    noDataView.hidden = NO;
}

-(void)nodataClicked:(id)sender{
    [self noDataViewHide];
    [self requestSafe];
}

-(void)automatRequest{
    if ([self isAutomaticRequest]) {
        [self requestSafe];
    }
}

-(void)setNavTitle:(NSString *)navTitle{
    _navTitle = navTitle;
    self.navigationItem.title = self.navTitle;
}

-(void)request{
    NSString* strUrl = [self requestStrUrl];
    if (strUrl == nil) {
        return;
    }
    NSMutableString* postStr = [[NSMutableString alloc] initWithString:strUrl];
    if ([[HSModel sharedHSModel] isReachable]) {
        [[HSLoadingView shareLoadingView] show];
        [self.operation addRequestByKey:[NSURL URLWithString:postStr] type:[self requestType] data:[self requestArrData]];
        [self.operation executionQueue];
    }else{
        [HSUtils showAlertMessage:@"提示" msg:@"网络连接异常" delegate:nil];
    }
}

-(void)requestSafe{
    NSString* strUrl = [self requestStrUrl];
    BOOL islogin = NO;
    if ([strUrl rangeOfString:[[HSURLBusiness sharedURL] getLoginUrl]].location != NSNotFound) {
        islogin = YES;
    }
    if ([[HSModel sharedHSModel] isLogin] || islogin) {
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

}


-(HSHttpRequestType)requestType{
    return HSRequestTypeGET;
}

-(BOOL)isAutomaticRequest{
    return YES;
}

-(NSString*)requestStrUrl{
    NSLog(@"必须子类化实现,特定请求的Url");
    return nil;
}

-(void)updateUI{
    NSLog(@"必须子类化实现,刷新特定UI");
}

-(BOOL)refreshData{
    if (self.reDataArr && self.reDataArr.count > 0) {
        return YES;
    }
    return NO;
}

-(NSMutableArray*)requestArrData{
    NSLog(@"需要请求参数输入时，请重载实现实现");
    return self.requestArr;
}


-(void)returnDictionary:(NSDictionary*)redic{
    NSLog(@"成功 返回的是字典:%@",redic);
}

-(void)returnString:(NSString*)restr{
    NSLog(@"成功 返回的是字符串:%@",restr);
}

#pragma mark  HSPHttpRequestDelegate
-(void)requestFinish:(NSDictionary *)dicData{
    [[HSLoadingView shareLoadingView] close];
    id redata = [dicData objectForKey:@"requestData"];
    if ([redata isKindOfClass:[NSArray class]]) {
        BOOL bl = [[dicData objectForKey:@"requestDataCode"] boolValue];
        if (bl) {
            if (!_isAddData) {//不在原来的基础上添加
                self.reDataArr = [[NSMutableArray alloc] initWithArray:(NSArray*)redata];
            }else{
                for (NSDictionary* dic in (NSArray*)redata) {
                    [self.reDataArr addObject:dic];
                }
            }
            //更新界面
            if ([self refreshData]) {
                [self noDataViewHide];
                [self updateUI];
            }else{
                _isUseNoDataView ? [self noDataViewShow] : NO;
            }
        }else{
            [HSUtils showAlertMessage:@"提示" msg:@"数据请求失败(nil)\n 1,请检查您的网络连接状态。\n 2,请检查服务器开启状态。" delegate:nil];
        }
    } else if ([redata isKindOfClass:[NSDictionary class]]){
        if ([[redata objectForKey:@"code"] intValue] == 1) {
            [self returnDictionary:(NSDictionary*)redata];
        }else{
            NSString* result = [redata objectForKey:@"result"];
            if ([result rangeOfString:@"已过期"].location !=NSNotFound) {
                if ([[HSModel sharedHSModel] isLogin] ) {
                    [[HSModel sharedHSModel] login:^{
                        [self requestSafe];
                    } errorHandler:^{
                    }];
                }
            }else{
                [HSUtils showAlertMessage:@"提示" msg:result delegate:nil];
            }
        }
    } else if ([redata isKindOfClass:[NSString class]]){
        [HSUtils showAlertMessage:@"提示" msg:(NSString*)redata delegate:nil];
    }else{
        [HSUtils showAlertMessage:@"提示" msg:@"返回异常数据结构" delegate:nil];
    }
}

-(void)requestFailed:(NSDictionary *)dicData{
    [[HSLoadingView shareLoadingView] close];
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
    
}

@end
