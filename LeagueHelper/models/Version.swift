//
//  Version.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 08/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Version: Object {
    @objc dynamic var id = 1
    @objc dynamic var version = "version"
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func getLatestVersion(json: JSON) -> Version {
        let version = Version()
        if let latestVersion = json.arrayValue.first?.stringValue {
            version.version = latestVersion
        } else {
            version.version = "8.17.2"
        }
        return version
    }
}
