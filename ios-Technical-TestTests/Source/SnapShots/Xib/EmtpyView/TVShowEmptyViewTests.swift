//
//  TVShowEmptyViewTests.swift
//  ios-Technical-TestTests
//
//  Created by JORDI GALLEN RENAU on 15/11/20.
//

@testable import ios_Technical_Test
import SnapshotTesting
import XCTest

// Pattern AAA (Arrange, Act, Assert)

class TVShowEmptyViewTests: XCTestCase {
    var view: BaseEmptyView!

    override func setUp() {
        super.setUp()
        view = Bundle.main.loadNibNamed(BaseEmptyView.nibName, owner: nil, options: [:])?.first as? BaseEmptyView
    }

    override func tearDown() {
        view = nil
        super.tearDown()
    }

    func testViewLoadsSuccessfully_withHeroModel() {
        // Act
        view.configure(withImage: Asset.noTVShowsFoundedIcon.image, caption: L10n.IosTechnicalTest.ListViewController.Searching.title, attributedCaption: nil)

        // Assert
        assertSnapshot(matching: view, as: .image)
    }

    func testViewLoadsSuccessfully_noResultFound() {
        // Act
        view.configure(withImage: Asset.noTVShowsFoundedIcon.image, caption: L10n.IosTechnicalTest.ListViewController.Searching.resulNotFound, attributedCaption: nil)

        // Assert
        assertSnapshot(matching: view, as: .image)
    }
}
