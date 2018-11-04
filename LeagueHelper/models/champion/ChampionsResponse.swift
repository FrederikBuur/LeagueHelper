//
//  championsResponse.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 04/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ChampionsResponse {
    var type: String
    var format: String
    var version: String
    var data: [Champion]
}
