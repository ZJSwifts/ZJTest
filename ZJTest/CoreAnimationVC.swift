//
//  CoreAnimationVC.swift
//  ZJTest
//
//  Created by 庄记 on 2017/3/2.
//  Copyright © 2017年 庄记. All rights reserved.
//

import UIKit

class CoreAnimationVC: UIViewController {

    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var zhezhaoView: UIView!
    var addView:UIView?
    var isShow:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isShow = false
        /*
            CoreAnimation   分为  CAAnimation -> 子类有 （CAAnimationGroup , CAPropertyAnimation -> 子类有 CABasicAnimation , CAKeyframeAnimation , CAtransionAnimation）
         */
        self.animationView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        self.animationView.layer.anchorPoint = CGPoint(x: 0.1, y: 0.1)

        //基础动画 CABasicAnimation
//        let base = CABasicAnimation(keyPath: "position")
//        base.fromValue = NSValue(cgPoint: self.animationView.frame.origin)
//        base.toValue = NSValue(cgPoint: CGPoint(x: self.animationView.frame.origin.x, y: self.animationView.frame.origin.y + 200))
//        base.duration = 1.0
//        self.animationView.layer.add(base, forKey: "positionAnimation")
        //关键帧动画
//        let keyFrameAnimation = CAKeyframeAnimation()
//        let path = UIBezierPath(ovalIn: CGRect(x: 50, y: 30, width: self.animationView.frame.size.width, height: self.animationView.frame.size.height))
//        keyFrameAnimation.path = path.cgPath
//        keyFrameAnimation.duration = 5.0
//        self.animationView.layer.add(keyFrameAnimation, forKey: "position")

//        let keyScaleAnimation = CABasicAnimation(keyPath: "transform.scale")
//        keyScaleAnimation.duration = 6
//        keyScaleAnimation.isRemovedOnCompletion = true
//        keyScaleAnimation.fromValue = NSNumber(value: 1)
//        keyScaleAnimation.toValue = NSNumber(value: 0.5)
//        self.animationView.layer.add(keyScaleAnimation, forKey: "transform")
        
        
        UIView.animate(withDuration: 2, animations: {
            self.animationView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { _ in
            
        }
    
        // MARK:仿微信左上角弹出框
        addView = UIView()
        addView?.frame = CGRect(x: 0, y: 64, width: 120, height: 120)
        addView?.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        addView?.layer.anchorPoint = CGPoint(x: 0.1, y: 0.0)
        addView?.backgroundColor = UIColor.gray
        addView?.layer.shadowColor = UIColor.black.cgColor
        addView?.layer.shadowRadius = 5
        addView?.layer.shadowOpacity = 1
        addView?.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.view.addSubview(addView!)
        
        self.zoomIn()
    }
    
    func zoomIn() {
        if self.isShow! {
            UIView.animate(withDuration: 1, animations: {
                self.addView?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }, completion: { (b) in
                self.isShow = false
            })
        } else {
            UIView.animate(withDuration: 1, animations: {
                self.addView?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: {(b) in
                self.isShow = true
            })
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.hidesBottomBarWhenPushed = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
