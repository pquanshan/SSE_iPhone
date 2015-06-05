//
//  HSToDoViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/2/26.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSToDoViewController.h"
#import "HSTodoListViewController.h"
#import "HSCollectionViewCell.h"
#import "HSDataModel.h"

@interface HSToDoViewController (){
    NSMutableArray* modelDataArr;
}

@end

@implementation HSToDoViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    modelDataArr = [[NSMutableArray alloc] init];
    [self addCollectionView];
}


-(void)addCollectionView{
    UICollectionViewFlowLayout *layout=[[ UICollectionViewFlowLayout alloc ] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.7*KBoundaryOFF, 0, self.view.frame.size.width - 1.4*KBoundaryOFF, self.view.frame.size.height - KBottomTabBarHeight) collectionViewLayout:layout];
    [self.collectionView registerClass:[HSCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView setBackgroundColor:[HSColor getColorByColorPageLightWhite]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];
}


#pragma mark Subclassing
-(NSString*)requestStrUrl{
    return [[HSURLBusiness sharedURL] getProcessCategoryUrl];
}

-(void)updateUI{
    [modelDataArr removeAllObjects];
    for (NSDictionary* dic in self.reDataArr) {
        HSDataProTypeModel* modelData = [[HSDataProTypeModel alloc] init];
        [modelData setDataByDictionary:dic];
        [modelDataArr addObject:modelData];
    }
    [self.collectionView reloadData];
}

-(NSMutableArray*)requestArrData{
    NSMutableArray* muArr = [super requestArrData];
    [muArr removeAllObjects];
    return muArr;
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.reDataArr.count;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width/2.0 - 16, 54);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 8, 20, 8);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HSCollectionViewCell *cell = (HSCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                                    forIndexPath:indexPath];
    HSDataProTypeModel* modelData = [modelDataArr objectAtIndex:indexPath.row];
    cell.leftLabel.text = modelData.taskNum;
    int i = [modelData.taskNum intValue];
    if (i > 9) {
        cell.leftLabel.backgroundColor = KCorolBackViewRed;
    }else if(i == 0){
        cell.leftLabel.backgroundColor = [UIColor grayColor];
    }

    cell.rightLabel.text = modelData.flowTypeName;
    return cell;
}

#pragma mark  UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HSDataProTypeModel* modelData = [modelDataArr objectAtIndex:indexPath.row];
    HSTodoListViewController*  viewController =  (HSTodoListViewController*)[[HSViewControllerFactory sharedFactory] getViewController:HSMPageTodoListVC isReload:YES];
    viewController.navTitle = modelData.flowTypeName;
    viewController.flowtype = modelData.flowType;
    viewController.tempTotalCount = [modelData.taskNum intValue];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
