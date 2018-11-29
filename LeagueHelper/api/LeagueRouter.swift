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
        static let apiKey = "RGAPI-9c058e6c-5430-4bea-9df1-89c1bb123765"
    }
    
    case summonerByName(String)
    case getLeaguePosition(Int)
    
    var method: HTTPMethod {
        switch self {
        case .summonerByName, .getLeaguePosition:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .summonerByName(let name):
            return "/summoner/v3/summoners/by-name/\(name)"
        case .getLeaguePosition(let id):
            return "/league/v3/positions/by-summoner/\(id)"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .summonerByName, .getLeaguePosition:
            return ["api_key": Constants.apiKey]
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
