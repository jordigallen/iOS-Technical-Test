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

    private let presenter = Assembler.shared.resolver.resolve(ListPresenterProtocol.self)

    func testPresenterNotNil() {
        expect(self.presenter).toNot(beNil())
    }

    func testHasTVShows_Success() {
        waitUntil(timeout: TestConstants.WaitTime.medium.rawValue) { (done) in
            self.presenter?.fetchTVShows()
            done()
        }
    }
}
