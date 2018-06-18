//
//  JANotificaton.swift
//  ZJTest
//
//  Created by 庄记 on 2016/12/26.
//  Copyright © 2016年 庄记. All rights reserved.
//

import Foundation

class MyShared : NSObject {
    static let shared = MyShared()
}

class MyShared1 : NSObject {
    class var sharedInstance : MyShared1 {
        return single
    }
}
let single = MyShared1()


class MyShared2 : NSObject {
    static var sharedInstance : MyShared2 {
        struct Static {
            static let instance : MyShared2 = MyShared2()
        }
        return Static.instance
    }
}
// 在方法内定义静态常量


class MyShared3 : NSObject {
    class var sharedInstance : MyShared3 {
        return Inner.shared!
    }
    
    struct Inner {
        static let shared : MyShared3? = MyShared3()
    }
}
