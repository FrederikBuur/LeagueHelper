//
//  RealmController.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 08/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import RealmSwift

class RealmController {
    
    private var realm: Realm
    
    static let sharedInstance = RealmController()
    
    private init() {
        realm = try! Realm()
    }
    
    func saveChampionsOrUpdate(championResponse: ChampionsResponse) {
        try! realm.write {
            for champion in championResponse.data {
                realm.add(champion, update: true)
            }
        }
    }
    
    func saveSummonerSpellsOrUpdate(summonerSpellResponse: SummonerSpellResponse) {
        try! realm.write {
            for summonerSpell in summonerSpellResponse.data {
                realm.add(summonerSpell, update: true)
            }
        }
    }
    
    func saveVersionOrUpdate(version: Version) {
        try! realm.write {
            //version.version = "8.11.1"
            realm.add(version, update: true)
        }
    }
    
    func getChampions() -> Results<Champion> {
        let result = realm.objects(Champion.self)
        return result
    }
    
    func getChampionById(id: Int) -> Champion? {
        let result = realm.objects(Champion.self).filter("key = \(id)").first
        return result
    }
    
    func getSummonerSpellById(id: Int) -> SummonerSpell? {
        let result = realm.objects(SummonerSpell.self).filter("key = \(id)").first
        return result
    }
    
    func getVersion() -> Version? {
        let result = realm.objects(Version.self).first
        if result?.version == "" {
            return nil
        } else {
            return result
        }
    }
    
}
