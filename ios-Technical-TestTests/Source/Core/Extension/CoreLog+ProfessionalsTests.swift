//
//  CoreLog+ProfessionalsTests.swift
//  MarvelTests
//
//  Created by JORDI GALLEN on 14/08/2020.
//  Copyright © 2020 JORDI GALLEN RENAU. All rights reserved.
//

import XCTest
import Nimble

@testable import ios_Technical_Test

// Pattern AAA (Arrange, Act, Assert)

class CoreLogExtensionTests: XCTestCase {

    func test_CoreLogForBusiness() {
        // Arrange
        let identifier = "com.ios-Technical-Test.promofarma"
        let business = "business"

        // Act & Assert
        expect(CoreLog.business.identifier).to(equal(identifier))
        expect(CoreLog.business.category).to(equal(business))
    }

    func test_CoreLogForUI() {
        // Arrange
        let identifier = "com.ios-Technical-Test.promofarma"
        let ui = "ui"

        // Act & Assert
        expect(CoreLog.ui.identifier).to(equal(identifier))
        expect(CoreLog.ui.category).to(equal(ui))
    }

    func test_CoreLogForFirebase() {
        // Arrange
        let identifier = "com.ios-Technical-Test.promofarma"
        let firebase = "firebase"

        // Act & Assert
        expect(CoreLog.firebase.identifier).to(equal(identifier))
        expect(CoreLog.firebase.category).to(equal(firebase))
    }

    func test_CoreLogForRemote() {
        // Arrange
        let identifier = "com.ios-Technical-Test.promofarma"
        let remote = "remote"

        // Act & Assert
        expect(CoreLog.remote.identifier).to(equal(identifier))
        expect(CoreLog.remote.category).to(equal(remote))
    }
}
