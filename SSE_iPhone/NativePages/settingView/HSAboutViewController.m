//
//  HSAboutViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/12.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSAboutViewController.h"
#import "HSConfig.h"
#import "HSModel.h"

#define KTopHeight          (100)
#define KBottomHeight       (100)

@interface HSAboutViewController (){
    UITextView* textView;
    UIView*  copyrightView;
}

@end

@implementation HSAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"关于软件";
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgView.image = [[HSUtils sharedUtils] getImageNamed:@"bg.jpg"];
    [self.view addSubview:imgView];
    
//    [self.view setBackgroundColor:[HSColor getColorByColorPageLightBlack]];
    [self.view setBackgroundColor:[HSColor getColorByColorPageLightWhite]];
    [self addTextView];
    [self addCopyrightView];
}

- (void)addTextView {
    if (textView == nil) {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF + 5, KTopHeight, self.view.frame.size.width - 2*KBoundaryOFF - 5, 30)];
//        [lab setBackgroundColor:[UIColor whiteColor]];
        lab.font = [UIFont systemFontOfSize:17];
        lab.textColor = [UIColor grayColor];
        lab.text = @"应用概述:";
        textView = [[UITextView alloc] initWithFrame:CGRectMake(KBoundaryOFF, KTopHeight + 30, self.view.frame.size.width - 2*KBoundaryOFF, self.view.frame.size.height - KTopHeight - KBottomHeight - 30)];
        [textView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:lab];
        [self.view addSubview:textView];
    }
    textView.text = @"综合管理平台是解决信托公司信息化建设过程中的\"信息孤岛\"、\"应用孤岛\"、\"协作隔阂\"三大问题， 实现信息的协同、业务的协同和资源的协同，真正实现信托业务从无序有序的开展， 从而降低信托公司的运营风险和管理成本，提高工作效率，充分发挥出信托公司的“战斗力”。";
    textView.editable = NO;
    textView.font = [UIFont systemFontOfSize:17];
//    textView.textColor = [UIColor grayColor];

}

- (void)addCopyrightView {
    if (copyrightView == nil) {
        copyrightView  = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - KBottomHeight - KNavigationAddstatusHeight, self.view.frame.size.width, KBottomHeight)];
        [self.view addSubview:copyrightView];
    }
    
    UILabel* labZH = [[UILabel alloc] initWithFrame:CGRectMake(1.5*KBoundaryOFF, KMiddleOFF, self.view.frame.size.width - 3*KBoundaryOFF, 25)];
    labZH.textAlignment = NSTextAlignmentCenter;
    labZH.font = [UIFont systemFontOfSize:14];
    labZH.textColor = KCorolTextLGray;
    labZH.text = @"恒生电子股份有限公司 版权所有";
    [copyrightView addSubview:labZH];
    UILabel* labEN = [[UILabel alloc] initWithFrame:CGRectMake(1.5*KBoundaryOFF, KMiddleOFF + 25, self.view.frame.size.width - 3*KBoundaryOFF, 40)];
    labEN.textAlignment = NSTextAlignmentCenter;
    labEN.font = [UIFont systemFontOfSize:14];
    labEN.textColor = KCorolTextLGray;
    labEN.text = @"Copyright (c) 2015年 hundsun. \n All rights reserved.";
    labEN.lineBreakMode = 0;
    labEN.numberOfLines = 2;
    [copyrightView addSubview:labEN];
 
}
@end
