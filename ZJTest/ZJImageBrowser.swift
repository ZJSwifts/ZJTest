//
//  ZJImageBrowser.swift
//  TestImageView
//
//  Created by apple1 on 16/10/10.
//  Copyright © 2016年 庄记. All rights reserved.
//

import UIKit

extension UIImageView {
    func tapImageView() {
        _ = ZJImageBrowser.browserImageView(imageView: self)
        
    }
}

class ZJImageBrowser: UIView {
    var isBigBrowser : Bool?
    var imageBackgroundView : UIView?
    var imageViewSouceImage : UIImageView?
    var imageViewOrignFrame : CGRect?
    
    class func browserImageView(imageView : UIImageView) -> ZJImageBrowser {
        let imageBrowser = ZJImageBrowser(frame: (UIApplication.shared.keyWindow?.bounds)!)
        NotificationCenter.default.addObserver(imageBrowser, selector: #selector(self.tap), name:NSNotification.Name(rawValue: "DeleteReadImageMessage"), object: nil)
        imageBrowser.imageBackgroundView = UIView()
        imageBrowser.imageBackgroundView?.frame = (UIApplication.shared.keyWindow?.bounds)!
        imageBrowser.imageViewSouceImage = UIImageView()
        imageBrowser.imageViewSouceImage?.frame = (imageView.superview?.convert(imageView.frame, to: UIApplication.shared.keyWindow))!
        imageBrowser.imageViewSouceImage?.image = imageView.image
        imageBrowser.imageViewOrignFrame = imageBrowser.imageViewSouceImage!.frame
        let blure = UIBlurEffect(style: .dark)
        let effection = UIVisualEffectView(effect: blure)
        effection.frame = (UIApplication.shared.keyWindow?.bounds)!
        imageBrowser.imageBackgroundView?.addSubview(effection)
        imageBrowser.imageViewSouceImage?.isUserInteractionEnabled = true
        effection.contentView.addSubview(imageBrowser.imageViewSouceImage!)
        imageBrowser.addSubview(imageBrowser.imageBackgroundView!)
        return imageBrowser
    }
    
    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        let boundsSize = UIApplication.shared.keyWindow?.bounds.size
        let screenWidth = boundsSize?.width
        let screenHeight = boundsSize?.height
        let imageSize = self.imageViewSouceImage?.frame
        
        let wPro = screenWidth!/(imageSize?.size.width)!
        let hPro = screenHeight!/(imageSize?.size.height)!
        var allPro:CGFloat
        if screenWidth! >= (imageSize?.width)! && screenHeight! >= (imageSize?.height)! {
            allPro = min(wPro, hPro)
        } else if screenWidth! <= (imageSize?.width)! && screenHeight! <= (imageSize?.height)! {
            allPro = min(wPro, hPro)
        } else {
            if screenWidth! >= (imageSize?.width)! {
                allPro = wPro
            } else {
                allPro = hPro
            }
        }
        
        var newImageFrame = CGRect()
        newImageFrame.size.width = (imageSize?.size.width)!*allPro
        newImageFrame.size.height = (imageSize?.size.height)!*allPro
        newImageFrame.origin.x = (screenWidth! - (newImageFrame.size.width))/2
        newImageFrame.origin.y = (screenHeight! - (newImageFrame.size.height))/2
        
        UIView.animate(withDuration: 0.25, animations: { 
            self.imageViewSouceImage?.frame = newImageFrame
            self.imageBackgroundView?.backgroundColor = UIColor.black
            }) { (isOk) in
        }
    }
    
    func tap() {
        UIView.animate(withDuration: 0.25, animations: { 
            self.imageViewSouceImage?.frame = self.imageViewOrignFrame!
            
        }) { (isOk) in
            self.removeFromSuperview()
        }
    }
}
