//
//  SummonerSpell.swift
//
//
//  Created by Frederik Buur on 29/11/2018.
//

import Foundation
import SwiftyJSON
import RealmSwift

class SummonerSpell: Object {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = "name"
    @objc dynamic var key: Int = -1
    @objc dynamic var image: Image? = Image()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func parseSummonerSpellArray(json: JSON) -> [SummonerSpell] {
        var summonerSpells: [SummonerSpell] = []
        for summonerSpell in json.dictionaryValue {
            let ss = SummonerSpell.parseSummonerSpell(json: summonerSpell.value)
            summonerSpells.append(ss)
        }
        return summonerSpells
    }
    
    static func parseSummonerSpell(json: JSON) -> SummonerSpell {
        let summonerSpell = SummonerSpell()
        summonerSpell.id = json["id"].stringValue
        summonerSpell.name = json["name"].stringValue
        summonerSpell.key = json["key"].intValue
        summonerSpell.image = Image.parseJson(json: json["image"])
        return summonerSpell
    }
    
}
