//
//  TeamStats.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 29/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TeamStats {
    
    var teamId: Int
    var win: String
    
    static func parseJsonArray(json: JSON) -> [TeamStats] {
        var teamStatsArr: [TeamStats] = []
        json.arrayValue.forEach { (teamStats) in
            let ts = TeamStats.parseJson(json: teamStats)
            teamStatsArr.append(ts)
        }
        return teamStatsArr
    }
    
    static func parseJson(json: JSON) -> TeamStats {
        return TeamStats(
            teamId: json["teamId"].intValue,
            win: json["win"].stringValue
        )
    }
    
}
