//
//  ProfileHeaderView.swift
//  twitterConsumerist
//
//  Created by Martin Granados Garcia on 6/5/21.
//

import UIKit

class ProfileHeaderView: UIView {
    @IBOutlet var contentView: UIView!

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var profilePic: UIImage? {
        get {
            return profileImage.image
        }
        set {
            profileImage.image = newValue
        }
    }
    var username: String? {
        get {
            return usernameLabel.text
        }
        set {
            usernameLabel.text = newValue
        }
    }
    var fullName: String? {
        get {
            return fullNameLabel.text
        }
        set {
            fullNameLabel.text = newValue
        }
    }
    var profileDescription: String? {
        get {
            return descriptionLabel.text
        }
        set {
            descriptionLabel.text = newValue
        }
    }

    func createNib() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        nib.instantiate(withOwner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createNib()
    }
}
