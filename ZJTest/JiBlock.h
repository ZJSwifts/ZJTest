//
//  JiBlock.h
//  ZJTest
//
//  Created by 庄记 on 2018/6/19.
//  Copyright © 2018年 庄记. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JiBlock : NSObject

@property (nonatomic, copy) void (^myBlock)(int);

@end
