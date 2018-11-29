//
//  MatchList.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 29/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MatchList {
    
    var matches: [MatchReference] = []
    
    static func parseJson (json: JSON) -> MatchList {
        return MatchList(
            matches: MatchReference.parseJsonArray(json: json["matches"])
        )
    }
    
}
