//
//  ResultCollectionCelTVShowTests.swift
//  ios-Technical-TestTests
//
//  Created by JORDI GALLEN RENAU on 15/11/20.
//

@testable import ios_Technical_Test
import SnapshotTesting
import XCTest

// Pattern AAA (Arrange, Act, Assert)

class TVShowResultCollectionCelTVShowTests: XCTestCase {
    var cell: ResultTableViewCell!

    override func setUp() {
        super.setUp()
        cell = Bundle.main.loadNibNamed(ResultTableViewCell.nibName, owner: nil, options: [:])?.first as? ResultTableViewCell
    }

    override func tearDown() {
        cell = nil
        super.tearDown()
    }

    func testViewLoadsSuccessfully_withTVShowModel() {
        // Arrange
        let tvShow = TVShowModel.generateTVShow(index: 0)

        // Act
        cell.configureTVShow(with: tvShow)

        // Asssert
        assertSnapshot(matching: cell, as: .image)
    }
}
