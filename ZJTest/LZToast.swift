//
//  LZToast.swift
//  Monking
//
//  Created by apple1 on 16/9/26.
//  Copyright © 2016年 lezhi. All rights reserved.
//

import UIKit
import MBProgressHUD

extension MBProgressHUD {
    
    class func showLoading(labelString:String , view:UIView) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.labelText = labelString
        
        hud?.hide(true, afterDelay: 0.5)
    }
    
    class func showLoadingInMyPro(labelString:String , view:UIView) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.labelText = labelString
        
        return hud!
    }
    
    class func showLabelMessage(labelString:String , view: UIView) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.mode = .text
        if labelString.characters.count == 0 {
            hud?.labelText = "网络连接超时"
        } else {
            hud?.labelText = labelString
        }
        hud?.hide(true, afterDelay: 1.5)
    }
}
