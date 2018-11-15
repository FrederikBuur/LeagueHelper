//
//  LeagueRouter.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 01/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import Alamofire

public enum LeagueRouter: URLRequestConvertible {
  
    // constants
    enum Constants {
        static let baseUrl = "https://euw1.api.riotgames.com/lol"
        
        static let apiKey = "RGAPI-b9ead808-47ea-466c-a299-d7e98891a01d"
    }
    
    case summonerByName(String)
    
    var method: HTTPMethod {
        switch self {
        case .summonerByName:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .summonerByName(let name):
            return "/summoner/v3/summoners/by-name/\(name)"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .summonerByName:
            return ["api_key": Constants.apiKey]
        default:
            return [:]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
    
}
