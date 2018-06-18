//
//  JAColorGrad.swift
//  ZJTest
//
//  Created by 庄记 on 2017/1/10.
//  Copyright © 2017年 庄记. All rights reserved.
//

import UIKit

extension UIImage {
    static func gradient(size:CGSize , color1:UIColor , color2: UIColor) -> UIImage? {
        let newSize = CGSize(width: size.width * 2.0 , height: size.height * 2.0)
        UIGraphicsBeginImageContext(newSize)
        drawCanvasImage(rect: CGRect(origin:CGPoint(), size: newSize), color: color1, color2: color2)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndPDFContext()
        return image
    }
    
    static func color(size:CGSize , color: UIColor) -> UIImage? {
        let newSize = CGSize(width: size.width * 2.0, height: size.height * 2.0)
        UIGraphicsBeginImageContext(newSize)
        let path = UIBezierPath(rect: CGRect(origin: CGPoint(), size: newSize))
        color.setFill()
        path.fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    static func drawCanvasImage(rect:CGRect , color: UIColor , color2: UIColor) {
        let content = UIGraphicsGetCurrentContext()
        let gradient = CGGradient(colorsSpace: nil, colors: [color.cgColor , color2.cgColor] as CFArray, locations: [0,1])
        let rectanglePath = UIBezierPath(rect: rect)
        content?.saveGState()
        rectanglePath.addClip()
        let rectangleRotatePath = UIBezierPath()
        rectangleRotatePath.append(rectanglePath)
        var rectangleTransform = CGAffineTransform(rotationAngle: -30 * -CGFloat.pi/180)
        rectangleRotatePath.apply(rectangleTransform)
        let rectangleBounds = rectangleRotatePath.cgPath.boundingBoxOfPath
        rectangleTransform = rectangleTransform.inverted()
        content?.drawLinearGradient(gradient!, start: CGPoint(x: rectangleBounds.minX , y:rectangleBounds.midY).applying(rectangleTransform),
                                    end: CGPoint(x: rectangleBounds.maxX , y:rectangleBounds.midY).applying(rectangleTransform), options: [])
        content?.restoreGState()
    }
}

extension UIButton {
    func setTabGradient() {
        let color  = UIColor(red: 0.4, green: 0.5, blue: 0.6, alpha: 1)
        let color1 = UIColor(red: 0.3, green: 0.7, blue: 0.9, alpha: 1)
        let defImage = UIImage.gradient(size: frame.size, color1: color, color2: color1)
        setBackgroundImage(defImage, for: .highlighted)
        if #available(iOS 9.0, *) {
            setBackgroundImage(defImage, for: .focused)
        }
        setBackgroundImage(defImage, for: .selected)
    }
}
