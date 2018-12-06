//
//  Summoner.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 01/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Summoner: Decodable {
    var id: CLong
    var accountId: CLong
    var name: String
    var summonerLevel: CLong
    var profileIconId: Int
    
    static func parsJSON(json: JSON) -> Summoner {
        return Summoner(
            id: json["id"].intValue,
            accountId: json["accountId"].intValue,
            name: json["name"].stringValue,
            summonerLevel: json["summonerLevel"].intValue,
            profileIconId: json["profileIconId"].intValue)
    }
    
    static func isSummonerNameValid(name: String) -> Bool {
        if name.count <= 2 {return false}
        let regex = try! NSRegularExpression(pattern: "^[0-9\\p{L} _.]+$")
        let match = regex.numberOfMatches(in: name,
                                          options: [],
                                          range: NSRange(location: 0, length: name.count))
        if match > 0 {
            return true
        } else {
            return false
        }
    }
    
}
