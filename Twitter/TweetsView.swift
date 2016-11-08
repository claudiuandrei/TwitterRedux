//
//  TweetsView.swift
//  Twitter
//
//  Created by Claudiu Andrei on 11/7/16.
//  Copyright © 2016 Claudiu Andrei. All rights reserved.
//

import UIKit

enum Timeline:Int {
    case home, user, mentions
}

class TweetsView: UITableView {
    
    // Load the tweets
    var tweets = [Tweet]()
    
    // Setup the changing values
    var timeline: Timeline? = nil {
        didSet {
            reload()
        }
    }
    var user: User? = nil {
        didSet {
            reload()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.delegate = self
        self.dataSource = self
        self.estimatedRowHeight = 128
        self.rowHeight = UITableViewAutomaticDimension
    }
    
    @objc internal func reload() {
        getTweets(from: timeline!)
    }
    
    func success(tweets: [Tweet]) {
        self.tweets = tweets
        
        reloadData()
    }
    func failure(error: Error) {}
    
    private func getTweets(from: Timeline) {
        switch from {
        case .home:
            TwitterAPI.instance?.homeTimeline(maxId: nil, success: success, failure: failure)
        case .mentions:
            TwitterAPI.instance?.mentionsTimeline(maxId: nil, success: success, failure: failure)
        case .user:
            let userId = (user ?? User.currentUser!).id!
            TwitterAPI.instance?.userTimeline(userId: userId, success: success, failure: failure)
        }
    }
}

extension TweetsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetViewCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
}

extension TweetsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
