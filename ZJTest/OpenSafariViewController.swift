//
//  OpenSafariViewController.swift
//  ZJTest
//
//  Created by 庄记 on 2017/3/6.
//  Copyright © 2017年 庄记. All rights reserved.
//

import UIKit
import SafariServices

class OpenSafariViewController: UIViewController {

    override func viewDidLoad() {
        /*
            1、safari 直接openUrl  UIApplication.shared().openurl
            2、利用自定义UIWebView WKWebView
            3、利用SFSafariViewController 应用内打开 会有一个Done按钮
         */
        // 三种方法 iOS 9.0之前
        super.viewDidLoad()
        let str = "http://www.baidu.com"
        if #available(iOS 9.0, *) {
            let sfViewController = SFSafariViewController(url: URL(string: str)!)
            sfViewController.delegate = self
            self.present(sfViewController, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension OpenSafariViewController: SFSafariViewControllerDelegate {
    @available(iOS 9.0, *)
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
