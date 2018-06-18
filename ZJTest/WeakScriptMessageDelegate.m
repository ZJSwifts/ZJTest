//
//  WeakScriptMessageDelegate.m
//  ZJTest
//
//  Created by 庄记 on 2018/6/18.
//  Copyright © 2018年 庄记. All rights reserved.
//

#import "WeakScriptMessageDelegate.h"

@implementation WeakScriptMessageDelegate

- (instancetype)initWidthDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        self.scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"当JS调用Name方法是 回调到OC里面");
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end
