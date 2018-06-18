//
//  ZJString.swift
//  Monking
//
//  Created by apple1 on 2016/11/10.
//  Copyright © 2016年 lezhi. All rights reserved.
//

import Foundation

extension String {
    func zjSubStringTo(index:Int) -> String {
        return self.substring(to: self.characters.index(self.startIndex, offsetBy: index))
    }
    
    func zjSubStringFrom(index:Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: index))
    }
    
    var zjToHttpUrl : URL {
        get {
            return URL(string: self)!
        }
    }
    
    // 获取字符串的尺寸(单行)
    public func textSize(_ font: UIFont) -> CGSize {
        return (self as NSString).size(attributes: [NSFontAttributeName: font])
    }
    
    // 获取字符串的尺寸(多行)
    public func textRectInSize(_ size:CGSize , font: UIFont , wordwarp: NSLineBreakMode , kern: CGFloat = 0) -> CGRect {
        let maxSize = CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude)
        let pStyle = NSMutableParagraphStyle()
        pStyle.lineBreakMode = wordwarp
        let rect = (self as NSString).boundingRect(with: maxSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSFontAttributeName:font, NSParagraphStyleAttributeName:pStyle, NSKernAttributeName:NSNumber(value: Float(kern))], context: nil)
        return CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height+1)
    }
    
    // 绘制字符串
    public func drawInRect(_ rect:CGRect, attr:[String:AnyObject]) {
        (self as NSString).draw(in: rect, withAttributes: attr)
    }
    
    // 获取Base64加密
    public var base64Enc: String? {
        get {
            let data = self.data(using: String.Encoding.utf8)
            return data?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        }
    }
    
    //获取Base64解密
    public var base64Dec: String? {
        get {
            if let data = Data(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0)) {
                if let result = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return result as String
                }
            }
            return nil
        }
    }
    
    //生成一个UUID值
    public static var UUID:String {
        get {
           return NSUUID().uuidString
        }
    }
}

