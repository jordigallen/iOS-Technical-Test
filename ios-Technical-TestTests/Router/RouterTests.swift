//
//  StorageInstantiateTest.swift
//  ios-Technical-TestTests
//
//  Created by JORDI GALLEN RENAU on 15/11/20.
//

import XCTest
import Nimble

@testable import ios_Technical_Test

// Pattern AAA (Arrange, Act, Assert)
class RouterTests: XCTestCase {

    func test_Storage() {
        // Arrange
        let storage = Router.storage
        // Assert
        expect(storage).to(beAnInstanceOf(StorageManager.self))
    }

    func test_GetList() {
        // Arrange
        let viewController = Router.getListViewController()
        // Assert
        expect(viewController).to(beAnInstanceOf(ListViewController.self))
    }
}

