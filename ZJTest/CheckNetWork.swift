//
//  AFNetworking.swift
//  Monking
//
//  Created by apple1 on 16/10/19.
//  Copyright © 2016年 lezhi. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class CheckNetWork: NSObject {
    class func checkNetworking() {
        let afManager = AFNetworkReachabilityManager.shared()
        afManager.startMonitoring()
        afManager.setReachabilityStatusChange { (status) in
            switch status {
                case .unknown,.notReachable:
                   // MKCommonDataRequest.sharedInstance().netWorkStatus = false
                    break
            case .reachableViaWiFi,.reachableViaWWAN:
                  //  MKCommonDataRequest.sharedInstance().netWorkStatus = true
                break
            }
        }
    }
}
