//
//  JAPageViewController.swift
//  ZJTest
//
//  Created by 庄记 on 2017/2/22.
//  Copyright © 2017年 庄记. All rights reserved.
//

import UIKit

class JAPageViewController: UIPageViewController {
    
    weak var jaPageDelegate: JAPageViewControllerDelegate?
    lazy var orderedViewController: [UIViewController] = {
        let first = First1ViewController()
        let seconed = Seconed1ViewController()

        return [first,seconed]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        if let initViewController = orderedViewController.first {
            scrollToViewController(viewController: initViewController)
        }
        jaPageDelegate?.jaPageViewController(self, didUpdatePageCount: orderedViewController.count)
    }
    
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first , let current = orderedViewController.index(of: firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = newIndex >= current ? .forward : .reverse
            let newViewController = orderedViewController[newIndex]
            scrollToViewController(viewController: newViewController, direction: direction)
        }
    }
    
    fileprivate func scrollToViewController(viewController: UIViewController , direction: UIPageViewControllerNavigationDirection = .forward) {
        setViewControllers([viewController], direction: direction, animated: false) { (isComplate) in
            self.notityJaDelegateNewIndex()
        }
    }
    
    fileprivate func notityJaDelegateNewIndex() {
        if let firstViewController = viewControllers?.first {
            if let newIndex = orderedViewController.index(of: firstViewController) {
                jaPageDelegate?.jaPageViewController(self, didUpdatePageIndex: newIndex)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func getMyViewController(_ color: String) -> UIViewController {
        return UIViewController()
    }
}

extension JAPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        notityJaDelegateNewIndex()
    }
}

extension JAPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = orderedViewController.index(of: viewController) else { return nil }
        let previous = index - 1
        guard previous >= 0 else { return orderedViewController.last }
        guard orderedViewController.count > previous else { return nil }
        return orderedViewController[previous]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewController.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        let orderdViewControllersCount = orderedViewController.count
        guard orderdViewControllersCount != nextIndex else { return orderedViewController.first }
        guard orderdViewControllersCount > nextIndex else { return nil }
        return orderedViewController[nextIndex]
    }
}

protocol JAPageViewControllerDelegate: class {
    func jaPageViewController(_ jaPageViewController: JAPageViewController, didUpdatePageCount count: Int)
    
    func jaPageViewController(_ jaPageViewController: JAPageViewController, didUpdatePageIndex index: Int)
}
