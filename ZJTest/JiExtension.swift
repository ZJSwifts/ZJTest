//
//  JiExtension.swift
//  ZJTest
//
//  Created by 庄记 on 2017/10/27.
//  Copyright © 2017年 庄记. All rights reserved.
//

import UIKit

enum Direction {
    case hori
    case vert
}
let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

class JiExtension: NSObject {
    
}

// MARK: 获取当前显示的试图控制器
var currentVC : UIViewController {
    get {
        var rootVC = UIApplication.shared.keyWindow?.rootViewController
        while ((rootVC?.presentedViewController) != nil) {
            if let vc = rootVC?.presentedViewController {
                rootVC = vc
            } else if let name1 = rootVC as? UINavigationController {
                rootVC = name1.visibleViewController  //当前导航站中显示的视图
            } else if let name2 = rootVC as? UITabBarController {
                rootVC = name2.selectedViewController
            }
        }
        return rootVC!
    }
}

// MARK: 视图
extension UIView {
    // 使用私有结构是为了不污染全局变量 添加成员属性
    private struct AssociatedKeys {
        static var DescriptiveName = "nsh_DescriptiveName"
    }
    
    var newEmptyTipView: NSString {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.DescriptiveName, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as! NSString
        }
    }
    
    func getWidth() -> CGFloat {
        return self.frame.size.width
    }
    
    func getHeight() -> CGFloat {
        return self.frame.size.height
    }
    
    func getX() -> CGFloat {
        return self.frame.origin.x
    }
    
    func getY() -> CGFloat {
        return self.frame.origin.y
    }
    
    var myFrameWidth:CGFloat {
        get {
            return self.frame.size.width
        }
        
        set(value) {
            var newFrame = self.frame
            newFrame.size.width = value
            self.frame = newFrame
        }
    }
    
    var myFrameHeight:CGFloat {
        get {
            return self.frame.size.height
        }
        
        set(value) {
            var newFrame = self.frame
            newFrame.size.height = value
            self.frame = newFrame
        }
    }
    
    var myFrameX:CGFloat {
        get {
            return self.frame.origin.x
        }
        
        set(value) {
            var newFrame = self.frame
            newFrame.origin.x = value
            self.frame = newFrame
        }
    }
    
    var myFrameY:CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set(value) {
            var newFrame = self.frame
            newFrame.origin.y = value
            self.frame = newFrame
        }
    }
    // 获取当前View所在的试图控制器
    var getMyViewController:UIViewController? {
        get {
            var next = self.next
            while (next != nil) {
                if (next?.isKind(of: UIViewController.superclass()!))! {
                    return next as! UIViewController?
                }
                next = next?.next
            }
            return nil
        }
    }
    
    // 视图抖动效果
    // 视图动画移动效果UIView
    func moveView(time:TimeInterval , rate:Int , distance: CGFloat, direction:Direction , event:@escaping()->()) {
        switch direction {
        case .hori:
            let x = self.myFrameX
            UIView.animateKeyframes(withDuration: time, delay: 0, options: UIViewKeyframeAnimationOptions(), animations: {
                for i in 0...rate {
                    UIView.addKeyframe(withRelativeStartTime: time/TimeInterval(rate)*TimeInterval(i), relativeDuration: time/TimeInterval(rate), animations: {
                        if i == rate {self.myFrameX = x} else {
                            self.myFrameX = (i%2 == 0) ? x + distance : x - distance
                        }
                    })
                }
            }, completion: { _ in
                event()
            })
        case .vert:
            let y = self.myFrameY
            UIView.animateKeyframes(withDuration: time, delay: 0, options: UIViewKeyframeAnimationOptions(), animations: {
                for i in 0...rate {
                    UIView.addKeyframe(withRelativeStartTime: time/TimeInterval(rate)*TimeInterval(i), relativeDuration: time/TimeInterval(rate), animations: {
                        if i == rate {
                            self.myFrameY = y
                        } else {
                            self.myFrameY = (i%2 == 0) ? y + distance : y - distance
                        }
                    })
                }
            }, completion: { _ in
                event()
            })
        }
    }
    
    //将View 转化为 image
    var fastCapture: UIImage? {
        let layer = self.layer
        //        UIGraphicsBeginImageContext(self.frame.size)
        UIGraphicsBeginImageContextWithOptions(self.frame.size, true, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndPDFContext()
        return image
    }
}

// MARK: 颜色
extension UIColor {
    class func rgbColor(_ red:Int , green:Int , blue:Int) -> UIColor {
        return UIColor(red: CGFloat(Float(red)/255.0), green: CGFloat(Float(green)/255.0), blue: CGFloat(Float(blue)/255.0), alpha: 1)
    }
}

// MARK: 对文件的操作
// 获取Document目录
public func documentPath() -> String {
    return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
}
// 获取Temp目录
public func tempPath() -> String {
    return NSTemporaryDirectory()
}
// 获取Cache路径
public func cachePath() -> String {
    return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
}

