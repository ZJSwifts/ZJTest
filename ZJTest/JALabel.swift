//
//  JALabel.swift
//  ZJTest
//
//  Created by 庄记 on 2016/12/23.
//  Copyright © 2016年 庄记. All rights reserved.
//

import UIKit

class JALabel: UILabel {

    override func draw(_ rect: CGRect) {
        super.drawText(in: rect)
        
        self.textColor = UIColor.orange
        
        let w = rect.size.width
        let h = rect.size.height
        
        //绘制这个数字是为了找到label中间的位置 0.35可以控制删除线的位置
        UIRectFill(CGRect(x: 0, y: h * 0.2, width: w, height: 5))
        
        //根据所给的路径直接绘制一个矩形
   //     UIRectFrame(CGRect(x: 0, y: h * 0.3, width: w - 10, height: 10))
        
        let model = CGBlendMode.destinationAtop
        UIRectFillUsingBlendMode(CGRect(x: 0 , y : h * 0.5 , width: w , height: 5), model)
//        
//      UIRectFrameUsingBlendMode(CGRect(x: 0 , y : h * 0.6 , width: w , height: 4), model)
        
    }
}
