//
//  BaseErrorTests.swift
//  ios-Technical-TestTests
//
//  Created by Jordi Gallen on 22/3/21.
//

import XCTest
import Nimble
@testable import ios_Technical_Test

// Pattern AAA (Arrange, Act, Assert)

class BaseErrorTests: XCTestCase {
    let reason = "ReasonMock"

    func testEnumRepositoryError_Reason() {
        // Arrange
        let baseErrorReason = BaseError.RepositoryError.reason(reason)
        // Act & Assert
        expect(baseErrorReason).notTo(beNil())
    }

    func testEnumRemoteError_Reason() {
        // Arrange
        let baseErrorReason = BaseError.RemoteError.reason(reason)
        // Act & Assert
        expect(baseErrorReason).notTo(beNil())
    }

    func testAuthError_Reasonn() {
        // Arrange
        let baseErrorReason = BaseError.AuthError.reason(reason)
        // Act & Assert
        expect(baseErrorReason).notTo(beNil())
    }

    func testAuthError_UIError() {
        // Arrange
        let baseErrorReason = BaseError.UIError.reason(reason)
        // Act & Assert
        expect(baseErrorReason).notTo(beNil())
    }
}
