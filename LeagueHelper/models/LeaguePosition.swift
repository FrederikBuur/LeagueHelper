//
//  LeaguePosition.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 22/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import SwiftyJSON

struct LeaguePosition: Decodable {
    var queueType: String
    var wins: Int
    var losses: Int
    var leagueName: String
    var tier: String
    var rank: String
    var leaguePoints: Int
    
    static func parsJSON(json: JSON) -> [LeaguePosition] {
        var leagues: [LeaguePosition] = []
        let jsonArr = json.arrayValue
        jsonArr.forEach { (league) in
            leagues.append(LeaguePosition(
                queueType: league["queueType"].stringValue,
                wins: league["wins"].intValue,
                losses: league["losses"].intValue,
                leagueName: league["leagueName"].stringValue,
                tier: league["tier"].stringValue,
                rank: league["rank"].stringValue,
                leaguePoints: league["leaguePoints"].intValue)
            )
        }
        return leagues
    }
    
}
