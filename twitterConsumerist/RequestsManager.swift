//
//  RequestsManager.swift
//  twitterConsumerist
//
//  Created by Martin Granados Garcia on 5/23/21.
//

import Foundation

class RequestsManager {
    // Instance used to make network calls
    lazy var urlSession: URLSession = {
        let urlSessionConfiguration = URLSessionConfiguration.default
        return URLSession(configuration: urlSessionConfiguration)
    }()
}
