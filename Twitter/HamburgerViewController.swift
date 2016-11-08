//
//  HamburgerViewController.swift
//  Twitter
//
//  Created by Claudiu Andrei on 11/6/16.
//  Copyright © 2016 Claudiu Andrei. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentLeadingConstraint: NSLayoutConstraint!
    
    var openMenuMarginConstraint: CGFloat = 150
    var currentMenuMarginConstraint: CGFloat!
    
    // Set the menu view
    var menuViewController: MenuViewController! {
        didSet {
            view.layoutIfNeeded()
            
            menuViewController.willMove(toParentViewController: self)
            menuView.addSubview(menuViewController.view)
            menuViewController.didMove(toParentViewController: self)
        }
    }
    
    // Set the content view
    var contentViewController: UIViewController! {
        didSet(oldContentViewController) {
            view.layoutIfNeeded()
            
            if oldContentViewController != nil {
                oldContentViewController.willMove(toParentViewController: nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMove(toParentViewController: nil)
            }
            
            contentViewController.willMove(toParentViewController: self)
            contentView.addSubview(contentViewController.view)
            contentViewController.didMove(toParentViewController: self)
            
            // Hide when opening
            hideMenu()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Setup the menu view controller
        let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuViewController.hamburgerViewController = self
        self.menuViewController = menuViewController
        //menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        //menuViewController.hamburgerViewController = self
    }
    
    func hideMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.contentLeadingConstraint.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func showMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.contentLeadingConstraint.constant = self.openMenuMarginConstraint
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func toggleMenu() {
        contentLeadingConstraint.constant == 0 ? showMenu() : hideMenu()
    }
    
    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == .began {
            currentMenuMarginConstraint = contentLeadingConstraint.constant
        } else if sender.state == .changed {
            contentLeadingConstraint.constant = currentMenuMarginConstraint + translation.x
        } else if sender.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .curveEaseIn, animations: {
                if velocity.x > 0 {
                    self.contentLeadingConstraint.constant = self.openMenuMarginConstraint
                } else {
                    self.contentLeadingConstraint.constant = 0
                }
            }, completion: nil)
        }
    }
}
