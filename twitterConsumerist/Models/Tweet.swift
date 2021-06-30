//
//  Tweet.swift
//  twitterConsumerist
//
//  Created by Martin Granados Garcia on 5/23/21.
//

import Foundation

struct TweetsApiResponse: Codable {
    let data: [Tweet]
}

struct Tweet: Codable {
    let text: String
    let id: String
}
