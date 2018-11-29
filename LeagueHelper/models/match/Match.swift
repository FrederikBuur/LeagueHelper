//
//  Match.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 29/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Match {
    
    var gameId: Int
    var teams: [TeamStats] = []
    var participants: [Participant] = []
    var participantIdentities: [ParticipantIdentity] = []
    var gameDuration: Int
    
    static func parseJson(json: JSON) -> Match {
        return Match(
            gameId: json["gameId"].intValue,
            teams: TeamStats.parseJsonArray(json: json["teams"]),
            participants: Participant.parseJsonArray(json: json["participants"]),
            participantIdentities: ParticipantIdentity.parseJsonArray(json: json["participantIdentities"]), 
            gameDuration: json["gameDuration"].intValue)
        
    }
    
}
