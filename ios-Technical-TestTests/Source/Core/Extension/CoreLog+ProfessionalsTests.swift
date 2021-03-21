//
//  CoreLog+ProfessionalsTests.swift
//  MarvelTests
//
//  Copyright © 2021 JORDI GALLEN RENAU. All rights reserved.
//

import XCTest
import Nimble

@testable import ios_Technical_Test

// Pattern AAA (Arrange, Act, Assert)

class CoreLogExtensionTests: XCTestCase {

    func test_CoreLogForBusiness() {
        // Arrange
        let business = "business"

        // Act & Assert
        expect(CoreLog.business.category).to(equal(business))
    }

    func test_CoreLogForUI() {
        // Arrange
        let ui = "ui"

        // Act & Assert
        expect(CoreLog.ui.category).to(equal(ui))
    }

    func test_CoreLogForFirebase() {
        // Arrange
        let firebase = "firebase"

        // Act & Assert
        expect(CoreLog.firebase.category).to(equal(firebase))
    }

    func test_CoreLogForRemote() {
        // Arrange
        let remote = "remote"

        // Act & Assert
        expect(CoreLog.remote.category).to(equal(remote))
    }
}
