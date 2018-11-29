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
    case getMatchesByAccount(Int, Int, Int)
    case getMatch(Int)
    
    var method: HTTPMethod {
        switch self {
        case .summonerByName,
             .getLeaguePosition,
             .getMatchesByAccount,
             .getMatch:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .summonerByName(let name):
            return "/summoner/v3/summoners/by-name/\(name)"
        case .getLeaguePosition(let id):
            return "/league/v3/positions/by-summoner/\(id)"
        case .getMatchesByAccount(let id, _, _):
            return "/match/v3/matchlists/by-account/\(id)"
        case .getMatch(let id):
            return "/match/v3/matches/\(id)"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .summonerByName,
             .getLeaguePosition,
             .getMatch:
            return ["api_key": Constants.apiKey]
        case .getMatchesByAccount(_, let beginIndex, let endIndex):
            return ["api_key": Constants.apiKey,
                    "beginIndex": beginIndex,
                    "endIndex": endIndex]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        print("\(try request.asURLRequest().description)")
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
    
}
