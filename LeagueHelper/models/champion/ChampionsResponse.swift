//
//  championsResponse.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 04/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class ChampionsResponse {
    
    var type = "type"
    var format = "format"
    var version = "verison"
    var data: [Champion] = []
    
    static func parseJson(json: JSON) -> ChampionsResponse {
        let championResponse = ChampionsResponse()
            championResponse.type = json["type"].stringValue
            championResponse.format = json["format"].stringValue
            championResponse.version = json["version"].stringValue
            championResponse.data = Champion.parseChampionArray(json: json["data"])
        return championResponse
    }

}
