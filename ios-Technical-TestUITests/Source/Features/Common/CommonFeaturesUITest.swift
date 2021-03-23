//
//  CommonFeaturesUITest.swift
//  ios-Technical-TestUITests
//
//  Created by JORDI GALLEN RENAU on 16/11/20.
//

import Foundation

import XCTest

class CommonFeaturesUITest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testLaunchPerformance() throws {
        if #available(iOS 14.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
