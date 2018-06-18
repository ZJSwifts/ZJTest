//
//  JAUIButton.swift
//  ZJTest
//
//  Created by 庄记 on 2016/12/26.
//  Copyright © 2016年 庄记. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    /*
     runtime 将决定推迟到运行时 就是尽可能的做到动态,在运行时对类和对象的属性和方法做改变
     */
    //利用runtime机制 限制按钮同一时间点击多次
    private struct cs_associatedKeys {
        
        static var accpetEventInterval  = "cs_acceptEventInterval"
        static var acceptEventTime      = "cs_acceptEventTime"
        
    }
    
    // 重复点击的间隔
    var cs_accpetEventInterval: TimeInterval {
        get {
            if let accpetEventInterval = objc_getAssociatedObject(self, &cs_associatedKeys.accpetEventInterval) as? TimeInterval {
                return accpetEventInterval
            }
            
            return 1.0
        }
        
        set {
            initAction()
            
            objc_setAssociatedObject(self, &cs_associatedKeys.accpetEventInterval, newValue as TimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var cs_acceptEventTime: TimeInterval {
        get {
            if let acceptEventTime = objc_getAssociatedObject(self, &cs_associatedKeys.acceptEventTime) as? TimeInterval {
                return acceptEventTime
            }
            
            return 1.0
        }
        
        set {
            objc_setAssociatedObject(self, &cs_associatedKeys.acceptEventTime, newValue as TimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    //替换原有的方法
    func initAction() {
        let before: Method = class_getInstanceMethod(self.classForCoder, #selector(sendAction(_:to:for:)))
        let after: Method  = class_getInstanceMethod(self.classForCoder, #selector(cs_sendAction(_:to:forEvent:)))
        
        method_exchangeImplementations(before, after)
    }
    
    func cs_sendAction(_ action: Selector, to target: AnyObject?, forEvent event: UIEvent?) {
        if NSDate().timeIntervalSince1970 - self.cs_acceptEventTime < self.cs_accpetEventInterval {
            return
        }
        
        if self.cs_accpetEventInterval > 0 {
            self.cs_acceptEventTime = NSDate().timeIntervalSince1970
        }
        
        self.cs_sendAction(_ : action, to: target, forEvent: event)
    }
    
    public func creatButton(imageName:String?, title:String ) -> UIButton {
        let button = UIButton()
        if ((imageName?.characters.count) != nil) {
            button.setImage(UIImage(named: imageName!), for: UIControlState.normal)
        }
        button.setTitle(title, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return button
    }
    
    func animateMoveBtn(time:TimeInterval , rate:Int , distance: CGFloat, direction:Direction) {
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
                    self.isEnabled = true
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
                    self.isEnabled = true
                })
            }
    }
}
