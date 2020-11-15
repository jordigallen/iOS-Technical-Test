//
//  ios_Technical_TestTests.swift
//  ios-Technical-TestTests
//
//  Created by JORDI GALLEN RENAU on 12/11/20.
//

import XCTest
import Nimble
import Swinject

@testable import ios_Technical_Test

class Swinject_SummaryTests: XCTestCase {
    func test_PresenterHasInstance() {
        let presenter = Assembler.shared.resolver.resolve(ListPresenterProtocol.self)
        expect(presenter).notTo(beNil())
        expect(presenter).to(beAnInstanceOf(ListPresenter.self))
    }

    func test_UseCaseHasInstance() {
        let useCase = Assembler.shared.resolver.resolve(ListUseCaseProtocol.self)
        expect(useCase).notTo(beNil())
        expect(useCase).to(beAnInstanceOf(ListUseCase.self))
    }

    func test_RepositoryHasInstance() {
        let repository = Assembler.shared.resolver.resolve(ListRepositoryProtocol.self)
        expect(repository).notTo(beNil())
        expect(repository).to(beAnInstanceOf(ListRepository.self))
    }
}
