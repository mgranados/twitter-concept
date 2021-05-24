//
//  Tweet.swift
//  twitterConsumerist
//
//  Created by Martin Granados Garcia on 5/23/21.
//

import Foundation

class Tweet {
    var creator: String
    var text: String
    var creatorProfilePic: String
    var creationDate: Date

    init(creator: String, text: String, creatorPic: String, creationDate: Date) {
        self.creator = creator
        self.text = text
        self.creatorProfilePic = creatorPic
        self.creationDate = creationDate
    }
}
