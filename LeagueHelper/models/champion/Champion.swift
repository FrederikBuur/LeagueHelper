//
//  Champion.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 04/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Champion: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var key: Int = -1
    @objc dynamic var name: String = "name"
    @objc dynamic var title: String = "title"
    @objc dynamic var image: Image? = Image()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func parseChampionArray(json: JSON) -> [Champion] {
        var champions: [Champion] = []
        for champion in json.dictionaryValue {
            let c = Champion.parseChampion(json: champion.value)
            champions.append(c)
        }
        return champions
    }
    
    static func parseChampion(json: JSON) -> Champion {
        let champion = Champion()
            champion.id = json["id"].stringValue
            champion.key = json["key"].intValue
            champion.name = json["name"].stringValue
            champion.title = json["title"].stringValue
            champion.image = Image.parseJson(json: json["image"])
        return champion
    }
}

