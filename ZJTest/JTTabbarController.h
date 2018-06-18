//
//  JTTabbarController.h
//  父子控制器
//
//  Created by qijingtian on 16/7/27.
//  Copyright © 2016年 戴川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTEdgePanScrollView.h"

@class JTTabbarBaseViewController;


@interface JTTabbarController : UIViewController

- (instancetype)initWithFrame:(CGRect)frame subViewControllers:(NSArray<JTTabbarBaseViewController *> *)subViewControllers;
- (void)addToViewController:(UIViewController *)vc;

@property (nonatomic,copy) UIColor *btnTextNomalColor;
@property (nonatomic,copy) UIColor *btnTextSeletedColor;
@property (nonatomic,copy) UIColor *underLineColor;
@property (nonatomic,copy) UIColor *topBarColor;

@property (nonatomic, copy) void(^didScrollHandler)(CGFloat percent); // percent 偏移量占总内容尺寸的百分比
- (void)setDidScrollHandler:(void (^)(CGFloat percent))didScrollHandler;

- (void)showPage:(NSInteger)page;

- (CGSize)getVisualContentSize;

@end
