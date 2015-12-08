//
//  ViewController.swift
//  EmbeddedPageViewController
//
//  Created by Robert Ryan on 12/7/15.
//  Copyright © 2015 Robert Ryan. All rights reserved.
//

import UIKit

/// Protocol for child to notify parent that page number changed

protocol PageChangeDelegate {
    
    /// Page changed
    ///
    /// - parameter page:  The zero-based index of the page we're going to
    /// - parameter total: The count of pages
    
    func didChangePage(page: Int, total: Int)
}

class ViewController: UIViewController, PageChangeDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func didChangePage(page: Int, total: Int) {
        print("\(page) of \(total)")
    }

    @IBAction func didTapButtonOne(sender: UIButton) {
        print(__FUNCTION__)
    }

    @IBAction func didTapButtonTwo(sender: UIButton) {
        print(__FUNCTION__)
    }
}

