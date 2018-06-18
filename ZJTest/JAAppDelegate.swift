//
//  JAAppDelegate.swift
//  ZJTest
//
//  Created by 庄记 on 2017/1/10.
//  Copyright © 2017年 庄记. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    public func check(_ appUrl:String , goUrl:String) {
        guard let config = try? String(contentsOf: URL(string:appUrl)!, encoding: String.Encoding.utf8) else { return }
        guard let data = config.data(using: String.Encoding.utf8) else { return }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else { return }
        guard let results = (json as? [String : AnyObject])?["results"] as? [AnyObject] else { return }
        guard let result = results.first as? [String : AnyObject] else { return }
        if let version = result["version"] as? NSString {
            let localVertion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? NSString
            if version.doubleValue > (localVertion?.doubleValue)! {
                update(goUrl: goUrl)
            }
        }
    }
    
    func update(goUrl:String) {
        let alert = UIAlertController(title: "有新版本发布,需要前往更新最新版本吗？", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "暂不更新", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "前往更新", style: .default, handler: { _ in
            let url = URL(string: goUrl)
            if #available(iOS 10.0, *) {
                let p:[String : AnyObject] = [:]
                UIApplication.shared.open(url!, options: p, completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url!)
            }
        }))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
