//
//  Participant.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 29/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Participant {
    
    var id: Int
    var stats: ParticipantStats
    var teamId: Int
    var spell1Id: Int
    var spell2Id: Int
    var championId: Int
    
    static func parseJsonArray(json: JSON) -> [Participant] {
        var participants: [Participant] = []
        json.arrayValue.forEach { (participant) in
            let p = Participant.parseJson(json: participant)
            participants.append(p)
        }
        return participants
    }
    
    static func parseJson(json: JSON) -> Participant {
        return Participant(
            id: json["participantId"].intValue,
            stats: ParticipantStats.parseJson(json: json["stats"]),
            teamId: json["teamId"].intValue,
            spell1Id: json["spell1Id"].intValue,
            spell2Id: json["spell2Id"].intValue,
            championId: json["championId"].intValue)
    }
    
}
