//
//  ParticipantIdentity.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 29/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ParticipantIdentity {
    
    var player: Player
    var participantId: Int
    
    static func parseJsonArray(json: JSON) -> [ParticipantIdentity] {
        var participantIdentities: [ParticipantIdentity] = []
        json.arrayValue.forEach { (participantIdentity) in
            let pi = ParticipantIdentity.parseJson(json: JSON(participantIdentity))
            participantIdentities.append(pi)
        }
        return participantIdentities
    }
    
    static func parseJson(json: JSON) -> ParticipantIdentity {
        return ParticipantIdentity(
            player: Player.parseJson(json: json["player"]),
            participantId: json["participantId"].intValue
        )
    }
    
}
