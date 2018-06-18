//
//  JAWebView.swift
//  Monking
//
//  Created by 庄记 on 2016/12/1.
//  Copyright © 2016年 lezhi. All rights reserved.
//

import Foundation
import WebKit

class JAWebView: UIViewController,WKUIDelegate,WKNavigationDelegate {
    var progress:UIProgressView?
    var webView:WKWebView?
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight - 64))
        webView?.backgroundColor = UIColor.white
        webView?.uiDelegate = self
        webView?.navigationDelegate = self
        webView?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        self.view.addSubview(webView!)
        
        progress = UIProgressView(progressViewStyle: .bar)
        progress?.progress = 0.03
        progress?.frame = CGRect(x: 0, y: 10, width: screenWidth, height: 1)
        webView?.addSubview(progress!)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" , object as? WKWebView === webView {
            if let estimated = webView?.estimatedProgress {
                if estimated >= 1 {
                    self.progress?.isHidden = true
                } else {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.progress?.progress = Float(estimated > 0.03 ? estimated : 0.03)
                    })
                }
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: self, change: change, context: context)
        }
    }
}
