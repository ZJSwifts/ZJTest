//
//  ZJAlertViewController.swift
//  Monking
//
//  Created by apple1 on 16/10/13.
//  Copyright © 2016年 lezhi. All rights reserved.
//

import UIKit

class ZJAlertViewController: NSObject {
    class func showAlertView(message:String ,viewController:UIViewController, block:@escaping (Void)->Void) {
        
        let alertView = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancleBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        cancleBtn.setValue(UIColor.red, forKey: "titleTextColor")
        alertView.addAction(cancleBtn)
        
        let okAction = UIAlertAction(title: "开通会员", style: .default) { (alert) in
            block()
        }
        okAction.setValue(UIColor.gray, forKey: "titleTextColor")
        alertView.addAction(okAction)
        
        viewController.present(alertView, animated: true, completion: nil)
    }
}

extension UIAlertController {
    
}
