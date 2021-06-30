//
//  NetworkError.swift
//  twitterConsumerist
//
//  Created by Martin Granados Garcia on 6/23/21.
//

import Foundation

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameters encoding failed"
    case missingURL = "URL is nil"
}
