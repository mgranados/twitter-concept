//
//  EndPointType.swift
//  twitterConsumerist
//
//  Created by Martin Granados Garcia on 6/23/21.
//
import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
