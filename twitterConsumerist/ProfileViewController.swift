//
//  ViewController.swift
//  twitterConsumerist
//
//  Created by Martin Granados Garcia on 5/23/21.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var fullnameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    @IBOutlet var tweetImage: UIImageView!
    @IBOutlet var tweetUsername: UILabel!
    @IBOutlet var tweetTextLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let token = "AAAAAAAAAAAAAAAAAAAAALNGzgAAAAAAKdFeW3XmEaiU4%2BfiQRAcRa1SHuE%3DhCVifEVqbPJP9bU9nU6FdN89pOh50Z6xQIc3KJd1eGEqLznMaq"
        let authToken: String? = "Bearer \(token)"
        let url = URL(string: "https://api.twitter.com/2/users/by?usernames=martingranadosg&user.fields=description,created_at,profile_image_url&expansions=pinned_tweet_id&tweet.fields=author_id,created_at")!

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpAdditionalHeaders = ["Authorization": authToken!]
        let session = URLSession(configuration: sessionConfig)
        let task = session.dataTask(with: url) {
            [unowned self] data, response, error in
            if error != nil {
                print("Error in request: \(String(describing: error))")
            }
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data!) as? [String: Any]
                if let responseData = dictionary!["data"] as? [Any] {
                    print(responseData.first!)
                    let user = responseData.first! as? [String: String]

                    DispatchQueue.main.async {
                        // set profile
                        descriptionLabel.text = user!["description"]
                        fullnameLabel.text = user!["name"]

                        usernameLabel.text = "@\(user!["username"] ?? "")"
                        tweetUsername.text = "@\(user!["username"] ?? "")"

                    }
                    let imageURL = user!["profile_image_url"]
                    let imageDataURL = URL(string: imageURL!)
                    if let imageData = try? Data(contentsOf: imageDataURL!) {
                        if let image = UIImage(data: imageData) {
                            DispatchQueue.main.async {
                                profileImage.image = image
                                tweetImage.image = image
                            }
                        }
                    }
                }
                if let pinnedTweet = dictionary!["includes"] as? [String: Any] {
                    if let tweets = pinnedTweet["tweets"] as? [Any] {
                        print(tweets.first!)
                        let tweetText = tweets.first as! [String: String]
                        DispatchQueue.main.async {
                            tweetTextLabel.text = tweetText["text"]
                        }

                    }
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }


}

