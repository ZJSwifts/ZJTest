//
//  JTTabbarBaseViewController.m
//  Monking
//
//  Created by qijingtian on 16/7/28.
//  Copyright © 2016年 lezhi. All rights reserved.
//

#import "JTTabbarBaseViewController.h"

@interface JTTabbarBaseViewController ()
@end

@implementation JTTabbarBaseViewController

- (void)loadView {
    JTTabbarController *parent = (JTTabbarController *)self.parentViewController;
    CGRect frame = CGRectZero;
    frame.size = parent.getVisualContentSize;
    self.view = [[UIView alloc] initWithFrame:frame];
}

@end
