//
//  PageViewController.swift
//  EmbeddedPageViewController
//
//  Created by Robert Ryan on 12/7/15.
//  Copyright © 2015 Robert Ryan. All rights reserved.
//

import UIKit

protocol ChildViewControllerProtocol: class {
    var index: Int! { get set }
}

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var childStoryboardIds = ["PageOne", "PageTwo"]
    
    let viewControllerCache = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        setViewControllers([viewControllerForIndex(0)], direction: .Forward, animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        viewControllerCache.removeAllObjects()
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

    func viewControllerForIndex(currentIndex: Int) -> UIViewController {
        // get the storyboard id
        
        let storyboardID = childStoryboardIds[currentIndex]
        
        // see if we have a cached view controller for that page
        
        var childController = viewControllerCache.objectForKey(storyboardID) as? UIViewController
        
        // if not, instantiate one and cache it
        
        if childController == nil {
            childController = storyboard!.instantiateViewControllerWithIdentifier(storyboardID)
            viewControllerCache.setObject(childController!, forKey: storyboardID)
        }
        
        // set the page number
        
        if let controller = childController as? ChildViewControllerProtocol {
            controller.index = currentIndex
        } else {
            print("The \(childController) should conform to ChildViewControllerProtocol")
        }

        // and return the child
        
        return childController!
    }

}
