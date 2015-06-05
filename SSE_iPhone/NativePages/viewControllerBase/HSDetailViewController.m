//
//  HSDetailViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/3/12.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSDetailViewController.h"
#import "HSHistoryViewController.h"

@interface HSDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    HSDetailTableViewCell* basicInfoCell;
    UIImageView* infoImgView;
}

@end

@implementation HSDetailViewController
@synthesize basicInfoView,tabview;
@synthesize flowinfoArr;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* img = [[HSUtils sharedUtils] getImageNamed:@"icon_clock.png"];
    [button setBackgroundImage:img forState:UIControlStateNormal];
    [button setBackgroundImage:img forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightButtonItemclick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    UIBarButtonItem* rightButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    self.navigationItem.title = @"详情";
    
    float bsinfo_h = [self addBasicInfoView:0];
    [self addTabview:bsinfo_h];
}

-(float)addBasicInfoView:(float)topHeight{
    float basicInfoHeight = 0;//KBasicInfoTopHeight;
    float basicInfo_offh = topHeight;
    
    UIImage* img = [[HSUtils sharedUtils] getImageNamed:@"banner01.png"];
    CGSize imgSize = img.size;
    if (basicInfoView == nil) {
        basicInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, topHeight, self.view.frame.size.width, basicInfoHeight)];
        [basicInfoView setBackgroundColor:[HSColor getColorByColorNavigation]];
        infoImgView = [[UIImageView alloc] initWithImage:img];
        infoImgView.center = CGPointMake(basicInfoView.frame.size.width/2,  imgSize.height/2 + KMiddleOFF);
        [basicInfoView bringSubviewToFront:infoImgView];
        [basicInfoView addSubview:infoImgView];
        [self.view addSubview:basicInfoView];
    }
    
    
    if (basicInfoCell == nil) {
        basicInfoCell = [[HSDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        [basicInfoCell setCellWidth:self.view.frame.size.width];
        [basicInfoCell setMiddleOff:0.0f];
        [basicInfoCell setIsTitleLong:YES];
        [basicInfoCell setIsLine:NO];
        [basicInfoCell.cellBackView setBackgroundColor:[HSColor getColorByColorNavigation]];
        [basicInfoView addSubview:basicInfoCell];
        
    }
    
    [self setTableViewCell:basicInfoCell];
    basicInfo_offh += imgSize.height;
    basicInfoCell.frame = CGRectMake(0, basicInfo_offh, self.view.frame.size.width, [basicInfoCell cellHeight]);
    basicInfoHeight = imgSize.height + [basicInfoCell cellHeight];
    basicInfoView.frame = CGRectMake(0, topHeight, self.view.frame.size.width, basicInfoHeight);
    return basicInfoHeight + topHeight;
}

-(void)setTableViewCell:(HSDetailTableViewCell*)cell{
    
}

-(float)addTabview:(float)topHeihgt{
    tabview = [[UITableView alloc] initWithFrame:CGRectMake(KBoundaryOFF, topHeihgt, self.view.frame.size.width - 2*KBoundaryOFF, self.view.frame.size.height - topHeihgt) style:UITableViewStylePlain];
    tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabview.delegate = self;
    tabview.dataSource = self;
    tabview.rowHeight = KTabViewRowHeight;
    [tabview setBackgroundColor:[HSColor getColorByColorPageLightBlack]];
    [self.view addSubview:tabview];
    tabview.tableHeaderView = [self getTableHeaderView];
    
    [tabview reloadData];
    return self.view.frame.size.height - topHeihgt;
}

-(UIView*)getTableHeaderView{
    UIView* headelView = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF, 0, self.view.frame.size.width - 2*KBoundaryOFF, KTabViewRowHeight)];
    UILabel * lab= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headelView.frame.size.width, headelView.frame.size.height - 1 )];
    NSDictionary* dic = nil;
    if (self.reDataArr && self.reDataArr.count == 1) {
        dic = [self.reDataArr objectAtIndex:0];
    }
    NSString* nodeName = [dic objectForKey:@"nodeName"] ? [@"当前节点:" stringByAppendingString:[dic objectForKey:@"nodeName"]] : @"当前节点:";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:nodeName];
    [str addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} range:NSMakeRange(0,5)];
    [str addAttributes:@{NSForegroundColorAttributeName:KCorolTextRed,NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(5,str.length - 5)];
    lab.attributedText = str;
    
    if (flowinfoArr && flowinfoArr.count > 0) {
        CGRect lineRect= CGRectMake(KBoundaryOFF, headelView.frame.size.height - 1, headelView.bounds.size.width, 1);
        [HSUtils drawLine:headelView type:HSRealizationLine rect:lineRect color:KCorolTextLLGray];
    }
    
    [headelView addSubview:lab];
    return headelView;
}

//调整位置
-(void)adjustmentUI{
    float hoff =[self addBasicInfoView:0];
    float height = self.view.frame.size.height - hoff;
    tabview.frame = CGRectMake(KBoundaryOFF, hoff, self.view.frame.size.width - 2*KBoundaryOFF, height);
    tabview.tableHeaderView = [self getTableHeaderView];
    [tabview reloadData];
}


#pragma mark Subclassing
-(NSString*)requestStrUrl{
    return [[HSURLBusiness sharedURL] getProcWillDoDetailInfoUrl];
}

-(void)updateUI{
    [self adjustmentUI];
}

-(NSMutableArray*)requestArrData{
    NSMutableArray* muArr =[super requestArrData];
    [muArr removeAllObjects];
    _flowtype ? [muArr addObject:_flowtype] : NO;
    _taskid ? [muArr addObject:_taskid] : NO;
    return muArr;
}

-(void)rightButtonItemclick:(id)sender{
    HSHistoryViewController * historyView = (HSHistoryViewController*)[[HSViewControllerFactory sharedFactory] getViewController:HSMPageHistoryVC isReload:YES];
    historyView.navTitle = @"审批历史";
    historyView.instanceid = self.instanceid;
    [self.navigationController pushViewController:historyView animated:YES];
}

#pragma mark UITableView的委托方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellString = @"Cell";
    UITableViewCell *cell =(UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellString];
    float width = tabview.frame.size.width;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView setBackgroundColor:[HSColor getColorByColorPageLightBlack]];
        //图标
        UIImageView* icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, KMiddleOFF + (24 - 12)/2.0, 12, 12)];
        [icon setBackgroundColor:[UIColor lightGrayColor]];
        icon.tag = 1000;
        [cell.contentView addSubview:icon];
        //标题
        UILabel* titLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF + 35, KMiddleOFF, width - 35, 24)];
        titLab.tag = 1001;
        titLab.font = [UIFont systemFontOfSize:15];
        titLab.textColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:titLab];
        //详情
        UILabel* detailLab = [[UILabel alloc] initWithFrame:CGRectMake(KBoundaryOFF + 35, 24 + KMiddleOFF - 3, width - 35 - KBoundaryOFF, 26)];
        detailLab.tag = 1002;
        detailLab.numberOfLines = 0;
        detailLab.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:detailLab];
        
        CGRect lineRect= CGRectMake(0, KTabViewRowHeight - 1, width, 1);
        UIView* lineView = [HSUtils drawLine:cell.contentView type:HSRealizationLine rect:lineRect color:KCorolTextLLGray];
        lineView.tag = 1003;
    }
    
    UILabel* titLab = (UILabel*)[cell.contentView viewWithTag:1001];
    UILabel* detailLab = (UILabel*)[cell.contentView viewWithTag:1002];
    UIView* lineView = [cell.contentView viewWithTag:1003];
    
    detailLab.frame = CGRectMake(KBoundaryOFF + 35, 24 + KMiddleOFF - 3, width - 35 - KBoundaryOFF, 26);
    lineView.frame = CGRectMake(0, KTabViewRowHeight - 1, width, 1);
    
    NSDictionary* dic = [flowinfoArr objectAtIndex:indexPath.row];
    titLab.text = [dic objectForKey:@"keyStr"];
    NSString* dataStr = [dic objectForKey:@"dataStr"];
    NSString* newDataStr = @"";
    if (![HSUtils isEmpty:dataStr isStrong:YES]) {
        NSString* isComma = [dic objectForKey:@"isComma"];
        if (isComma && [isComma intValue] == 1) {
            NSArray* dataStrArr = [dataStr componentsSeparatedByString:@","];
            for (int i = 0; dataStrArr && i < dataStrArr.count; ++i) {
                NSString* strItem = [dataStrArr objectAtIndex:i];
                if (strItem ) {
                    newDataStr = [newDataStr stringByAppendingString:strItem];
                    newDataStr  = i < (dataStrArr.count - 1) ? [newDataStr stringByAppendingString:@"\n"] : newDataStr;
                }
            }
            if (dataStrArr && dataStrArr.count > 1) {
                detailLab.frame = CGRectMake(KBoundaryOFF + 35, 24 + KMiddleOFF , width - 35 - KBoundaryOFF, 20*dataStrArr.count);
                lineView.frame = CGRectMake(0, KTabViewRowHeight - 23 + 20*dataStrArr.count, width, 1);
            }
        }else{
            newDataStr= dataStr;
            CGRect dateStrSize = [newDataStr boundingRectWithSize:CGSizeMake(width - 35 - KBoundaryOFF, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:detailLab.font} context:nil];
            if (dateStrSize.size.height + KMiddleOFF > 26) {
                detailLab.frame = CGRectMake(KBoundaryOFF + 35, 24 + KMiddleOFF - 3 , width - 35 - KBoundaryOFF, dateStrSize.size.height + 2*KMiddleOFF);
                lineView.frame = CGRectMake(0, 23 + dateStrSize.size.height + 3*KMiddleOFF, width, 1);
            }
        }
    }
    detailLab.text = newDataStr;
    return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return flowinfoArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* dic = [flowinfoArr objectAtIndex:indexPath.row];
    NSString* dataStr = [dic objectForKey:@"dataStr"];
    NSString* newDataStr = @"";
    if (![HSUtils isEmpty:dataStr isStrong:YES]) {
        NSString* isComma = [dic objectForKey:@"isComma"];
        if (isComma && [isComma intValue] == 1) {
            NSArray* dataStrArr = [dataStr componentsSeparatedByString:@","];
            if (dataStrArr && dataStrArr.count > 1) {
                return KTabViewRowHeight + (dataStrArr.count - 1)*20;
            }else{
                newDataStr = dataStr;
            }
        }else{
            newDataStr= dataStr;
        }
        CGRect dateStrSize = [newDataStr boundingRectWithSize:CGSizeMake(tabview.frame.size.width - 35 - KBoundaryOFF , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
        if (dateStrSize.size.height + KMiddleOFF > 26) {
            return 24 + dateStrSize.size.height + 2*KMiddleOFF;
        }
    }
    return KTabViewRowHeight;
}

@end
