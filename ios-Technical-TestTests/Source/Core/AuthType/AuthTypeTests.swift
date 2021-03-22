//
//  AuthTypeTests.swift
//  ios-Technical-TestTests
//
//  Created by Jordi Gallen on 22/3/21.
//

import XCTest
import Nimble

@testable import ios_Technical_Test

// Pattern AAA (Arrange, Act, Assert)
class AuthTypeTests: XCTestCase {

    private let authTypeMock = ["keyErrorType":"ValueErrorValue"]

    func testAuthTypeNone() {
        // Arrange
        let authType = AuthType.none
        // Act & Assert
        expect(authType).notTo(beNil())
    }

    func testAuthTypeOther() {
        // Arrange
        let authType = AuthType.other(authTypeMock)
        // Act & Assert
        expect(authType).notTo(beNil())
    }
}
