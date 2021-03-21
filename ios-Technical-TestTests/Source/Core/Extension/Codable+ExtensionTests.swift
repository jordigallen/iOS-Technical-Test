//
//  Codable+ExtensionTests.swift
//  MarvelTests
//
//  Copyright © 2021 JORDI GALLEN RENAU. All rights reserved.
//

import XCTest
import Nimble

@testable import ios_Technical_Test

// Pattern AAA (Arrange, Act, Assert)

class CodableExtensionTests: XCTestCase {

    private var model: CodableTestModel?

    override func setUp() {
        super.setUp()
        // Arrange
        let name = "Test"
        // Act
        model = CodableTestModel(name: name)

    }

    func test_1_ListResult() {
        // Arrange
        let dict = model?.dictionary
        if let expectValue: String = dict?[self.name] as? String {
            // Act & Assert
            expect(dict).notTo(beNil())
            expect(expectValue).to(equal(self.name))
        }
    }


    func test_2_ListResult() {
        if let dict = model?.dictionary,
            let expctableResult = model?.name {
            do {
                // Act
                let resultModel: CodableTestModel = try CodableTestModel.decode(from: dict)
                // Assert
                expect(expctableResult).to(equal(resultModel.name))
            } catch {
                fail(error.localizedDescription)
            }
        } else {
            fail("test model don't builded properly")
        }
    }

    func test_3_ListResult() {
        if let dict = model?.dictionary,
            let expctableResult = model?.name {
            do {
                let data = try JSONSerialization.data(withJSONObject: dict, options: [])
                // Act
                let resultModel: CodableTestModel = try CodableTestModel.decode(data)
                // Assert
                expect(expctableResult).to(equal(resultModel.name))
            } catch {
                fail(error.localizedDescription)
            }
        } else {
            fail("test model don't builded properly")
        }
    }
}

private struct CodableTestModel: Codable {
    let name: String
}

