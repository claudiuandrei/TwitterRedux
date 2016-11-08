//
//  MentionsViewController.swift
//  Twitter
//
//  Created by Claudiu Andrei on 11/7/16.
//  Copyright © 2016 Claudiu Andrei. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: TweetsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.timeline = .mentions
        tableView.user = User.currentUser
    }
    
    @IBAction func onLogout(_ sender: AnyObject) {
        TwitterAPI.instance?.logout()
    }
}
