//
//  RouterTests.swift
//  ios-Technical-TestTests
//
//  Created by JORDI GALLEN RENAU on 23/3/21.
//

import XCTest
import Nimble
@testable import ios_Technical_Test

// Pattern AAA (Arrange, Act, Assert)

final class RouterTests: XCTestCase {
    func checkInstanceStorageInRouterTests() {
        // Arrange
        let storage = Router()
        // Act & Assert
        expect(storage).notTo(beNil())
    }
}
