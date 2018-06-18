//
//  JAViewController.swift
//  ZJTest
//
//  Created by 庄记 on 2017/1/3.
//  Copyright © 2017年 庄记. All rights reserved.
//

import UIKit

enum CATrans {
    case push
    case model
}

extension UIViewController {
    func myTabbarItem(_ title:String ,_ imageImage:String , _ selectedImage:String , _ font:CGFloat) {
        self.tabBarItem = UITabBarItem(title: title, image: UIImage(named:imageImage), selectedImage: UIImage(named:selectedImage))
        let titleFont = UIFont.systemFont(ofSize: font)
        self.tabBarItem.setTitleTextAttributes([NSFontAttributeName:titleFont,NSForegroundColorAttributeName:UIColor.black], for: .normal)
        self.tabBarItem.setTitleTextAttributes([NSFontAttributeName:titleFont,NSForegroundColorAttributeName:UIColor.red], for: .selected)
    }
    
    func userBack() {
        let backItem = UIBarButtonItem(image: UIImage(named:"icon_back"), style: .plain, target: self, action: #selector(self.tap))
        self.navigationItem.leftBarButtonItem = backItem
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func tap() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func popOutVC(vc:UIViewController , time: TimeInterval , complate:@escaping ()->()) {
        vc.view.transform =  CGAffineTransform(scaleX: 0.1, y: 0.1)
        vc.view.backgroundColor = UIColor.clear
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
        UIView.animate(withDuration: time, animations: { 
            vc.view.transform = CGAffineTransform.identity
        }) { _ in
            vc.view.backgroundColor = UIColor(red: 0.247, green: 0.247, blue: 0.247, alpha: 0.5)
            complate()
        }
    }
    
    func unPopOutVC(vc:UIViewController , time: TimeInterval , complate:@escaping ()->()) {
        self.view.backgroundColor = UIColor.clear
        UIView.animate(withDuration: time, animations: {
            self.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { _ in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
            complate()
        }
    }
    
    func leftIn(vc:UIViewController , time: TimeInterval , complate:@escaping ()->()) {
        guard let image = vc.view.fastCapture else { self.present(vc, animated: true) { complate() }; return }
        let view = UIImageView(image: image)
        view.frame = CGRect(x: -self.view.bounds.width, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.view.addSubview(view)
        UIView.animate(withDuration: time, animations: { 
            view.frame = self.view.bounds
        }) { _ in
            self.present(vc, animated: false, completion: {
                view.removeFromSuperview()
                complate()
            })
        }
    }
    
    func unLeftIn(vc: UIViewController , time: TimeInterval , complate:@escaping ()->()) {
        guard let image = vc.view.fastCapture else { self.dismiss(animated: true, completion: { complate() }); return }
        let view = UIImageView(image: image)
        view.frame = self.view.bounds
        let window = UIApplication.shared.delegate?.window
        window??.addSubview(view)
        self.dismiss(animated: false) { 
            UIView.animate(withDuration: time, animations: { 
                view.frame = CGRect(x: -screenWidth, y: 0, width: screenWidth, height: screenHeight)
            }, completion: { (_) in
                view.removeFromSuperview()
                complate()
            })
        }
    }
    
    func rightIn(vc: UIViewController , time: TimeInterval , trans:CATrans , complate:@escaping ()->()) {
        guard let image = vc.view.fastCapture else {
            switch trans {
            case .model:
                self.present(vc, animated: true, completion: { complate() });
            case .push:
                self.navigationController?.pushViewController(vc, animated: true)
                complate()
            }
            return
        }
        let view = UIImageView(image: image)
        view.frame = CGRect(x: screenWidth, y: 0, width: screenWidth , height: screenHeight)
        self.view.addSubview(view)
        UIView.animate(withDuration: time, animations: { 
            view.frame = self.view.bounds
        }) { (_) in
        
            switch trans {
            case .model:
                self.present(vc, animated: false, completion: {
                    view.removeFromSuperview()
                    complate()
                })
            case .push:
                self.navigationController?.pushViewController(vc, animated: false)
                view.removeFromSuperview()
                complate()
            }
        }
    }
    
    func unRigthIn(vc: UIViewController , time: TimeInterval , trans:CATrans , complate:@escaping ()->()) {
        guard let image = vc.view.fastCapture else {
            switch trans {
            case .model:
                self.dismiss(animated: true , completion: { complate()});
            case .push:
                _ = self.navigationController?.popViewController(animated: true)
                complate()
            }
            return
        }
        let view = UIImageView(image: image)
        view.frame = self.view.bounds
        let window = UIApplication.shared.delegate?.window
        window??.addSubview(view)
        switch trans {
        case .model:
            self.dismiss(animated: false) {
                UIView.animate(withDuration: time, animations: {
                    view.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
                }, completion: { (_) in
                    view.removeFromSuperview()
                    complate()
                })
            }
        case .push:
           _ = self.navigationController?.popViewController(animated: false)
            UIView.animate(withDuration: time, animations: { 
                view.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
            }, completion: { _ in
                view.removeFromSuperview()
                complate()
            })
        }
    }
}

extension UIViewController : UIGestureRecognizerDelegate {}
