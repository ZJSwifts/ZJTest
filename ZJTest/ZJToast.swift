//
//  ZJToast.swift
//  TestToast
//
//  Created by apple1 on 16/10/12.
//  Copyright © 2016年 庄记. All rights reserved.
//

import UIKit

class ZJToast: UIView {
    static var contentInset = CGPoint(x: 28, y: 15)
    static var font = UIFont.systemFont(ofSize: 14)
    static func myToast(message:String , duration:Double) {

        let window = UIApplication.shared.keyWindow
        let view = UIView()
        view.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.8)
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = font
        label.text = message
        label.textColor = UIColor.white
        let labelSize = CGSize(width: (window?.frame.size.width)! - 60 - contentInset.x * 2, height: CGFloat.greatestFiniteMagnitude)
        let attribute = [NSFontAttributeName:font] as [String : Any];
        
        let option:NSStringDrawingOptions = .usesLineFragmentOrigin
        var rect = (message as NSString).boundingRect(with: labelSize, options: option, attributes: attribute, context: nil)
        rect.origin = CGPoint(x: contentInset.x + 10, y: contentInset.y)
        label.frame = rect
        view.frame = label.frame.insetBy(dx: -contentInset.x, dy: -contentInset.y)
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 20, y: view.frame.size.height/2 - 9, width: 13, height: 18)
        btn.setImage(UIImage(named:"readMessageBurn"), for: .normal)
        
        view.addSubview(btn)
        view.addSubview(label)
        window?.addSubview(view)
        view.center = (window?.center)!
        UIView.animate(withDuration: 0.25, animations: {
                view.alpha = 0.99
            }) { (finish) in
                UIView.animate(withDuration: 0.25, delay: duration, options: .curveLinear, animations: {
                        view.alpha = 0
                    }, completion: { (finish) in
                        view.removeFromSuperview()
                })
        }
    }

    static func showToast(message:String) {
        self.myToast(message: message, duration: 1.0)
    }
}
