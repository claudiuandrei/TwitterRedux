//
//  MenuViewController.swift
//  Twitter
//
//  Created by Claudiu Andrei on 11/6/16.
//  Copyright © 2016 Claudiu Andrei. All rights reserved.
//

import UIKit

enum Item:Int {
    case home, profile, mentions
    
    func description() -> String {
        switch self {
        case .home:
            return "Home"
        case .profile:
            return "Profile"
        case .mentions:
            return "Mentions"
        }
    }
}

class MenuViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Load the menu data
    var hamburgerViewController: HamburgerViewController!
    var viewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       
        // Load the controllers
        let homeNavigationController = storyboard.instantiateViewController(withIdentifier: "HomeNavigationController") as! UINavigationController
        let profileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController") as! UINavigationController
        let mentionsNavigationController = storyboard.instantiateViewController(withIdentifier: "MentionsNavigationController") as! UINavigationController
        
        // Append view controllers
        viewControllers.append(homeNavigationController)
        viewControllers.append(profileNavigationController)
        viewControllers.append(mentionsNavigationController)
        
        // Set the default
        hamburgerViewController.contentViewController = homeNavigationController
    }
    
}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Load the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuViewCell
        
        // Set the title
        cell.title = Item(rawValue: indexPath.row)!.description()
        
        // Cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
}

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Deselect the row
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Set the view controller
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
    }
    
}
