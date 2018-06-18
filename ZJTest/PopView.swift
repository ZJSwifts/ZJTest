//
//  PopView.swift
//  ZJTest
//
//  Created by 庄记 on 2017/2/27.
//  Copyright © 2017年 庄记. All rights reserved.
//

import UIKit

class PopView: UIView {
    
    var codeBlock:((_ str: String) -> ())?
    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var clickBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.endEdit)))
        self.isUserInteractionEnabled = true
        
    }
    
    func endEdit() {
        self.textFiled.endEditing(true)
    }
    
    @IBAction func clickBtn(_ sender: UIButton) {
        if codeBlock != nil {
            self.codeBlock!(self.textFiled.text!)
        }
    }
}
