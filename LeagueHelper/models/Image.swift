//
//  Image.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 04/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Image: Object {
    @objc dynamic var full = "full"
    @objc dynamic var sprite = "sprite"
    @objc dynamic var group = "group"
    
//    override init(full: String, sprite: String, group: String) {
//        self.full = full
//        self.sprite = sprite
//        self.group = group
//    }
    
    static func parseJson(json: JSON) -> Image {
        let img = Image()
            img.full = json["full"].stringValue
            img.sprite = json["sprite"].stringValue
            img.group = json["group"].stringValue
        return img
    }
    
}
