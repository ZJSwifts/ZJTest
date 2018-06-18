//
//  TestViewController.swift
//  ZJTest
//
//  Created by 庄记 on 2016/12/16.
//  Copyright © 2016年 庄记. All rights reserved.
//

import UIKit
import Lottie
import CocoaAsyncSocket

class TestView1Controller: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var myLabelsss: JALabel?
    
    @IBOutlet weak var isMyBtn: UIButton?
    @IBOutlet weak var myView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        userBack()
//        _ = JACollection.setCellSizeForCollection(collectionView!, itemRow: 3, heightWidthRate: 1.2, totalWidth: self.view.frame.size.width)
        
        let someVehicle = Vehicle()
        print(someVehicle.description)
        let bicycle2 = Bicycle2()
        bicycle2.currentSpeed = 1.0
        print(bicycle2.description)
        
        /*
            重写类的属性 可以把基类的只读属性继承为读写属性，但是不可以把基类的读写属性继承为只读属性 必须要在set 和get 方法中提供 相应的方法 你可以降一个继承的只读属性重写为一个读写属性必须要你重写的版本中提供getter和setter方法即可，但是你不可将一个继承来的读写属性重新写为一个只读属性
         注意: 如何你再重写属性中提供了setter方法那么不特荼毒曝光台提供getter 如果你不想在重写版本中的getter离修改继承来的属性值,你可以直接通过super.摸个属性来返回继承的值。
         
        并且在只读计算属性和常量存储属性是不可以被继承添加 属性观察器的 只有在读写属性继承过程中可以添加属性观察器
         */
        
        /*
         构造器 在构造器的过程中要为所有存储属性付初始值
         如果一个属性总是使用相同的初始值,那么为其设置一个默认值表较好,可以是你的构造器比较简洁。
         构造器早构造的过程中必须使用外部参数名,如果没有外部参数名的话,它将会导致编译错误.如果你只有内部名称的话他会自动引用内部名称为外部名称供别人调用
         默认构造器如果一个类或结构体中的所有属性都有默认值,同时没有自定义结构体,系统会自动为他生成一个构造器
         结构体的逐一成员构造器
         */
        
        //创建一个label的下划线
//        let font = UIFont.systemFont(ofSize: 12)
//        let attri = NSAttributedString(string: (self.myLabelsss?.text)!, attributes: [NSFontAttributeName:font,NSForegroundColorAttributeName:UIColor.black,NSStrikethroughColorAttributeName:UIColor.black,NSStrikethroughStyleAttributeName:[NSUnderlineStyle.styleSingle,NSUnderlineStyle.patternSolid]])
//        self.myLabelsss?.attributedText = attri
        //重新绘制label上面的下划线
        
        // 按钮都抖动效果
        self.myLabelsss?.text = "重新更新内容"

        let arr = NSMutableArray()
        arr.myArray()
        arr.testArray()
        
        let size = Size(width: 0.01, heigth: 0.02)
        
        let date = Date().timeIntervalSince1970 + 17*60*60
        let date1 = Date.timeIntervalToDate(timeInterval: date)
        let str = Date.dateTostring(date: date1, false)
        print(date,date1,str)
        
        let str1 = Date.dateTostring(date: date1, true)
        print(date,date1,str1)
        
        let str2 = "1900-01-01"
        let date2 = Date.stringToDate(timeString: str2, false)
        print(date2)
        
        let str3 = "1900-01-01 01:25:25"
        let date3 = Date.stringToDate(timeString: str3, true)
        print(date3)
        
        isMyBtn?.setTabGradient()
        
        
        
        
    }
    
    @IBAction func action(_ sender: UIButton) {
//        let view = ViewController()
//        popOutVC(vc: view, time: 0.5) { 
//            print("完成")
//        }
//        self.isMyBtn?.isEnabled = false
//        self.myView?.moveView(time: 0.8, rate: 8, distance: 10, direction: .hori , event: {
//            self.isMyBtn?.isEnabled = true
//        })
        
//        let vc = SeconedViewController()
//        rightIn(vc: vc, time: 0.5, trans: .push) { 
//            print("入栈")
//        }
        Single.shared.connect()
    }
    @IBAction func disConnect(_ sender: UIButton) {
        Single.shared.disConnect()
    }
    
    @IBAction func sendMsg(_ sender: UIButton) {
        Single.shared.sendMsg()
    }
}

struct Size {
    var width:Double
    var heigth:Double
}

class person {
    var height:Int
    var age:Int
    var name:String
    var descript:String {
        return "you are very hm"
    }
    
    init(name:String , _ height:Int , _ age:Int) {
        self.height = height
        self.name = name
        self.age = age
    }
}

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "\(currentSpeed) miles per hour"
    }
    var description1: String {
        return "第二个描述"
    }
    func makeNoise() {
        //什么也不做
    }
}

class Bicycle: Vehicle {
    var hasBasket = false
}

class Bicycle2: Bicycle {
    var currentNumber = 0
    override var description: String {
        set(value){
            self.description = value
        }
        get {
            return "\(currentSpeed) 这是一个描述"
        }
    }
    
    override var description1: String {
        get {
            return super.description1
        }
    }
}

struct MyColor {
    var blue:Int
    var green:Int
    init(blue:Int,green:Int) {
        self.blue = blue
        self.green = green
    }
}

final class Single: NSObject {
    static let shared = Single()
    private override init() {}
    
    var gcdSocket : GCDAsyncSocket?
    
    func connect() {
        gcdSocket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
        try? gcdSocket?.connect(toHost: "127.0.0.1", onPort: 6969)
        print("链接成功")
    }
    
    func disConnect() {
        gcdSocket?.disconnect()
    }
    
    func  sendMsg() {
        let str = "你好"
        let data = str.data(using: String.Encoding.utf8)
        gcdSocket?.write(data!, withTimeout: -1, tag: 110)
    }
    
    func pullTheMsg() {
        gcdSocket?.readData(withTimeout: -1, tag: 110)
    }
}

extension Single : GCDAsyncSocketDelegate {
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("连接成功")
        self.pullTheMsg()
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print("断开连接")
    }
}

