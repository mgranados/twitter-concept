//
//  SingleTweetViewController.swift
//  twitterConsumerist
//
//  Created by Martin Granados Garcia on 5/27/21.
//

import UIKit

class SingleTweetViewController: UIViewController {
    var profilePic: UIImage?
    var username: String?
    var tweetText: String?

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var tweetTextLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.image = profilePic
        usernameLabel.text = username
        tweetTextLabel.text = tweetText
    }
}
