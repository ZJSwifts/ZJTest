//
//  JTTabbarController.m
//  父子控制器
//
//  Created by qijingtian on 16/7/27.
//  Copyright © 2016年 戴川. All rights reserved.
//

#import "JTTabbarController.h"

@interface JTTabbarController () <UIScrollViewDelegate>

@property (nonatomic) CGRect viewFrame;
@property (nonatomic, weak) UIButton *oldBtn;
@property (nonatomic, strong) NSArray *VCArray;
@property (nonatomic, weak) JTEdgePanScrollView *contentView;
@property (nonatomic, weak) UIScrollView *topBar;
@property (nonatomic, assign) CGFloat segmentH;
@property (nonatomic, assign) CGFloat btnW;
@property (nonatomic, weak) UIView *underLine;
@property (nonatomic, assign) CGFloat lineH;
@end

@implementation JTTabbarController

- (void)addToViewController:(UIViewController *)vc
{
    [vc addChildViewController:self];
    [vc.view addSubview:self.view];
    [self didMoveToParentViewController:vc];
}

- (CGSize)getVisualContentSize
{
    CGSize size = _viewFrame.size;
    size.height -= _segmentH;
    return size;
}

- (instancetype)initWithFrame:(CGRect)frame subViewControllers:(NSArray<JTTabbarBaseViewController *> *)subViewControllers;
{
    if(self = [super init]) {
        _viewFrame = frame;
        _VCArray = subViewControllers;
        _segmentH = 44;
        _lineH = 2;
    }
    
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:_viewFrame];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加上面的导航条
    [self addTopBar];
    
    //添加子控制器
    [self addVCView];
    
    //添加滑块
    [self addunderLineView];
}

- (void)addunderLineView
{
    if (self.VCArray.count == 0) return;
    
    UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(0, _segmentH-_lineH, self.btnW, _lineH)];
    underLine.backgroundColor = self.underLineColor;
    [self.topBar addSubview:underLine];
    self.underLine = underLine;
}

- (void)addTopBar
{
    if (self.VCArray.count == 0) return;
    NSUInteger count = self.VCArray.count;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, _segmentH)];
    scrollView.backgroundColor = self.topBarColor;
    self.topBar = scrollView;
    self.topBar.bounces = NO;
    [self.view addSubview:self.topBar];
    
    if (count <= 5) { // 屏幕中最多同时显示5个按钮
        self.btnW = self.size.width / count;
    } else {
        self.btnW = self.size.width / 5.0;
    }
    
    // 添加button
    for (int i=0; i<count; i++) {
        UIViewController *vc = self.VCArray[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*self.btnW, 0, self.btnW, _segmentH);
        btn.tag = 10000+i;
        [btn setTitleColor:self.btnTextNomalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.btnTextSeletedColor forState:UIControlStateSelected];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.topBar addSubview:btn];
        if (i == 0) {
            btn.selected = YES;
            self.oldBtn = btn;
        }
    }
    self.topBar.contentSize = CGSizeMake(self.btnW*count, _segmentH);
    
    UIView *bottomEdgeLine = [[UIView alloc] initWithFrame:CGRectMake(0, _topBar.frame.size.height - 0.3, _topBar.frame.size.width, 0.3)];
    bottomEdgeLine.backgroundColor = [UIColor colorWithRed:(200 / 255.0f) green:(199 / 255.0f) blue:(204 / 255.0f) alpha:1.0f];
    [self.topBar addSubview:bottomEdgeLine];
}

- (void)addVCView
{
    JTEdgePanScrollView *contentView = [[JTEdgePanScrollView alloc] initWithFrame:CGRectMake(0, 0+_segmentH, self.size.width, self.size.height -_segmentH)];
    self.contentView = contentView;
    self.contentView.bounces = NO;
    self.contentView.showsHorizontalScrollIndicator = NO;
    contentView.delegate = self;
    contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:contentView];
    
    NSUInteger count = self.VCArray.count;
    for (int i=0; i<count; i++) {
        UIViewController *vc = self.VCArray[i];
        [self addChildViewController:vc];
        CGRect frame = vc.view.frame;
        frame.origin = CGPointMake(i*self.size.width, 0);
        vc.view.frame = frame;
        NSLog(@"%@", NSStringFromCGRect(vc.view.frame));
        [contentView addSubview:vc.view];
        [vc didMoveToParentViewController:self];
    }
    
    contentView.contentSize = CGSizeMake(count*self.size.width, self.size.height-_segmentH);
    contentView.pagingEnabled = YES;
}

- (void)click:(UIButton *)sender
{
    if (sender.selected) return;
    self.oldBtn.selected = NO;
    sender.selected = YES;
    self.contentView.contentOffset = CGPointMake((sender.tag - 10000)*self.size.width, 0);
    
    /*
     // 放大button
     [UIView animateWithDuration:0.3 animations:^{
     sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
     }];
     self.oldBtn.transform = CGAffineTransformIdentity;
     */
    
    self.oldBtn = sender;
    
    // 判断导航条是否需要移动
    
    CGFloat maxX = CGRectGetMaxX(self.underLine.frame);
    if (maxX >= self.size.width  && sender.tag != self.VCArray.count + 10000 - 1) {
        [UIView animateWithDuration:0.3 animations:^{
            self.topBar.contentOffset = CGPointMake(maxX - self.size.width + self.btnW, 0);
        }];
    } else if(maxX < self.size.width) {
        [UIView animateWithDuration:0.3 animations:^{
            self.topBar.contentOffset = CGPointMake(0, 0);
        }];
    }
}

- (void)showPage:(NSInteger)page
{
    [self view];
    if (page >= self.VCArray.count) return;
    self.contentView.contentOffset = CGPointMake(page*self.size.width, 0);
    
    UIButton *sender = [self.topBar viewWithTag:10000+page];
    if (sender.selected) return;
    self.oldBtn.selected = NO;
    sender.selected = YES;
    
    /*
     // 放大button
     [UIView animateWithDuration:0.3 animations:^{
     sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
     }];
     self.oldBtn.transform = CGAffineTransformIdentity;
     */
    
    self.oldBtn = sender;
    
    // 判断导航条是否需要移动
    
    CGFloat maxX = CGRectGetMaxX(self.underLine.frame);
    if (maxX >= self.size.width  && sender.tag != self.VCArray.count + 10000 - 1) {
        self.topBar.contentOffset = CGPointMake(maxX - self.size.width + self.btnW, 0);
    } else if(maxX < self.size.width) {
        self.topBar.contentOffset = CGPointMake(0, 0);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offX = scrollView.contentOffset.x;
    int tag = (int)(offX /self.size.width + 0.5) + 10000;
    UIButton *btn = [self.view viewWithTag:tag];
    if (tag != self.oldBtn.tag) { // 判断是否切换导航条按钮的状态
        [self click:btn];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.underLine.frame = CGRectMake(scrollView.contentOffset.x / self.size.width *self.btnW , _segmentH - _lineH, self.btnW, _lineH);
    
    if (self.didScrollHandler) {
        self.didScrollHandler(scrollView.contentOffset.x / scrollView.contentSize.width);
    }
}

#pragma mark - 

- (UIColor *)underLineColor
{
    if (_underLineColor == nil) {
        _underLineColor = [UIColor colorWithRed:254/255.0 green:0 blue:127/255.0 alpha:1];
    }
    return  _underLineColor;
}

- (UIColor *)btnTextNomalColor
{
    if (_btnTextNomalColor == nil) {
        _btnTextNomalColor = [UIColor colorWithRed:75/255.0 green:75/255.0 blue:75/255.0 alpha:1.0];
    }
    return _btnTextNomalColor;
}

- (UIColor *)btnTextSeletedColor
{
    if (_btnTextSeletedColor == nil) {
        _btnTextSeletedColor = self.underLineColor;
    }
    return _btnTextSeletedColor;
}

- (UIColor *)topBarColor
{
    if (_topBarColor == nil) {
        _topBarColor = [UIColor whiteColor];
    }
    return _topBarColor;
}

- (CGSize)size
{
    return self.view.frame.size;
}


@end
