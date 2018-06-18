//
//  JAKeyChain.h
//  ZJTest
//
//  Created by 庄记 on 2017/2/8.
//  Copyright © 2017年 庄记. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

#define KEY_PASSWORD  @"com.rry.app.password"
#define KEY_USERNAME_PASSWORD  @"com.rry.app.usernamepassword"

@interface JAKeyChain : NSObject

/**
 *  存储字符串到 KeyChain
 *
 *  @param service NSString
 */
+ (void)keyChainSave:(NSString *)string;

/**
 *  从 KeyChain 中读取存储的字符串
 *
 *  @return NSString
 */
+ (NSString *)keyChainLoad;

/**
 *  删除 KeyChain 信息
 */
+ (void)keyChainDelete;

@end
