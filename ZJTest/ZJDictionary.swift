//
//  ZJDictionary.swift
//  Monking
//
//  Created by apple1 on 2016/11/10.
//  Copyright © 2016年 lezhi. All rights reserved.
//

import Foundation

extension NSDictionary {
    func zjToDictionary() -> [String:Any] {
        var dict:[String:Any] = [:]
        for (key , value) in self {
            dict[key as! String] = value
        }
        return dict
    }
}

extension Dictionary {
    func zjToNSDictionary() -> NSMutableDictionary {
        let dict = NSMutableDictionary()
        for (key , value) in self {
            dict.setObject(value, forKey: key as! NSCopying)
        }
        return dict
    }
}
