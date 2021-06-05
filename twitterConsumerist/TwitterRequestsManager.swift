//
//  TwitterRequestsManager.swift
//  twitterConsumerist
//
//  Created by Martin Granados Garcia on 5/23/21.
//

import UIKit

class TwitterRequestsManager {
    // Instance used to make network calls
    lazy var urlSession: URLSession = {
        let urlSessionConfiguration = URLSessionConfiguration.default
        return URLSession(configuration: urlSessionConfiguration)
    }()

    let twitterToken = "AAAAAAAAAAAAAAAAAAAAALNGzgAAAAAAKdFeW3XmEaiU4%2BfiQRAcRa1SHuE%3DhCVifEVqbPJP9bU9nU6FdN89pOh50Z6xQIc3KJd1eGEqLznMaq"
    typealias GetUserProfileCompletionHandler = (_ profileInfo: [String: String]) -> Void
    typealias GetProfilePicCompletionHandler = (_ profileImage: UIImage) -> Void
    typealias GetPinnedTweetCompletionHandler = (_ pinnedTweet: String) -> Void
    typealias GetTimelineTweetsCompletionHandler = (_ pinnedTweets: [String]) -> Void


    func getUserProfile(completion: @escaping GetUserProfileCompletionHandler) {
        var profileInfo: [String: String] = [:]
        let authToken: String? = "Bearer \(twitterToken)"
        let url = URL(string: "https://api.twitter.com/2/users/by?usernames=martingranadosg&user.fields=description,created_at,profile_image_url&expansions=pinned_tweet_id&tweet.fields=author_id,created_at")!

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpAdditionalHeaders = ["Authorization": authToken!]
        let session = URLSession(configuration: sessionConfig)
        let task = session.dataTask(with: url) {
            data, response, error in
            if error != nil {
                print("Error in request: \(String(describing: error))")
            }
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data!) as? [String: Any]
                if let responseData = dictionary!["data"] as? [Any] {
                    let user = responseData.first! as? [String: String]

                    profileInfo["description"] = user!["description"] ?? ""
                    profileInfo["fullName"] = user!["name"]
                    profileInfo["userName"] = "@\(user!["username"] ?? "")"
                    completion(profileInfo)
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }

    func getProfilePic(completion: @escaping GetProfilePicCompletionHandler) {
        let authToken: String? = "Bearer \(twitterToken)"
        let url = URL(string: "https://api.twitter.com/2/users/by?usernames=martingranadosg&user.fields=description,created_at,profile_image_url&expansions=pinned_tweet_id&tweet.fields=author_id,created_at")!

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpAdditionalHeaders = ["Authorization": authToken!]
        let session = URLSession(configuration: sessionConfig)
        let task = session.dataTask(with: url) {
            data, response, error in
            if error != nil {
                print("Error in request: \(String(describing: error))")
            }
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data!) as? [String: Any]
                if let responseData = dictionary!["data"] as? [Any] {
                    let user = responseData.first! as? [String: String]
                    let imageURL = user!["profile_image_url"]?.replacingOccurrences(of: "_normal", with: "")
                    let imageDataURL = URL(string: imageURL!)
                    if let imageData = try? Data(contentsOf: imageDataURL!) {
                        if let profileImage = UIImage(data: imageData) {
                            completion(profileImage)
                        }
                    }
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }

    func getPinnedTweet(completion: @escaping GetPinnedTweetCompletionHandler) {
        let authToken: String? = "Bearer \(twitterToken)"
        let url = URL(string: "https://api.twitter.com/2/users/by?usernames=martingranadosg&user.fields=description,created_at,profile_image_url&expansions=pinned_tweet_id&tweet.fields=author_id,created_at")!

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpAdditionalHeaders = ["Authorization": authToken!]
        let session = URLSession(configuration: sessionConfig)
        let task = session.dataTask(with: url) {
            data, response, error in
            if error != nil {
                print("Error in request: \(String(describing: error))")
            }
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data!) as? [String: Any]
                if let pinnedTweet = dictionary!["includes"] as? [String: Any] {
                    if let tweets = pinnedTweet["tweets"] as? [Any] {
                        let tweetText = tweets.first as! [String: String]
                        completion(tweetText["text"]!)
                    }
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }

    func getTimelineTweets(completion: @escaping GetTimelineTweetsCompletionHandler) {
        let authToken: String? = "Bearer \(twitterToken)"
        let tweetsURL = URL(string: "https://api.twitter.com/2/users/15061292/tweets?tweet.fields=created_at&expansions=author_id&user.fields=created_at&max_results=10")!
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpAdditionalHeaders = ["Authorization": authToken!]
        let tweetsSession = URLSession(configuration: sessionConfig)
        let tweetsTask = tweetsSession.dataTask(with: tweetsURL) {
            data, response, error in
            if error != nil {
                print("Error in request: \(String(describing: error))")
            }
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data!) as? [String: Any]
                if let responseData = dictionary?["data"] as? [[String: String]] {
                    var tweets: [String] = []
                    for tweet in responseData {
                        tweets.append(tweet["text"]!)
                    }
                    completion(tweets)
                }
            } catch let error {
                print(error)
            }
        }
        tweetsTask.resume()
    }
    
}
