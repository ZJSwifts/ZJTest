//
//  JTPlainTabController.m
//  Monking
//
//  Created by qijingtian on 16/8/15.
//  Copyright © 2016年 lezhi. All rights reserved.
//

#import "JTPlainTabController.h"
#import "JTEdgePanScrollView.h"

@interface JTPlainTabController () <UIScrollViewDelegate>
@property (nonatomic) CGRect viewFrame;
@property (nonatomic, strong) NSArray *VCArray;
//@property (nonatomic, weak) UIScrollView *contentView;
@property (nonatomic, weak) JTEdgePanScrollView *contentView;
@end

@implementation JTPlainTabController

- (void)addToViewController:(UIViewController *)vc {
    [vc addChildViewController:self];
    [vc.view addSubview:self.view];
    [self didMoveToParentViewController:vc];
}

- (CGSize)getVisualContentSize {
    CGSize size = _viewFrame.size;
    return size;
}

- (instancetype)initWithFrame:(CGRect)frame subViewControllers:(NSArray *)subViewControllers;
{
    if(self = [super init]) {
        _viewFrame = frame;
        _VCArray = subViewControllers;
    }
    
    return self;
}
- (void)setScrollEnabled:(BOOL)scrollEnabled {
    self.contentView.scrollEnabled = scrollEnabled;
}
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:_viewFrame];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.extendedLayoutIncludesOpaqueBars = true;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    //添加子控制器
    [self addVCView];
}

- (void)addVCView {
    
    JTEdgePanScrollView *contentView = [[JTEdgePanScrollView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    self.contentView = contentView;
    self.contentView.bounces = NO;
    self.contentView.showsHorizontalScrollIndicator = NO;
    contentView.delegate = self;
    contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:contentView];
    
    NSUInteger count = self.VCArray.count;
    for (int i = 0; i < count; i++) {
        UIViewController *vc = self.VCArray[i];
        [self addChildViewController:vc];
        CGRect frame = vc.view.frame;
        frame.origin = CGPointMake(i*self.size.width, 0);
        vc.view.frame = frame;
        [contentView addSubview:vc.view];
        [vc didMoveToParentViewController:self];
    }
    
    contentView.contentSize = CGSizeMake(count*self.size.width, self.size.height);
    contentView.pagingEnabled = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.didScrollHandler) {
        self.didScrollHandler(scrollView.contentOffset.x / scrollView.contentSize.width);
    }
}

- (void)showPage:(NSInteger)page {
    if (page >= self.VCArray.count) return;
    self.contentView.contentOffset = CGPointMake(page*self.size.width, 0);
}

- (CGSize)size {
    return self.view.frame.size;
}

@end
