//
//  JAArray.swift
//  ZJTest
//
//  Created by 庄记 on 2016/12/26.
//  Copyright © 2016年 庄记. All rights reserved.
//

import Foundation

/*
对于内存的消耗问题 在OC中 在多线程中对Array进行操作的时候会发生崩溃问题 创建一个 NSMutableArray的时候  会产生三块区域 第一块8个字节  第二块 24个字节数组指针的地址  第三块内存存储实际地址 
如果进行 NSMutableArray *local = self.array 在另外一个线程中 local removeAll 元素的话  如果主线程中self.array 还进行访问 就会发生崩溃。访问第一块区域时是安全的 访问第二块和第三块的时候是危险的
 在Swift 中用有Memary layout  并且数组拥有cow机制  如果当local 进行写操作的时候 local 和 self.array 共同指向的第二块内存会发生copy 操作就会生成两份第二块区域地址,就会保证内存安全 如果只是读操作并不会进行copy 每次copy会增加8倍字节的内存消耗
 */
extension NSMutableArray {
    
    func myArray() {
        let arr = [1,2,3]
        var local = arr
        local.append(4)
        print(arr,local)
    }
    
    func testArray() {
        let arr = NSMutableArray(array: [1,2,3,4])
        let local = arr
        local.add(5)
        print(arr,local)
        
        OperationQueue().addOperation { 
            local.removeAllObjects()
        }
        print(arr)
    }
    
    func printElementFromArray(a:[Any]) {
        for e in a {
            print(e)
        }
    }
}

extension Array where Element == String {
    func countWords() -> Int {
        return reduce(0) {
            let components = $1.components(separatedBy: .whitespacesAndNewlines)
            return $0 + components.count
        }
    }
}

extension Int {
    var sqyared: Int {return self * self}

    
    
}

extension NotificationCenter {
    static func addSender(_ name:String , sender: AnyObject , event:@escaping (Notification) -> ()) -> NSObjectProtocol {
        return NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:name), object: sender, queue: OperationQueue.main, using: event)
    }
    
    static func sendNotification(_ name:String, useInfo:[AnyHashable:Any]? = nil ) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:name), object: nil, userInfo: useInfo)
    }
}
