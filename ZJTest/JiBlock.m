//
//  JiBlock.m
//  ZJTest
//
//  Created by 庄记 on 2018/6/19.
//  Copyright © 2018年 庄记. All rights reserved.
//

#import "JiBlock.h"

typedef NSString *(^blockString)(NSString *,NSString *);
typedef NSInteger (^blockInteget) (NSInteger , NSInteger);

@implementation JiBlock

- (void)initBlock {
//     void (^block)(NSString *,NSString *) = Block_copy(blockString);
    NSString * (^blockString)(NSString *, NSString *) =  ^(NSString *a, NSString *b) {
        return [NSString stringWithFormat:@"%@-%@",a,b];
    };
    
}

@end
