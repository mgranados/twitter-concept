//
//  NetworkManager.swift
//  twitterConsumerist
//
//  Created by Martin Granados Garcia on 6/23/21.
//

import Foundation

struct NetworkManager {
    static let environment: NetworkEnvironment = .production
    private let router = Router<TwitterApi>()

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }

    func getUserProfile(_ completion: @escaping (_ profile: Profile?, _ error: String?) -> ()) {
        router.request(.getUserProfile) { data, response, error in
            guard error == nil else {
                completion(nil, "Please check network")
                return
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let profileResponse = try JSONDecoder().decode(ProfileApiResponse.self, from: responseData)
                        completion(profileResponse.data.first, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }

    func getUserTweets(_ completion: @escaping (_ tweets: [Tweet]?, _ error: String?) -> ()) {
        router.request(.getTimelineTweets) { data, response, error in
            guard error == nil else {
                completion(nil, "Please check Network")
                return
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let tweetsResponse = try JSONDecoder().decode(TweetsApiResponse.self, from: responseData)
                        completion(tweetsResponse.data, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
}

enum NetworkResponse: String {
    case success
    case authenticationError = "You missed authentication"
    case badRequest = "Bad Request"
    case outdated = "The URL you requested is outdated"
    case failed = "Network request failed"
    case noData = "Response returned with no data"
    case unableToDecode = "Could not decode the response"
}

enum Result<String> {
    case success
    case failure(String)
}


