//
//  MyExtensionViewController.swift
//  ZJTest
//
//  Created by 庄记 on 2016/12/23.
//  Copyright © 2016年 庄记. All rights reserved.
//

import UIKit

class MyExtensionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        Swift 中扩展是没有名字
         1.添加计算属性和计算静态属性
         2.定义实例方法和类型方法
         3.提供新的构造器 扩展可以向已有类型添加新的构造器。这可以让你扩展其他类型
         扩展能向类中添加新的便利构造器,但是他们不能向类中添加新的指定构造器和西沟构造器
         */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension UILabel {
    func drawDeleteLine() {
        
    }
    
    // 绘制一个带删除线的Label
//    override open func draw(_ rect: CGRect) {
//        super.draw(rect)
//        self.textColor = UIColor.black
//        
//        let w = self.frame.size.width
//        let h = self.frame.size.height
//        
//        UIRectFill(CGRect(x: 0, y: h * 0.35, width: w, height: 2))
//    }
}

extension UIView {
    func getCenterView() -> CGRect {
        return CGRect(x:screenWidth - getWidth()/2, y: screenHeight - getHeight()/2, width: getWidth(), height: getHeight())
    }
}
