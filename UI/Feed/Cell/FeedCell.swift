//
//  FeedCell.swift
//  TwitterFirebase
//
//  Created by Hakan Adanur on 26.01.2023.
//

import Foundation
import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var feedView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userTextLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    
    func configure(tweet: TweetModel){
        usernameLabel.text = tweet.tweetedBy
        userTextLabel.text = tweet.tweetDescription
        setupUI()
    }
    
    private func setupUI() {
        profilePicture.layer.cornerRadius = 24
    }
}
