//
//  SeconedViewController.swift
//  ZJTest
//
//  Created by 庄记 on 2017/1/10.
//  Copyright © 2017年 庄记. All rights reserved.
//

import UIKit

class SeconedViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,JAWaterFallLayoutDelegate {

    var dataCount = 20
    var columnCount = 2
    
    var tabbarController: JTTabbarController?
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brown
        (collectionView.collectionViewLayout as? JAWaterFallLayout)?.delegate = self

        let first = First1ViewController()
        first.title = "第一个界面"
        let seconed = Seconed1ViewController()
        seconed.title = "第二个界面"
        self.tabbarController = JTTabbarController(frame: self.view.bounds, subViewControllers: [first,seconed])
        self.tabbarController?.add(to: self)
       // self.tabbarController?.scrollEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        cell.contentView.backgroundColor    = [UIColor.blue, UIColor.red, UIColor.yellow][indexPath.row % 3]
        cell.contentView.clipsToBounds      = true
        cell.contentView.layer.cornerRadius = 5
        return cell
    }
    
    func waterFall(_ collectionView: UICollectionView, layout waterFallLayout: JAWaterFallLayout, heightForItemAt indexPath: IndexPath) -> CGFloat {
        let height = 200 + arc4random() % 100
        return CGFloat(height)
    }
    
    func columOfWaterFall(_ collectionView: UICollectionView) -> Int {
        return columnCount
    }
    
    override func tap() {
//        unRigthIn(vc: self, time: 0.5, trans: .push) { 
//            print("出栈")
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
