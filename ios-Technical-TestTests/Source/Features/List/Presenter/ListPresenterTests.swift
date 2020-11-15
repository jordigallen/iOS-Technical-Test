//
//  ListHeroesPresenterTests.swift
//  ios-Technical-TestTests
//
//  Created by JORDI GALLEN RENAU on 15/11/20.
//

import XCTest
import Nimble

@testable import ios_Technical_Test

class ListHeroesPresenterTests: XCTestCase {

    private let usecase = Assembler.shared.resolver.resolve(ListUseCaseProtocol.self)

    func testPresenterNotNil() {
        expect(self.usecase).toNot(beNil())
    }

    func testHasHeroes_WithOut_Search() {
        waitUntil(timeout: TestConstants.WaitTime.medium.rawValue) { (done) in
            self.usecase?.fetchTVShows(0) { tvShows in
                expect(tvShows).toNot(beNil())
                done()
            }
        }
    }

    func testHasHeroes_With_Search() {
        waitUntil(timeout: TestConstants.WaitTime.short.rawValue) { (done) in
            self.usecase?.fetchTVShows(0) { tvShows in
                expect(tvShows).toNot(beNil())
                done()
            }
        }
    }
}
