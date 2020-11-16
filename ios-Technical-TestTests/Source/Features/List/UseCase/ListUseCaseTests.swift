//
//  ListUseCaseTests.swift
//  ios-Technical-TestTests
//
//  Created by JORDI GALLEN RENAU on 15/11/20.
//

import XCTest
import Nimble

@testable import ios_Technical_Test

class ListUseCaseTests: XCTestCase {

    private let useCase = Assembler.shared.resolver.resolve(ListUseCaseProtocol.self)

    func testUseCaseNotNil() {
        expect(self.useCase).toNot(beNil())
    }


    func test_Hash_TVShows_Success() {
        waitUntil(timeout: TestConstants.WaitTime.short.rawValue) { (done) in
            self.useCase?.fetchTVShows(0) { tvShows in
                expect(tvShows).toNot(beNil())
                done()
            }
        }
    }

    func test_Hash_TVShows_Failure() {
        waitUntil(timeout: TestConstants.WaitTime.short.rawValue) { (done) in
            self.useCase?.fetchTVShows(-1) { tvShows in
                expect(tvShows).toNot(beNil())
                done()
            }
        }
    }
}
