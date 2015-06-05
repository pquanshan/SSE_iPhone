//
//  HSLeftMenuViewController.m
//  SSE_iPhone
//
//  Created by pquanshan on 15/2/26.
//  Copyright (c) 2015年 hundsun. All rights reserved.
//

#import "HSLeftMenuViewController.h"
#import "HSModel.h"
#import "HSUtils.h"


#define KPersonalInfoHeight    (KNavigationAddstatusHeight)
#define KTabViewRowHeight      (55)

#define KLROFF                  (25)
#define KOFFWidth               (10)

#define KButtonHeight           (40)
#define KButtonWidth            (40)

#define KImageViewWHeight                 (12)
#define KCollectionViewImageWHeight       (49)
#define KLabelHeight                      (30)


@interface HSLeftMenuViewController (){
    NSArray* menuArr;
    UIButton* nameBtn;
    UIImageView* magView;
    
    int selectIndex;
}

@end

@implementation HSLeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[HSColor getColorByColorPageDarkBackView]];
    menuArr = @[[[HSModel sharedHSModel] getAppSystemName],@"公示信息"];
    selectIndex = 1;
    
    [self addPersonalInfoView];
    [self addCollectionView];
    [self addBottomView];
}

-(void)addPersonalInfoView{
    UIView* personalInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, KPersonalInfoHeight)];
    [self.view addSubview:personalInfoView];
    float off_h = KPersonalInfoHeight - KLabelHeight - 1.5*KMiddleOFF;

    magView = [[UIImageView alloc] initWithFrame:CGRectMake(KBoundaryOFF, off_h + (KLabelHeight - KImageViewWHeight)/2, KImageViewWHeight, KImageViewWHeight)];
    magView.clipsToBounds = YES;
    magView.layer.cornerRadius = KImageViewWHeight/2.0;
    [personalInfoView addSubview:magView];
    
    nameBtn = [[UIButton alloc] initWithFrame:CGRectMake(KImageViewWHeight + KBoundaryOFF, off_h, KLeftShowWidth - 2*KBoundaryOFF, KLabelHeight)];
    nameBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    nameBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [nameBtn setTitleColor:KCorolTextBWhite forState:UIControlStateNormal];
    [nameBtn addTarget:self action:@selector(nameBtnClick:) forControlEvents:UIControlEventTouchDown];
    [personalInfoView addSubview:nameBtn];
    
    //添加底线
    CGRect rect= CGRectMake(KBoundaryOFF, KPersonalInfoHeight - 1, KLeftShowWidth - 2*KBoundaryOFF, 1);
    [HSUtils drawLine:personalInfoView type:HSRealizationLine rect:rect color:KCorolTextBWhite];
}

- (void)setLoginState{
    if ([[HSModel sharedHSModel] isLogin]) {
        [magView setBackgroundColor:[UIColor greenColor]];
        [nameBtn setTitle:[[HSModel sharedHSModel] userName] forState:UIControlStateNormal];
    }else{
        [magView setBackgroundColor:[UIColor redColor]];
        [nameBtn setTitle:@"未登录" forState:UIControlStateNormal];
    }
}

-(void)addCollectionView{
    if (self.collectionView == nil) {
        UICollectionViewFlowLayout *layout=[[ UICollectionViewFlowLayout alloc ] init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, KPersonalInfoHeight, KLeftShowWidth, self.view.frame.size.height - KBottomTabBarHeight -  KPersonalInfoHeight) collectionViewLayout:layout];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collCell"];
        [self.collectionView setBackgroundColor:[UIColor whiteColor]];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.view addSubview:self.collectionView];
        [self.collectionView reloadData];
        [self.collectionView setBackgroundColor:[HSColor getColorByColorPageDarkBackView]];
    }
}

-(void)addBottomView{
    UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,  self.view.frame.size.height - KBottomTabBarHeight,  KLeftShowWidth, KBottomTabBarHeight)];
    [bottomView setBackgroundColor:KCorolTextBackViewLLAlpha];
    [self.view addSubview:bottomView];
    
    UIImageView* imgVew = [[UIImageView alloc] initWithImage:[[HSUtils sharedUtils] getImageNamed:@"icon_set.png"]];
    imgVew.center = CGPointMake(43, KBottomTabBarHeight/2);
    [bottomView addSubview:imgVew];
    UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, 34, KBottomTabBarHeight)];
    lab.text = @"设置";
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = KCorolTextBWhite;
    lab.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:lab];
    
    UIButton* setBtn = [[UIButton alloc] initWithFrame:bottomView.bounds];
    [setBtn addTarget:self action:@selector(setBtnClick:) forControlEvents:UIControlEventTouchDown];
    [bottomView addSubview:setBtn];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return menuArr.count;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(KLeftShowWidth - 20, 100);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 10, 10, 10);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = (UICollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"collCell"  forIndexPath:indexPath];
    float cWidth = cell.contentView.frame.size.width;
    
    UIView* magBackView = (UIView*)[cell.contentView viewWithTag:1000];
    if (magBackView == nil) {
        magBackView = [[UIView alloc] initWithFrame:CGRectMake((cWidth - KCollectionViewImageWHeight)/2.0, 0, KCollectionViewImageWHeight, KCollectionViewImageWHeight)];
        magBackView.tag = 1000;
        magBackView.clipsToBounds = YES;
        magBackView.layer.cornerRadius = KCollectionViewImageWHeight/2.0;
        [magBackView setBackgroundColor:KCorolTextBackViewLAlpha];
        [cell.contentView addSubview:magBackView];
    }

    UIImageView* magbView = (UIImageView*)[magBackView viewWithTag:1001];
    if (magbView == nil) {
        magbView = [[UIImageView alloc] initWithImage:[[HSUtils sharedUtils] getImageNamed:@"lefticon_01.png"]];
        magbView.center = CGPointMake(magBackView.bounds.size.width/2, magBackView.bounds.size.height/2);
        magbView.tag = 1001;
        [magBackView addSubview:magbView];
    }
    bool bl = [self getselectIndex:indexPath.row];
    if (indexPath.row == 0) {
        [magbView setImage:[self getMagBackViewImage:@"lefticon_01" bl:bl]];
        [magBackView setBackgroundColor:[self getMagBackViewColor:bl]];
    }else if (indexPath.row == 1){
        [magbView setImage:[self getMagBackViewImage:@"lefticon_02" bl:bl]];
        [magBackView setBackgroundColor:[self getMagBackViewColor:bl]];
    }
    
    UILabel* titleLab = (UILabel*)[cell.contentView viewWithTag:1002];
    if (titleLab == nil) {
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, KCollectionViewImageWHeight + 5,  cWidth , KLabelHeight)];
        titleLab.tag = 1002;
        titleLab.font = [UIFont boldSystemFontOfSize:14];
        titleLab.textColor = [UIColor whiteColor];
        titleLab.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:titleLab];
    }
    titleLab.text = [menuArr objectAtIndex:indexPath.row];

    return cell;
}

-(BOOL)getselectIndex:(int)index{
    if (index == selectIndex) {
        return YES;
    }
    return NO;
}

-(UIColor*)getMagBackViewColor:(BOOL)bl{
    UIColor* color = KCorolTextBackViewLAlpha;
    if (bl) {
        color = KCorolTextBWhite;
    }
    return color;
}

-(UIImage*)getMagBackViewImage:(NSString*)imgName bl:(BOOL)bl{
    UIImage* img = nil;
    if(imgName){
        if (bl) {
            imgName = [imgName stringByAppendingString:@"_on.png"];
        }else{
            imgName =  [imgName stringByAppendingString:@".png"];
        }
        img = [[HSUtils sharedUtils] getImageNamed:imgName];
    }
    return img;
}


#pragma mark  UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    selectIndex = indexPath.row;
    HSPageVCType pageVCType = HSMPageViewControllerVC;
    if (indexPath.row == 0) {
        [[HSUtils sharedUtils] logEvent:KSeeMenuSystem eventLabel:nil];
        
        if ([[HSModel sharedHSModel] isLogin]) {
            pageVCType = [[HSModel sharedHSModel] getMainSystemVC];
        }else{
//            NSString* msg = [@"请先登录" stringByAppendingString:[[HSModel sharedHSModel] getAppSystemName]];
//            [HSUtils showAlertMessage_OK:@"提示" msg:msg delegate:self];
//            return;
//            [self.delegate leftMenuViewControllerPushEvent:HSMPageLoginVC];
            [[HSViewControllerFactory sharedFactory] gotoLoginController];
            return;
        }
    }else if(indexPath.row == 1){
        [[HSUtils sharedUtils] logEvent:KSeeMenuPublicinfo eventLabel:nil];
        
        pageVCType = HSMPagePublicInfoVC;
    }
    
    [self.collectionView reloadData];
    [self.delegate leftMenuViewControllerTransformEvent:pageVCType isShowMain:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self nameBtnClick:nil];
    }
}

#pragma mack  btnclick
-(void)nameBtnClick:(id)sender{
    if (![[HSModel sharedHSModel] isLogin]) {
//         [[HSViewControllerFactory sharedFactory] gotoLoginController];
    }else{
    }
}

-(void)setBtnClick:(id)sender{
    [[HSUtils sharedUtils] logEvent:KSeeMenuSet eventLabel:nil];
    
    [self.delegate leftMenuViewControllerPushEvent:HSMPageSettingVC];
}

@end
