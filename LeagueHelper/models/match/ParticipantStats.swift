//
//  ParticipantStats.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 29/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ParticipantStats {
    
    var kills: Int
    var deaths: Int
    var assists: Int
    var win: Bool
    
    static func parseJson(json: JSON) -> ParticipantStats {
        return ParticipantStats(
            kills: json["kills"].intValue,
            deaths: json["deaths"].intValue,
            assists: json["assists"].intValue,
            win: json["win"].boolValue)
    }
    
}
