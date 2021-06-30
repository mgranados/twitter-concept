//
//  ParameterEncoding.swift
//  twitterConsumerist
//
//  Created by Martin Granados Garcia on 6/23/21.
//

import Foundation

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
