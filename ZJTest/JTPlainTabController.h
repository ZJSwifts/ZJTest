//
//  JTPlainTabController.h
//  Monking
//
//  Created by qijingtian on 16/8/15.
//  Copyright © 2016年 lezhi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JTTabbarBaseViewController;

@interface JTPlainTabController : UIViewController

- (instancetype)initWithFrame:(CGRect)frame subViewControllers:(NSArray *)subViewControllers;
- (void)addToViewController:(UIViewController *)vc;

@property (nonatomic, copy) void(^didScrollHandler)(CGFloat percent); // percent 偏移量占总内容尺寸的百分比
- (void)setDidScrollHandler:(void (^)(CGFloat percent))didScrollHandler;

- (void)showPage:(NSInteger)page;

- (CGSize)getVisualContentSize;
@property (nonatomic) BOOL scrollEnabled;

@end
