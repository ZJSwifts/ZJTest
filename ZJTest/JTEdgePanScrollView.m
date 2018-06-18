//
//  JTEdgePanScrollView.m
//  Monking
//
//  Created by qijingtian on 16/8/8.
//  Copyright © 2016年 lezhi. All rights reserved.
//

#import "JTEdgePanScrollView.h"

@implementation JTEdgePanScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] || [gestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]]) {
    //        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
    //        CGPoint point = [pan translationInView:self]; d
    //        if (pan.state == UIGestureRecognizerStateBegan && self.contentOffset.x <= 5 && point.x > -5) {
    //            return true;
    //        }
    //    }
    return false;
}

@end
