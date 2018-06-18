//
//  PopViewController.swift
//  ZJTest
//
//  Created by 庄记 on 2017/2/27.
//  Copyright © 2017年 庄记. All rights reserved.
//

import UIKit

class PopViewController: UIViewController {

    @IBOutlet weak var zhezhoadasd: UIView!
    var textInputOriginY: CGFloat = 0.0
    var asdasda: PopView!
    var uploadInvateCode: ((_ str:String) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotity()
        initView()
    }
    
    func initView() {
        asdasda = Bundle.main.loadNibNamed("PopView", owner: nil, options: nil)?.last as? PopView
        asdasda.frame.origin.y = screenHeight
        asdasda.frame.size.width = screenWidth
        asdasda.clickBtn.layer.cornerRadius = 22
        self.view.addSubview(asdasda)
        asdasda.textFiled.becomeFirstResponder()
        self.zhezhoadasd.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.redius)))
        self.zhezhoadasd.isUserInteractionEnabled = true
        
    }

    func addNotity() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.willShowKeyBoard(notity:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.willHideKeyBoard(notity:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.textFiledChnage) , name: Notification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    func textFiledWillChange() {
        
    }
    
    func textFiledChnage() {
        if (asdasda.textFiled.text?.characters.count)! >= 6 {
            asdasda.clickBtn.backgroundColor = UIColor.rgbColor(102, green: 225, blue: 187)
            asdasda.clickBtn.isEnabled = true
        } else {
            asdasda.clickBtn.backgroundColor = UIColor.rgbColor(214, green: 214, blue: 214)
            asdasda.clickBtn.isEnabled = false
        }
    }
    
    func redius() {
        asdasda.textFiled.endEditing(true)
    }
    
    func willShowKeyBoard(notity: NSNotification) {
        let n = notity.userInfo
        let value = n?["UIKeyboardFrameEndUserInfoKey"] as! CGRect
        UIView.animate(withDuration: 0.25) {
            var rect = self.asdasda.frame
            let allHeight = value.height + rect.height
            self.textInputOriginY = screenHeight - allHeight
            rect.origin.y = self.textInputOriginY
            self.asdasda.frame = rect
            
            self.zhezhoadasd.alpha = 0.9
            self.zhezhoadasd.isHidden = false
        }
    }
    
    func willHideKeyBoard(notity: NSNotification) {
        let n = notity.userInfo
        let value = n?["UIKeyboardFrameEndUserInfoKey"] as! CGRect
        UIView.animate(withDuration: 0.25, animations: { 
            var rect = self.asdasda.frame
            rect.origin.y += value.height + rect.height
            self.asdasda.frame = rect
            self.zhezhoadasd.alpha = 0
        }) { bool in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
