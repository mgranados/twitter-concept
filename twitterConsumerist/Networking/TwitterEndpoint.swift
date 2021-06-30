//
//  TwitterEndpoint.swift
//  twitterConsumerist
//
//  Created by Martin Granados Garcia on 6/24/21.
//

import Foundation

enum NetworkEnvironment {
    case production
}

public enum TwitterApi {
    case getUserProfile
    case getPinnedTweet
    case getTimelineTweets
}

extension TwitterApi: EndPointType {
    var environmentURL : String {
        switch NetworkManager.environment {
        case .production: return "https://api.twitter.com/2/"
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentURL) else { fatalError("baseURL failed") }
        return url
    }

    var path: String {
        switch self {
        case .getPinnedTweet:
            return "users/by"
        case .getUserProfile:
            return "users/by"
        case .getTimelineTweets:
            return "users/15061292/tweets"
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        switch self {
        case .getUserProfile:
            return .requestParameters(bodyParameters: nil, urlParameters: ["usernames": "martingranadosg",
                                                                           "user.fields": "description,created_at,profile_image_url",
                                                                           "expansions": "pinned_tweet_id"])
        case .getPinnedTweet:
            return .requestParameters(bodyParameters: nil, urlParameters: ["usernames": "martingranadosg",
                                                                           "user.fields": "description,created_at,profile_image_url",
                                                                           "expansions": "pinned_tweet_id"])
        case .getTimelineTweets:
            return .requestParameters(bodyParameters: nil, urlParameters: ["tweet.fields": "created_at",
                                                                           "expansions": "author_id",
                                                                           "user.fields": "created_at",
                                                                           "max_results": "10"
            ])
        default:
            return .request
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}
