//
//  ViewController.swift
//  twitterConsumerist
//
//  Created by Martin Granados Garcia on 5/23/21.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tweetsTableView: UITableView!

    var profileTweets: [String] = []
    var profileUsername: String? = nil
    var profilePic: UIImage? = nil
    let twitterRequestsManager = TwitterRequestsManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self



        twitterRequestsManager.getUserProfile() {
            [unowned self] profileInfo in
            DispatchQueue.main.async {
                // set profile
                let header = ProfileHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: 300.0))
                header.profileDescription = profileInfo["description"]
                header.fullName = profileInfo["fullName"]
                header.username = profileInfo["userName"]
                tweetsTableView.tableHeaderView = header
            }
        }

        twitterRequestsManager.getProfilePic() {
            [unowned self] profilePic in
            DispatchQueue.main.async {
                let header = tweetsTableView.tableHeaderView as! ProfileHeaderView
                header.profilePic = profilePic
                self.profilePic = profilePic
                tweetsTableView.tableHeaderView = header
                self.tweetsTableView.reloadData()
            }
        }

//        twitterRequestsManager.getPinnedTweet() {
//            [unowned self] pinnedTweet in
//            DispatchQueue.main.async {
//                tweetTextLabel.text = pinnedTweet
//            }
//        }

        twitterRequestsManager.getTimelineTweets() {
            [unowned self] tweets in
            profileTweets = tweets
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
        if (profileTweets.count != 0) {
            let tweet = profileTweets[indexPath.row]
            cell.tweetContent.text = tweet
            cell.profilePic.image = self.profilePic
            cell.usernameLabel.text = self.profileUsername
            return cell
        } else {
            return UITableViewCell()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showTweetDetail":
            if let singleTweetViewController = segue.destination as? SingleTweetViewController {

                if let tweet = tweetsTableView.indexPathForSelectedRow?.row {
                    singleTweetViewController.tweetText = profileTweets[tweet]
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

