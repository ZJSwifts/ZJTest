//
//  JATabbarViewController.swift
//  ZJTest
//
//  Created by 庄记 on 2017/2/22.
//  Copyright © 2017年 庄记. All rights reserved.
//

import UIKit

class JATabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        //  初始化一些要用到的参数
//        let WINDOW_HEIGHT = self.view.frame.height
//        let TAB_HEIGHT = self.tabBar.frame.height + 20
//        let GRID_WIDTH = self.view.frame.width / 5
//        let BTN_WIDTH = TAB_HEIGHT
//        let BTN_HEIGHT = TAB_HEIGHT
//        
//        //  遮罩层，用于遮挡原本的 TabBarItem
//        let modalView = UIView()
//        modalView.frame = CGRect(x:GRID_WIDTH * 2, y:WINDOW_HEIGHT - TAB_HEIGHT, width:GRID_WIDTH, height:TAB_HEIGHT)
//        self.view.addSubview(modalView)
//        
//        //  添加自定义按钮
//        let postBtn = UIButton()
//        postBtn.frame = CGRect(x:GRID_WIDTH * 2 + (GRID_WIDTH - BTN_WIDTH) / 2, y:WINDOW_HEIGHT - TAB_HEIGHT,width:BTN_WIDTH, height:BTN_HEIGHT)
//        postBtn.addTarget(self, action: #selector(self.tap1), for: .touchUpInside)
//        postBtn.layer.cornerRadius = TAB_HEIGHT/2
//        postBtn.backgroundColor = UIColor.orange
//        self.view.addSubview(postBtn)
        
        //隐藏导航栏底部的线
//        let navBg = UIImage.getWith(UIColor.color("FAFAFA"), size: CGSize(width: UIScreen.main.bounds.width, height: 64))
//        let tabBg = UIImage.getWith(UIColor.color("FAFAFA"), size: CGSize(width: UIScreen.main.bounds.width, height: 49))
//        let tabShadow = UIImage.getWith(UIColor.color("EFEFEF"), size: CGSize(width: UIScreen.main.bounds.width, height: 1))
//        
//        UINavigationBar.appearance().isTranslucent = false
//        UINavigationBar.appearance().tintColor = UIColor.color(75, 75, 75)
//        UINavigationBar.appearance().setBackgroundImage(navBg, for:.default)
//        UINavigationBar.appearance().shadowImage = tabShadow
//        UINavigationBar.appearance().titleTextAttributes = Attributes.build(){
//            $0.font = UIFont.systemFont(ofSize: 17)
//            $0.textColor = UIColor.color("181818")
//            $0.textStroke = (0.0, UIColor.color("181818"))
//            }.dict
//        UINavigationBar.appearance().tintColor = UIColor.color("181818")
        //隐藏Tabbar的线条  自己绘制一条线上去
//        UITabBar.appearance().isTranslucent = false
//        UITabBar.appearance().shadowImage =  UIImage().getWith(UIColor.myColor(253, green: 210, blue: 170), size: CGSize(width: screenWidth, height: 1))
//        UITabBar.appearance().backgroundImage = UIImage()
        
        //  给按钮添加事件
    //    postBtn.addTarget(self, action: "postButtonClicked:", forControlEvents: .TouchUpInside)
    }
    
    func tap1() {
        print("点击了")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
