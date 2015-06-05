//
//  HSPqsTableViewCell.h
//  HSMoveApproval
//
//  Created by yons on 15-1-24.
//  Copyright (c) 2015年 pquanshan. All rights reserved.
//

//#define KOffMargin          (10)
//#define KOffTop             (5)
//#define KOffBottom          (10)
//#define KTopHeight          (10)
//#define KBottomHeight       (5)
//#define KTitleHeight        (45)
//#define KTextHeight         (25)
//#define KButtonWidth        (100)

#define KOffMargin          (15)
#define KOffTop             (0)
#define KOffBottom          (5)
#define KTopHeight          (0)
#define KBottomHeight       (5)
#define KTitleHeight        (40)
#define KTextHeight         (25)
#define KButtonWidth        (100)

#define fontB [UIFont systemFontOfSize:18]
#define fontM [UIFont fontWithName:@"Helvetica" size:15]
#define fontS [UIFont systemFontOfSize:12.0f]

#import "HSPqsTableViewCell.h"
#import "HSUtils.h"
#import "HSModel.h"

@interface HSPqsTableViewCell(){
    UILabel* _dateLabel;
    float cellHeight;
    UIView* dottedLine;
    UIView* solidLine;
    UIView* btnLineBackView;
}

@property (nonatomic, strong) UIScrollView *cellScrollView;

@end

@implementation HSPqsTableViewCell
@synthesize cellWidth;
@synthesize titleLabel,cellScrollView,rightView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        cellWidth = self.contentView.bounds.size.width;
        cellHeight = self.contentView.bounds.size.height;
        _buttonWidth = KButtonWidth;
        _isRightView = NO;
        _isAutomaticHeight = NO;
        [self initializer];
    }
    
    return self;
}

- (void)initializer{
    cellScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KTopHeight, cellWidth, cellHeight - KTopHeight - KBottomHeight)];
    cellScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    cellScrollView.delegate = self;
    cellScrollView.showsHorizontalScrollIndicator = NO;
    cellScrollView.contentSize = CGSizeMake(cellWidth, cellHeight - KTopHeight - KBottomHeight);
    [cellScrollView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:cellScrollView];
    cellScrollView.userInteractionEnabled = NO;
    
    _nodataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KTopHeight, cellWidth, cellHeight - KTopHeight - KBottomHeight)];
    [_nodataLabel setTextAlignment:NSTextAlignmentCenter];
    [_nodataLabel setBackgroundColor:[UIColor clearColor]];
    [_nodataLabel setHidden:YES];
    [self.contentView addSubview:_nodataLabel];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KOffMargin, KOffTop, cellScrollView.frame.size.width - 2*KOffMargin, KTitleHeight - KOffTop)];
    titleLabel.font = fontB;
    [cellScrollView addSubview:titleLabel];
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(cellScrollView.frame.size.width - KOffMargin, KOffTop, 0, KTitleHeight - KOffTop)];
    _dateLabel.textAlignment = NSTextAlignmentRight;
    _dateLabel.font = fontS;
    _dateLabel.textColor = [UIColor grayColor];
    [cellScrollView addSubview:_dateLabel];
    
    rightView = [[UIView alloc]initWithFrame:CGRectMake(KOffMargin + (cellScrollView.frame.size.width - 2*KOffMargin)*2.0/3.0, KTitleHeight, (cellScrollView.frame.size.width - 2*KOffMargin)/3.0, cellScrollView.frame.size.height - KTitleHeight)];
    [cellScrollView addSubview:rightView];
    
    //虚线
    CGRect rect = CGRectMake(KOffMargin, KTitleHeight-1, cellScrollView.frame.size.width - 2* KOffMargin, 1);
    dottedLine = [HSUtils drawLine:cellScrollView type:HSDottedLine rect:rect color:KCorolTextLGray];
    //实线
    rect = CGRectMake(0, cellScrollView.frame.size.height - 1, cellScrollView.frame.size.width, 1);
    solidLine = [HSUtils drawLine:cellScrollView type:HSRealizationLine rect:rect color:KCorolTextLGray];
}

-(void)setCellWidth:(float)width{
    cellWidth = width;
    [self adjustBasicsLayout];
    [self setLabelArr:_labelArr];
}

-(void)setIsnodata:(BOOL)isnodata{
    [_nodataLabel setHidden:!isnodata];
}

-(void)setButtonWidth:(float)buttonWidth{
    _buttonWidth = buttonWidth;
    [self setRightButtons:_rightButtons];
}

-(void)setdateLabelText:(NSString*)dataStr{
    _dateLabel.text = dataStr;
    cellHeight = [self getDetailTableViewCellHeight:titleLabel.text dateStr:dataStr textArr:_labelArr];
    [self adjustBasicsLayout];
    [self setLabelArr:_labelArr];
}

-(void)setIsRightView:(BOOL)isRightView{
    _isRightView = isRightView;
    [self adjustBasicsLayout];
}

#pragma mark 动态布局
-(void)adjustBasicsLayout{
    cellScrollView.frame = CGRectMake(0, KTopHeight, cellWidth, cellHeight - KTopHeight - KBottomHeight);
    _nodataLabel.frame = CGRectMake(0, KTopHeight, cellWidth, cellHeight - KTopHeight - KBottomHeight);
    
    float dateLabWidth = 0;
    float dateLabHeight = 0;
    float titleLabWidth = cellScrollView.frame.size.width - 2*KOffMargin;
    NSString* dateStr = _dateLabel.text;
    if (dateStr && dateStr.length > 0) {
        CGRect dateStrSize = [dateStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:fontS} context:nil];
        dateLabWidth = (dateStrSize.size.width + 15);
        dateLabHeight = (dateStrSize.size.height + 6);
        titleLabWidth -= dateLabWidth;
        if (titleLabWidth < 0) {
            NSLog(@"时间长度超出屏幕，将导致标题无法显示。");
        }
    }
    float height = KTitleHeight - KOffTop;
    if (_isAutomaticHeight) {
        CGRect rect = [titleLabel.text boundingRectWithSize:CGSizeMake(titleLabWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:fontB} context:nil];
        if (rect.size.height+10 + KOffTop > KTitleHeight + KOffTop) {
            height = rect.size.height+10 + KOffTop;
        }
    }
    titleLabel.frame = CGRectMake(KOffMargin, KOffTop, titleLabWidth, height);
    if (dateStr && dateStr.length > 0) {
        _dateLabel.frame = CGRectMake(KOffMargin + titleLabWidth, KOffTop, dateLabWidth, height);
        [_dateLabel removeFromSuperview];
        [cellScrollView addSubview:_dateLabel];
    }
    
    _isAutomaticHeight ? titleLabel.lineBreakMode = 0,titleLabel.numberOfLines = 0: NO;
    float x = _isRightView ? KOffMargin + (cellScrollView.frame.size.width - 2*KOffMargin)*2.0/3.0 : cellScrollView.frame.size.width - KOffMargin;
    rightView.frame = CGRectMake(x,  height, cellScrollView.frame.size.width - x - KOffMargin, cellScrollView.frame.size.height -  height - KBottomHeight);
    
    dottedLine.frame = CGRectMake(KOffMargin, height + KOffTop, cellScrollView.frame.size.width - 2* KOffMargin, 1);
    solidLine.frame = CGRectMake(0, cellScrollView.frame.size.height - 1, cellScrollView.frame.size.width, 1);
}

#pragma mark 侧滑按钮
-(void)setRightButtons:(NSArray *)rightButtons{
    [self clearButtons];
    _rightButtons = rightButtons;
    cellScrollView.contentSize = CGSizeMake(cellWidth, cellHeight - KTopHeight - KBottomHeight);
    if (rightButtons && rightButtons.count > 0) {
        //添加左箭头
        cellScrollView.userInteractionEnabled = YES;
        CGSize size = [[HSUtils sharedUtils] getImageNamed:@"icon_back.png"].size;
        UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(cellWidth -10, (cellHeight - KTopHeight - KBottomHeight - size.height)/2.0, 10, size.height)];
        [imgView setImage:[[HSUtils sharedUtils] getImageNamed:@"icon_back.png"]];
        imgView.tag = 1314;
        [cellScrollView addSubview:imgView];
    }else{
        cellScrollView.userInteractionEnabled = NO;
    }
    
    if (btnLineBackView == nil) {
        btnLineBackView = [[UIView alloc] init];
        [btnLineBackView setBackgroundColor:[UIColor blackColor]];
        [cellScrollView addSubview:btnLineBackView];
    }
    for (int i = 0; _rightButtons && i < _rightButtons.count;++i) {
        NSString* str = [_rightButtons objectAtIndex:i];
        float btnWidth = _buttonWidth;
        if (i < _rightButtons.count - 1) {
            btnWidth -= 1;
        }
        UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(cellWidth + _buttonWidth*i , 0, btnWidth, cellScrollView.frame.size.height)];
        [btn setTitleColor:KCorolTextLBlue forState:UIControlStateHighlighted];
        if (_rightButtonsColor && _rightButtonsColor.count == _rightButtons.count) {
            [btn setBackgroundColor:[_rightButtonsColor objectAtIndex:i]];
        }else{
            [btn setBackgroundColor:[UIColor grayColor]];
        }
        cellScrollView.contentSize = CGSizeMake(cellScrollView.frame.size.width + _buttonWidth*(i+1), cellScrollView.frame.size.height);
        [btn setTitle:str forState:UIControlStateNormal];
        btn.tag = 1000+i;
        [btn addTarget:self action:@selector(cellBtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [cellScrollView addSubview:btn];
    }
    btnLineBackView.frame = CGRectMake(cellWidth, 0,  _buttonWidth*_rightButtons.count, cellScrollView.frame.size.height);
}

#pragma mark 填充文本列表数组
-(void)setLabelArr:(NSArray *)labelArr{
    [self clearLabels];
    _labelArr = labelArr;
    [self setIsnodata:NO];
    
    float offHeight = [self getTopViewHeight:titleLabel.text  date:_dateLabel.text] + 5;//KOffMargin;
    float height = KTextHeight;
    float w = _isRightView ? (cellWidth - 2*KOffMargin)*2.0/3.0 : (cellWidth - 2*KOffMargin);
    for (int i = 0; _labelArr && i < _labelArr.count; ++i) {
        NSString* title = [_labelArr objectAtIndex:i];
        if (_isAutomaticHeight) {
            CGRect rect = [title boundingRectWithSize:CGSizeMake(w, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:fontM} context:nil];
            if (rect.size.height+6 > KTextHeight) {
                height = rect.size.height+6;
            }
        }
        UILabel* lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(KOffMargin, offHeight, w, height)];
        _isAutomaticHeight ? lbtitle.lineBreakMode = 0,lbtitle.numberOfLines = 0: NO;
        lbtitle.font = fontM;
        [lbtitle setText:title];
        if (_labelTextColorArr && _labelTextColorArr.count == _labelArr.count) {
            [lbtitle setTextColor:[_labelTextColorArr objectAtIndex:i]];
        }else{
            [lbtitle setTextColor:[UIColor grayColor]];
        }
        [cellScrollView addSubview:lbtitle];
        offHeight += height;
    }
    cellHeight = offHeight + 2*KOffBottom +KBottomHeight;
    [self adjustBasicsLayout];
    [self setRightButtons:_rightButtons];
    
}

#pragma mark 计算行高
-(float)getDetailTableViewCellHeight:(NSString*)titelStr dateStr:(NSString*)dateStr textArr:(NSArray*)textArr{
    float offHeight = [self getTopViewHeight:titelStr date:dateStr] + 5;
    float w = _isRightView ? (cellWidth - 2*KOffMargin)*2.0/3.0 : (cellWidth - 2*KOffMargin);
    float height = KTextHeight;
    for (int i = 0; textArr && i < textArr.count; ++i) {
        NSString* title = [textArr objectAtIndex:i];
        if (_isAutomaticHeight) {
            CGRect rect = [title boundingRectWithSize:CGSizeMake(w, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:fontM} context:nil];
            if (rect.size.height+6 > KTextHeight) {
                height = rect.size.height+6;
            }
        }
        offHeight += height;
    }
    offHeight = offHeight + KOffBottom +KBottomHeight;
    return offHeight;
}

-(float)getDetailTableViewCellHeight{
    float offHeight = [self getTopViewHeight:titleLabel.text date:_dateLabel.text] + 5;
    float w = _isRightView ? (cellWidth - 2*KOffMargin)*2.0/3.0 : (cellWidth - 2*KOffMargin);
    float height = KTextHeight;
    for (int i = 0; _labelArr && i < _labelArr.count; ++i) {
        NSString* title = [_labelArr objectAtIndex:i];
        if (_isAutomaticHeight) {
            CGRect rect = [title boundingRectWithSize:CGSizeMake(w, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:fontM} context:nil];
            if (rect.size.height+6 > KTextHeight) {
                height = rect.size.height+6;
            }
        }
        offHeight += height;
    }
    offHeight = offHeight + KOffBottom + KBottomHeight;
    return offHeight;
}


#pragma mark 计算标题高度
-(float)getTopViewHeight:(NSString*)titleStr date:(NSString*)dateStr{
    float dateLabWidth = 0;
    float dateLabHeight = 0;
    float titleLabWidth = cellScrollView.frame.size.width - 2*KOffMargin;
    if (dateStr && dateStr.length > 0) {
        CGRect dateStrSize = [dateStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:fontS} context:nil];
        dateLabWidth = (dateStrSize.size.width + 15);
        dateLabHeight = (dateStrSize.size.height + 6);
        titleLabWidth -= dateLabWidth;
    }
    float height = KTitleHeight + KOffTop;
    if (_isAutomaticHeight) {
        CGRect rect = [titleStr boundingRectWithSize:CGSizeMake(titleLabWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:fontB} context:nil];
       
        if (rect.size.height+10 + KOffTop > KTitleHeight + KOffTop) {
             height = rect.size.height+10 + KOffTop;
        }
    }
    return height;
}

-(void)clearButtons{
    NSArray* subviews = [cellScrollView subviews];
    for (UIView* subview in subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [subview removeFromSuperview];
        }
    }
    
    UIImageView* imgView = (UIImageView*)[cellScrollView viewWithTag:1314];
    [imgView removeFromSuperview];
    imgView = nil;
}

-(void)clearLabels{
    NSArray* subviews = [cellScrollView subviews];
    for (UIView* subview in subviews) {
        if ([subview isKindOfClass:[UILabel class]] && subview != titleLabel) {
            [subview removeFromSuperview];
        }
    }
}

-(void)setShowButton:(int)index{
    [UIView animateWithDuration:0.5 animations:^{
        cellScrollView.contentOffset = CGPointMake(index*_buttonWidth, 0);
    }];
}

#pragma mark scrollViewDelegate
-(void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate{
    float x = scrollView.contentOffset.x;
    int a = (int)(x + (_buttonWidth/2))/_buttonWidth;
    if (!decelerate) {
        [UIView animateWithDuration:0.5 animations:^{
            scrollView.contentOffset = CGPointMake(a*_buttonWidth, 0);
        }];
    }
    if (a > 0) {
        [self.delegate tableDetailCellShowButton:self index:a];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView{
    float x = scrollView.contentOffset.x;
    int a = (int)(x + (_buttonWidth/2))/_buttonWidth;
    [UIView animateWithDuration:0.5 animations:^{
        scrollView.contentOffset = CGPointMake(a*_buttonWidth, 0);
    }];
    if (a > 0) {
        [self.delegate tableDetailCellShowButton:self index:a];
    }
}

-(void)cellBtnclick:(id)sender{
    UIButton* btn = (UIButton*)sender;
    [self.delegate tableDetailCellClickButton:self index:((int)btn.tag-1000)];
}


@end
