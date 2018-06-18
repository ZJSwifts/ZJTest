//
//  WKWebConfig.m
//  ZJTest
//
//  Created by 庄记 on 2018/6/18.
//  Copyright © 2018年 庄记. All rights reserved.
//

#import "WKWebConfig.h"
#import "WeakScriptMessageDelegate.h"

@implementation WKWebConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        //创建设置对象
        WKPreferences *preference = [[WKPreferences alloc] init];
        //最小字体大小 当将javaScriptEnabled属性设置为no时， 可以看见明显效果。
        preference.minimumFontSize = 0;
        //设置是否支持JavaScript
        preference.javaScriptEnabled = YES;
        //在ios上默认为no，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        self.preferences = preference;
        //是使用h5的视屏播放器在线播放，还是使用原生播放器全屏播放。
        self.allowsAirPlayForMediaPlayback = YES;
        //设置视频是否需要用户手动播放。设置为no则会允许自动播放。
        self.requiresUserActionForMediaPlayback = YES;
        //设置是否允许画中画技术， 在特定设备上有效。
        self.allowsPictureInPictureMediaPlayback = YES;
        //设置请求的User-Agent信息中应用程序名称 iOS9后可用
        self.applicationNameForUserAgent = @"iPd";
        
        //以下代码适配文本大小，由UIWebView换为WKWebView后，会发现字体小了很多，这应该是WKWebView与html的兼容问题，解决办法是修改原网页，要么我们手动注入JS
        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        //用于进行JavaScript注入
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [self.userContentController addUserScript:wkUScript];
        
    }
    return self;
}

@end
