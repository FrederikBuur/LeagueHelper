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
    @objc dynamic var version = ""
    
    static func getLatestVersion(json: JSON) {
        let version = Version()
        for version in json {
            
        }
    }
}
