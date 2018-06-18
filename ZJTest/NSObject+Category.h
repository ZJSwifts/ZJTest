//
//  NSObject+Category.h
//  ZJTest
//
//  Created by 庄记 on 2017/2/13.
//  Copyright © 2017年 庄记. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Category)

+ (NSArray *)propertyList;

+ (NSArray *)funcList;

+ (NSArray *)ivarList;

+ (NSArray *)propertyTypeList;

@end
