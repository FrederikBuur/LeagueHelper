//
//  MatchReference.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 29/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MatchReference {
    
    var gameId: Int
    var champion: Int
    var platformId: Int
    var queue: Int
    
    static func parseJsonArray(json: JSON) -> [MatchReference] {
        var matchReferences: [MatchReference] = []
        json.arrayValue.forEach { (matchReference) in
            let mr = MatchReference.parseJson(json: matchReference)
            matchReferences.append(mr)
        }
        return matchReferences
    }
    
    static func parseJson(json: JSON) -> MatchReference {
        return MatchReference(
            gameId: json["gameId"].intValue,
            champion: json["champion"].intValue,
            platformId: json["platformId"].intValue,
            queue: json["queue"].intValue)
    }
    
}
