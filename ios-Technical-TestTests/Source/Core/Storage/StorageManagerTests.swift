//
//  StorageManagerTests.swift
//  ios-Technical-TestTests
//
//  Created by JORDI GALLEN RENAU on 15/11/20.
//

import XCTest
import Nimble

@testable import ios_Technical_Test

class StorageManagerTests: XCTestCase {

    private let store: StorageManagerProtocol = StorageManager()

    override func setUp() {
        super.setUp()
        // Act
        store.deleteAll()
    }

    override func tearDown() {
        super.tearDown()
        // Act
        store.deleteAll()
    }

    // MARK: Secured

    func test_1_SaveSecuredObjectSuccess() {
        // Arrange
        let data: [ModelBuilderTest] = [ModelBuilderTest(name: "ElectroMaps"), ModelBuilderTest(name: "Marvel")]
        // Act
        store.save(object: data, by: "testSaveObjectSuccess", isSecured: true)
        if let storedData: [ModelBuilderTest] = store.get(by: "testSaveObjectSuccess", isSecured: true) {
            // Assert
            expect(storedData).notTo(beNil())
            expect(storedData).notTo(beEmpty())
            expect(storedData.count).to(equal(2))
        }
    }

    func test_2_SaveSecuredObjectFailure() {
        // Act
        store.save(object: "testString", by: "testSaveObjectSuccess", isSecured: true)
        let storedData: [ModelBuilderTest]? = store.get(by: "testSaveObjectSuccess", isSecured: true) ?? nil
        // Assert
        expect(storedData).to(beNil())
    }

    func test_3_DeleteSecuredObject() {
        // Arrange
        let data: [ModelBuilderTest] = [ModelBuilderTest(name: "ElectroMaps"), ModelBuilderTest(name: "Marvel")]
        defer {
            // Act
            store.delete(by: "testSaveObjectSuccess")
            let storedData: [ModelBuilderTest]? = store.get(by: "testSaveObjectSuccess", isSecured: true)
            // Assert
            expect(storedData).to(beNil())
        }
        store.save(object: data, by: "testSaveObjectSuccess", isSecured: true)
    }

    func test_4_DeleteSecuredAllObjects() {
        let data: [ModelBuilderTest] = [ModelBuilderTest(name: "ElectroMaps"), ModelBuilderTest(name: "Marvel")]
        defer {
            // Act
            store.deleteAll()
            let storedData: [ModelBuilderTest]? = store.get(by: "testSaveObjectSuccess", isSecured: true)
            // Assert
            expect(storedData).to(beNil())
        }
        store.save(object: data, by: "testSaveObjectSuccess", isSecured: true)
    }

    // MARK: Non secured

    func test_5_SaveNonSecuredObjectSuccess() {
        let data: [ModelBuilderTest] = [ModelBuilderTest(name: "ElectroMaps"), ModelBuilderTest(name: "Marvel")]
        // Act
        store.save(object: data, by: "testSaveObjectSuccess", isSecured: false)
        if let storedData: [ModelBuilderTest] = store.get(by: "testSaveObjectSuccess", isSecured: false) {
            // Assert
            expect(storedData).notTo(beNil())
            expect(storedData).notTo(beEmpty())
            expect(storedData.count).to(equal(2))
        }
    }

    func test_6_SaveNonSecuredObjectFailure() {
        store.save(object: "testString", by: "testSaveObjectSuccess", isSecured: false)
        // Act
        let storedData: [ModelBuilderTest]? = store.get(by: "testSaveObjectSuccess", isSecured: false) ?? nil
        // Assert
        expect(storedData).to(beNil())
    }

    func test_7_DeleteNonSecuredObject() {
        let data: [ModelBuilderTest] = [ModelBuilderTest(name: "ElectroMaps"), ModelBuilderTest(name: "Marvel")]
        defer {
            store.delete(by: "testSaveObjectSuccess")
            // Act
            let storedData: [ModelBuilderTest]? = store.get(by: "testSaveObjectSuccess", isSecured: false)
            // Assert
            expect(storedData).to(beNil())
        }
        store.save(object: data, by: "testSaveObjectSuccess", isSecured: true)
    }

    func test_8_DeleteNonSecuredAllObjects() {
        let data: [ModelBuilderTest] = [ModelBuilderTest(name: "ElectroMaps"), ModelBuilderTest(name: "Marvel")]
        defer {
            // Arrange
            store.deleteAll()
            // Act
            let storedData: [ModelBuilderTest]? = store.get(by: "testSaveObjectSuccess", isSecured: false)
            // Assert
            expect(storedData).to(beNil())
        }
        store.save(object: data, by: "testSaveObjectSuccess", isSecured: false)
    }
}

private struct ModelBuilderTest: Codable {
    let name: String
}

