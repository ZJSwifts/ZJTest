//
//  NSMutableArray+Extension.m
//  Runtime
//
//  Created by 阳光 on 17/1/11.
//  Copyright © 2017年 阳光. All rights reserved.
//

#import "NSMutableArray+Extension.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSMutableArray (Extension)

// 该方法在类或者分类第一次加载内存的时候自动调用
+(void)load
{
    // __NSArrayM是NSMutableArray真正的类型
    // class_getInstanceMethod 得到类的实例方法
    Method orginalMethod=class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:));
    Method newMethod=class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(change_addObject:));
    // 交换方法的实现
    method_exchangeImplementations(orginalMethod,newMethod);
}

// 自己定义的方法的实现
-(void)change_addObject:(id)object
{
    if (object!=nil) {
        // 该方法的调用,因为方法实现已经交换了,如果调用addObject:方法,会出现死循环
        [self change_addObject:object];
    }
}

@end
