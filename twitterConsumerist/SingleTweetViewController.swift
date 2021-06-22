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

    @IBOutlet var tweetInput: UITextField!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var tweetTextLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.image = profilePic
        usernameLabel.text = username
        tweetTextLabel.text = tweetText

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillAppear(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        if self.view.frame.origin.y <= 0 {
            self.view.frame.origin.y = -keyboardFrame.cgRectValue.height
        }
    }

    @objc func keyboardWillDisappear(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

}
