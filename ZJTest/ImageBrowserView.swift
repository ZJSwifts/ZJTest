//
//  ImageBrowserView.swift
//  TestImageBrowser
//
//  Created by apple1 on 2016/10/27.
//  Copyright © 2016年 庄记. All rights reserved.
//

import UIKit

class ImageBrowserView: UIView,UIScrollViewDelegate {
    
    var collectionView:UICollectionView?
    var imageScrollView:UIScrollView?
    var view:UIScrollView?
    var imageView:UIImageView?
    var indexImage:NSInteger?
    var oldIndex:NSInteger?
    var imageAtrray:[String]?
    var imageFrame:CGRect?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatImageView(imageViewSource:UIImageView , imageArray:[String] , index:NSInteger) {
        indexImage = index
        imageAtrray = imageArray
        imageFrame = imageViewSource.frame
        let rect:CGRect = (UIApplication.shared.keyWindow?.bounds)!
        self.frame = (UIApplication.shared.keyWindow?.bounds)!
        let w:CGFloat = CGFloat(imageArray.count) * rect.size.width
        let h:CGFloat = rect.size.height
        imageScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: rect.size.width, height: h))
        imageScrollView?.isPagingEnabled = true
        imageScrollView?.delegate = self
        imageScrollView?.contentOffset.x = CGFloat(index) * rect.size.width
        imageScrollView?.contentSize = CGSize(width: w, height: h)
        self.addSubview(imageScrollView!)
        self.backgroundColor = UIColor.clear
        var i = 0
        for _ in imageArray {
            if i == index {
                view = UIScrollView(frame: CGRect(x: CGFloat(i)*rect.size.width + (imageFrame?.origin.x)!, y: (imageFrame?.origin.y)!, width: (imageFrame?.size.width)!, height: (imageFrame?.size.height)!))
                view?.contentSize = CGSize(width: rect.size.width, height: rect.size.height)
                view?.delegate = self
                view?.bouncesZoom = true
                view?.maximumZoomScale = 2
                view?.tag = i + 100
                self.view?.backgroundColor = UIColor.clear
                imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
                view?.addSubview(imageView!)
                imageView?.image = UIImage(named:"test")
                imageView?.contentMode = .scaleAspectFill
                imageScrollView?.addSubview(view!)
            } else {
                let otherView = UIScrollView(frame: CGRect(x: CGFloat(i)*rect.size.width, y: 0, width: rect.size.width, height: h))
                otherView.contentSize = CGSize(width: rect.size.width, height: rect.size.height)
                otherView.bouncesZoom = true
                otherView.maximumZoomScale = 2
                otherView.delegate = self
                otherView.tag = 100+i
                otherView.backgroundColor = UIColor.blue
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
                imageView.image = UIImage(named: "icon-resend")
                otherView.addSubview(imageView)
                imageScrollView?.addSubview(otherView)
            }
            i += 1
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap))
        self.addGestureRecognizer(tap)
    }
    
    func suofang() {
        
    }
    
    func tap() {
        UIView.animate(withDuration: 5, animations: {
            if self.imageScrollView?.contentOffset.x == CGFloat(self.indexImage!)*(UIApplication.shared.keyWindow?.bounds.size.width)! {
                self.view?.frame = CGRect(x: CGFloat(self.indexImage!)*(UIApplication.shared.keyWindow?.bounds.size.width)! + (self.imageFrame?.origin.x)!, y: (self.imageFrame?.origin.y)!, width: (self.imageFrame?.size.width)!, height: (self.imageFrame?.size.height)!)
                self.backgroundColor = UIColor.clear
            }
            }) { (finish) in
                self.removeFromSuperview()
        }
    }
    
    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        UIView.animate(withDuration: 0.25, animations: {
                self.view?.frame = CGRect(x: CGFloat(self.indexImage!)*(UIApplication.shared.keyWindow?.bounds.size.width)!, y: 0, width: (UIApplication.shared.keyWindow?.bounds.size.width)!, height: (UIApplication.shared.keyWindow?.bounds.size.height)!)
                self.backgroundColor = UIColor.black
            }) { (finish) in
                print("放大")
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView === self.imageScrollView {
//            let index:NSInteger = NSInteger((self.imageScrollView?.contentOffset.x)!/(UIApplication.shared.keyWindow?.bounds.size.width)!)
//            var i = 0
//            for _ in self.imageAtrray! {
//                if index != i {
//                    let imageView = imageScrollView?.viewWithTag(100+i) as! UIScrollView
//                    imageView.zoomScale = 1
//                }
//                i += 1
//            }
//        }
//    }
}
