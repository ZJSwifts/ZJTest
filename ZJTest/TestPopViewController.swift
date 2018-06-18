//
//  TestPopViewController.swift
//  ZJTest
//
//  Created by 庄记 on 2017/2/28.
//  Copyright © 2017年 庄记. All rights reserved.
//

import UIKit

class TestPopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func action(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopView")
        self.addChildViewController(vc!)
        self.view.addSubview((vc?.view)!)
    }
}
