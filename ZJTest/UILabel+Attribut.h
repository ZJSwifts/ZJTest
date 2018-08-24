//
//  UILabel+Attribut.h
//  ZJTest
//
//  Created by zhuangji on 2018/8/24.
//  Copyright © 2018年 庄记. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Attribut)

// label斜体英文有效
- (void)italicLabelFontSize:(CGFloat)FontSize;

// label中文斜体
- (void)italicWithChineseLabel;

- (void)addAttributLineSpace:(CGFloat)lineSpace;

@end
