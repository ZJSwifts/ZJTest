//
//  WeakScriptMessageDelegate.h
//  ZJTest
//
//  Created by 庄记 on 2018/6/18.
//  Copyright © 2018年 庄记. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype) initWidthDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
