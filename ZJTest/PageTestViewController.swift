//
//  PageTestViewController.swift
//  ZJTest
//
//  Created by 庄记 on 2017/2/22.
//  Copyright © 2017年 庄记. All rights reserved.
//

import UIKit

class PageTestViewController: UIViewController {

    
    @IBOutlet weak var containter: UIView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    var jaPageViewController: JAPageViewController? {
        didSet {
            jaPageViewController?.jaPageDelegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.addTarget(self, action: #selector(self.didChangePageControlValue), for: .valueChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? JAPageViewController {
            self.jaPageViewController = tutorialPageViewController
        }
    }
    func didChangePageControlValue() {
        jaPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PageTestViewController: JAPageViewControllerDelegate {
    func jaPageViewController(_ jaPageViewController: JAPageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func jaPageViewController(_ jaPageViewController: JAPageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
}
