//
//  GenericAlertsViewControllerTests.swift
//  ios-Technical-TestTests
//
//  Created by JORDI GALLEN RENAU on 15/11/20.
//

import SnapshotTesting
import XCTest
@testable import ios_Technical_Test

// Pattern AAA (Arrange, Act, Assert)

class GenericAlertsViewControllerTests: XCTestCase {
    var view: ListViewController!

    override func setUp() {
        super.setUp()
        self.view = ListViewController()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGenericAlert_ErrorNetwork_Connection_LoadsSuccess() {
        // Arrange
        self.view.createGenericAlert(L10n.IosTechnicalTest.ErrorNetwork.Generic.title, with: L10n.IosTechnicalTest.ErrorNetwork.Generic.description, and: L10n.Shared.accept)
        // Assert
        assertSnapshot(matching: view, as: .image)

    }


    func testGenericAlert_ErrorNetwork_Generic_LoadsSuccess() {
        // Arrange
        self.view.createGenericAlert(L10n.IosTechnicalTest.ErrorNetwork.Generic.title, with: L10n.IosTechnicalTest.ErrorNetwork.Generic.description, and: L10n.Shared.accept)
        // Assert
        assertSnapshot(matching: view, as: .image)
    }

    func testGenericAlert_ErrorNetwork_Maintenance_LoadsSuccess() {
        // arrange
        self.view.createGenericAlert(L10n.IosTechnicalTest.ErrorNetwork.Maintenance.title, with: L10n.IosTechnicalTest.ErrorNetwork.Maintenance.description, and: L10n.Shared.accept)
        // Assert
        assertSnapshot(matching: view, as: .image)
    }

}

