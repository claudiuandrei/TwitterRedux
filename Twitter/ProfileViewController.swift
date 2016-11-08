//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Claudiu Andrei on 11/6/16.
//  Copyright © 2016 Claudiu Andrei. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: TweetsView!
    
    @IBOutlet weak var tagLine: UILabel!
    @IBOutlet weak var friendsCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var statusesCountLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    
    internal var user: User! {
        didSet {
            view.layoutIfNeeded()
            
            tagLine.text = user.tagLine
            friendsCountLabel.text = "\(user.friendsCount)"
            followersCountLabel.text = "\(user.followersCount)"
            statusesCountLabel.text = "\(user.statusesCount)"
            
            if let bannerImageUrl = user.bannerImageUrl {
                headerImageView.setImageWith(bannerImageUrl)
            }
            
            // Set the user for the table view
            tableView.user = user
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.timeline = .user
        if user == nil || user == User.currentUser {
            user = User.currentUser!
        }
    }
    
    @IBAction func onLogout(_ sender: AnyObject) {
        TwitterAPI.instance?.logout()
    }
}
