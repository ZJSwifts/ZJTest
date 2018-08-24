//
//  UILabel+Attribut.m
//  ZJTest
//
//  Created by zhuangji on 2018/8/24.
//  Copyright © 2018年 庄记. All rights reserved.
//

#import "UILabel+Attribut.h"

@implementation UILabel (Attribut)

- (void)addAttributLineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] init];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpace;
//    NSDictionary *dict = @{NSP:style};
    self.attributedText = attribut;
}




- (void)italicLabelFontSize:(CGFloat)FontSize {
    self.font = [UIFont italicSystemFontOfSize:FontSize];
}

- (void)italicWithChineseLabel {
    CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(-15 * (CGFloat)M_PI / 180), 1, 0, 0);
    self.transform = matrix;
}


@end
