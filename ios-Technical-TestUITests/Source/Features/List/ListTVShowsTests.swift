//
//  ListTVShowsTests.swift
//  ios-Technical-TestUITests
//
//  Created by JORDI GALLEN RENAU on 16/11/20.
//

import XCTest

class ListTVShowsTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func test_OpenApp_Succes() throws {
        let app = XCUIApplication()
        app.launch()
    }
}
