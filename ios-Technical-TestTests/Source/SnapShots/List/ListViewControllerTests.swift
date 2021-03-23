//
//  ListViewControllerTests.swift
//  ios-Technical-TestTests
//
//  Created by JORDI GALLEN RENAU on 15/11/20.
// 

import SnapshotTesting
import XCTest
@testable import ios_Technical_Test

// Pattern AAA (Arrange, Act, Assert)

class ListViewControllerTests: XCTestCase {

    var view: ListViewController =  Router.getListViewController()!

    override func setUp() {
        super.setUp()
        view =  Router.getListViewController()!
    }

    override func tearDown() {
        super.tearDown()
    }

    func testListTVShows_Success() {
        // Arrange & Act
        view.presenter.fetchTVShows()
        // Assert
        assertSnapshot(matching: self.view, as: .image)
    }
}
