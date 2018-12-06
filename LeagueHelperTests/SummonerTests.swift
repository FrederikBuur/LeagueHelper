//
//  SummonerTests.swift
//  LeagueHelperTests
//
//  Created by Frederik Buur on 06/12/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import XCTest
@testable import LeagueHelper

class SummonerTests: XCTestCase {
    
    func testValidateSummonerName() {
        
        let validName1 = "Paul"
        let validName2 = "11 43_"
        let invalidName1 = "@#$%"
        let invalidName2 = "12"
        
        XCTAssert(Summoner.isSummonerNameValid(name: validName1))
        XCTAssert(Summoner.isSummonerNameValid(name: validName2))
        XCTAssert(!Summoner.isSummonerNameValid(name: invalidName1))
        XCTAssert(!Summoner.isSummonerNameValid(name: invalidName2))
    }

}
