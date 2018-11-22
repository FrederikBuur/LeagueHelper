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
                realm.add(champion)
            }
            let version = Version()
            version.version = championResponse.version
            realm.add(version)
        }
    }
    
    func getChampions() -> Results<Champion> {
        let result = realm.objects(Champion.self)
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
