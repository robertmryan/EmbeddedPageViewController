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

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var childStoryboardIds = ["PageOne", "PageTwo"]
    
    let viewControllerCache = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        let controller = viewControllerForIndex(0)
        setViewControllers([controller], direction: .Forward, animated: false, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        updatePageForPageViewController(self, toPageForController: viewControllers![0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        viewControllerCache.removeAllObjects()
    }
    
    // MARK: UIPageViewControllerDelegate
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        updatePageForPageViewController(pageViewController, toPageForController: pendingViewControllers[0])
    }
    
    // MARK: UIPageViewControllerDataSource
    
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

    // MARK: Helper methods
    
    /// Update parent that the page changed
    ///
    /// - parameter pageViewController:   The page view controller for which the page has changed
    /// - parameter toPageForController:  The child/page controller that we have transitioned to
    
    func updatePageForPageViewController(pageViewController: UIPageViewController, toPageForController controller: UIViewController) {
        if let child = controller as? ChildViewControllerProtocol {
            if let parent = parentViewController as? PageChangeDelegate {
                parent.didChangePage(child.index, total: childStoryboardIds.count)
            }
        }
    }
    
    /// Retrieve view controller for this page number (index)
    ///
    /// - parameter currentIndex:   The page number for which we want to retrieve the view controller.
    /// 
    /// - returns:                  The view controller associated with this page number (index).
    
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
