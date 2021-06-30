//
//  HTTPTask.swift
//  twitterConsumerist
//
//  Created by Martin Granados Garcia on 6/23/21.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request

    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)

    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionalHeaders: HTTPHeaders?)
}
