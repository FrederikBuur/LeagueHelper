//
//  ChampionTests.swift
//  LeagueHelperTests
//
//  Created by Frederik Buur on 06/12/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import XCTest
@testable import LeagueHelper

class ChampionTests: XCTestCase {

    func testChampionsFiltering() {
        
        let champ1 = Champion()
        champ1.name = "Superman"
        let champ2 = Champion()
        champ2.name = "Batman"
        let champ3 = Champion()
        champ3.name = "Superwoman"
        let champ4 = Champion()
        champ4.name = "Ironman"
        
        let champions = [champ1, champ2, champ3, champ4]
        
        let filter1 = Champion.filterChampions(champions: champions, searchText: "Super")
        XCTAssert(filter1.count == 2)
        
        let filter2 = Champion.filterChampions(champions: champions, searchText: "")
        XCTAssert(filter2.count == 4)
        
        let filter3 = Champion.filterChampions(champions: champions, searchText: "Hulk")
        XCTAssert(filter3.count == 0)
        
    }

}
