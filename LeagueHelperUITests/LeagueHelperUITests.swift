//
//  LeagueHelperUITests.swift
//  LeagueHelperUITests
//
//  Created by Frederik Buur on 06/12/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import XCTest

class LeagueHelperUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInvalidInput() {
        
        let app = XCUIApplication()
        let tf = app.textFields["Summoner name..."]
        tf.tap()
        tf.typeText("aa")
        app.buttons["Search"].tap()
        
        let label = app.staticTexts["Invalid summoner name"]
        XCTAssert(label.exists)
        
    }
    
    func testSearchSummoner() {
        
        let app = XCUIApplication()
        let tf = app.textFields["Summoner name..."]
        tf.tap()
        let name = "Great Summoner"
        tf.typeText(name)
        app.buttons["Search"].tap()
        
        let element = app.staticTexts[name]
        let didAppear = element.waitForExistence(timeout: 10)
        XCTAssert(didAppear)
    
    }
        
}
