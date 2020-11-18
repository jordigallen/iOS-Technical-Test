//
//  ListTVShowsTests.swift
//  ios-Technical-TestUITests
//
//  Created by JORDI GALLEN RENAU on 16/11/20.
//

import XCTest

class ListTVShowsTests: BaseUITestCase {

    func testTVShowErrorResponse_Success() {
        mockServer.addMockedResponse(ListStub.tvShowErrorEndPointResponse)
        let app = XCUIApplication()
        let tableView = app.tables["ResultTableViewCell"]
        XCTAssert(tableView.cells.count == 0)
    }


    func testTVShowEmptyResponse_Success() {
        mockServer.addMockedResponse(ListStub.tvShowEmptyResponse)
        let app = XCUIApplication()
        let tableView = app.tables["ResultTableViewCell"]
        XCTAssert(tableView.cells.count == 0)
    }

    func testTVShowPage0Response_Success() {
        mockServer.addMockedResponse(ListStub.tvShowPage0Responses)
        let app = XCUIApplication()
        let tableView = app.tables["ResultTableViewCell"]
        XCTAssert(tableView.cells.count == 240)
    }

    func testTVShowPage0Item0Response_Success() {
        mockServer.addMockedResponse(ListStub.tvShowPage0Responses)
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().tables.children(matching: .cell).element(boundBy: 1).staticTexts["Person of Interest"].swipeUp()
    }
}
