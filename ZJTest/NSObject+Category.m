//
//  NSObject+Category.m
//  ZJTest
//
//  Created by 庄记 on 2017/2/13.
//  Copyright © 2017年 庄记. All rights reserved.
//

#import "NSObject+Category.h"
#import <objc/runtime.h>

@implementation NSObject (Category)

+ (NSArray *)propertyList {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class] , &count);
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        objc_property_t property = propertyList[i];
        const char *proName = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:proName];
        [array addObject:propertyName];
    }
    free(propertyList);
    return array.copy;
}

+ (NSArray *)propertyTypeList {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *propertyType = property_getAttributes(property);
        NSString *propertyTypeStr = [NSString stringWithUTF8String:propertyType];
        [array addObject:propertyTypeStr];
    }
    free(propertyList);
    return array.copy;
}

+ (NSArray *)funcList {
    unsigned int count = 0;
    Method *methodList = class_copyMethodList([self class], &count);
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0 ; i < count; i++) {
        Method method = methodList[i];
        SEL selector = method_getName(method);
        NSString *methodName = NSStringFromSelector(selector);
        [array addObject:methodName];
    }
    free(methodList);
    return array;
}

+ (NSArray *)ivarList {
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Ivar var = ivarList[i];
        const char *varName = ivar_getName(var);
        NSString *iVarName = [NSString stringWithUTF8String:varName];
        [array addObject:iVarName];
    }
    free(ivarList);
    return array.copy;
}
@end
