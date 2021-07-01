//
//  ViewController.swift
//  twitterConsumerist
//
//  Created by Martin Granados Garcia on 5/23/21.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tweetsTableView: UITableView!

    var profileTweets: [Tweet] = []
    var profileUsername: String? = nil
    var profilePic: UIImage? = nil
    let twitterRequestsManager = TwitterRequestsManager()
    let networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        
        networkManager.getUserProfile {
            [unowned self] profile, error in

            guard (error == nil) else {
                return
            }

            DispatchQueue.main.async {
                let header = ProfileHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: 300.0))
                header.profileDescription = profile?.description
                header.fullName = profile?.fullName
                header.username = profile?.userName

                let imageURL = profile?.profileImageUrl.replacingOccurrences(of: "_normal", with: "")
                let imageDataURL = URL(string: imageURL!)
                if let imageData = try? Data(contentsOf: imageDataURL!) {
                    if let profileImage = UIImage(data: imageData) {
                        header.profilePic = profileImage
                        self.profilePic = profileImage
                    }
                }
                tweetsTableView.tableHeaderView = header
            }
        }

        networkManager.getUserTweets {
            [unowned self] tweets, error in
            self.profileTweets = tweets!
            DispatchQueue.main.async {
                self.tweetsTableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetsTableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell

        guard !profileTweets.isEmpty else {
            return UITableViewCell()
        }

        let tweet = profileTweets[indexPath.row]
        cell.tweetContent.text = tweet.text
        cell.profilePic.image = self.profilePic
        cell.usernameLabel.text = self.profileUsername
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showTweetDetail":
            if let singleTweetViewController = segue.destination as? SingleTweetViewController {

                if let tweet = tweetsTableView.indexPathForSelectedRow?.row {
                    singleTweetViewController.tweetText = profileTweets[tweet].text
                    singleTweetViewController.profilePic = self.profilePic
                    singleTweetViewController.username = self.profileUsername
                }
                tweetsTableView.deselectRow(at: tweetsTableView.indexPathForSelectedRow!, animated: true)
            }
        default:
            preconditionFailure("Unknown segue")
        }
    }


}

