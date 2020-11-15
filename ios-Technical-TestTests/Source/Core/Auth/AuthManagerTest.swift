//
//  AuthManagerTest.swift
//  ios-Technical-TestTests
//
//  Created by JORDI GALLEN RENAU on 15/11/20.
//

import XCTest
import Nimble

@testable import ios_Technical_Test

// Pattern AAA (Arrange, Act, Assert)

class AuthManagerTest: XCTestCase {
    
    func testEnvironmentLoad() {
        // Arrange
        let emptyString = ""

        // Act & Assert
        expect(Endpoints.Api.production.rawValue).notTo(equal(emptyString))
    }
}
