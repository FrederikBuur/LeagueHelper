//
//  DataDragonRouter.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 08/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import Alamofire

public enum DataDragonRouter: URLRequestConvertible {
    
    // constants
    enum Constants {
        static let baseUrl = "https://ddragon.leagueoflegends.com"
    }
    
    static func getChampionImagePath(version: String, imgName: String) -> String {
        let url = "\(DataDragonRouter.Constants.baseUrl)/cdn/\(version)/img/champion/\(imgName)"
        //print(url)
        return url
    }
    static func getSummonerSpellImagePath(version: String, imgName: String) -> String {
        let url = "\(DataDragonRouter.Constants.baseUrl)/cdn/\(version)/img/spell/\(imgName)"
        print(url)
        return url
    }
    static func getSummonerIconImagePath(version: String, imgName: Int) -> String {
        let url = "\(DataDragonRouter.Constants.baseUrl)/cdn/\(version)/img/profileicon/\(imgName).png"
        print(url)
        return url
    }
   
    
    case championList(_ version: String, _ region: String)
    case summonerSpells(String, String)
    case latestVersion
    
    var method: HTTPMethod {
        switch self {
        case .championList, .latestVersion, .summonerSpells:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .championList(let version, let region):
            return "/cdn/\(version)/data/\(region)/champion.json"
        case .summonerSpells(let version, let region):
            return "/cdn/\(version)/data/\(region)/summoner.json"
        case .latestVersion:
            return "/api/versions.json"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        default:
            return [:]
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
