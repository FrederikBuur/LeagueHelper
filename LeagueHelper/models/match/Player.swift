//
//  Player.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 29/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Player {
    
    var summonerName: String
    var summonerId: Int
    var accountId: Int
    
    static func parseJson(json: JSON) -> Player {
        return Player(
            summonerName: json["summonerName"].stringValue,
            summonerId: json["summonerId"].intValue,
            accountId: json["accountId"].intValue)
    }
    
}
