//
//  PageViewController.swift
//  EmbeddedPageViewController
//
//  Created by Robert Ryan on 12/7/15.
//  Copyright © 2015 Robert Ryan. All rights reserved.
//

import UIKit

protocol ChildViewControllerProtocol {
    var index: Int! { get set }
}

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var childStoryboardIds = ["PageOne", "PageTwo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        setViewControllers([viewControllerForIndex(0)], direction: .Forward, animated: false, completion: nil)
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let current = viewController as! ChildViewControllerProtocol

        if let index = current.index where index > 0 {
            return viewControllerForIndex(index - 1)
        }
        
        return nil
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let current = viewController as! ChildViewControllerProtocol
        
        if let index = current.index where index < (childStoryboardIds.count - 1) {
            return viewControllerForIndex(index + 1)
        }
        
        return nil
    }

    func viewControllerForIndex(index: Int) -> UIViewController {
        let childController = storyboard!.instantiateViewControllerWithIdentifier(childStoryboardIds[index])
        (childController as? ChildViewController)?.index = index
        return childController
    }

}
