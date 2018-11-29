//
//  SummonerSpellResponse.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 29/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import SwiftyJSON

class SummonerSpellResponse {
    
    var version: String = "version"
    var data: [SummonerSpell] = []
    
    static func parseJson(json: JSON) -> SummonerSpellResponse {
        let summonerSpellResponse = SummonerSpellResponse()
        summonerSpellResponse.version = json["version"].stringValue
        summonerSpellResponse.data = SummonerSpell.parseSummonerSpellArray(json: json["data"])
        return summonerSpellResponse
    }
    
}
