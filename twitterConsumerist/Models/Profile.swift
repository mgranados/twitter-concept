//
//  Profile.swift
//  twitterConsumerist
//
//  Created by Martin Granados Garcia on 6/24/21.
//

import Foundation

struct ProfileApiResponse: Codable {
    let data: [Profile]
}

struct Profile: Codable {
    let description: String
    let fullName: String
    let userName: String
    let id: String
    let profileImageUrl: String
}

extension Profile {
    enum CodingKeys: String, CodingKey {
        case description
        case fullName = "name"
        case userName = "username"
        case id
        case profileImageUrl = "profile_image_url"
    }
}
