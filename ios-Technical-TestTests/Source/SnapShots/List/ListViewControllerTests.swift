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
    func testListTVShows_Success() {
        // Arrange & Act
        let listView: ListViewController =  Router.getListViewController()!
        listView.presenter.fetchTVShows()
        // Assert
        assertSnapshot(matching: listView, as: .image)
    }

    func testListDetailTVShows_Success() {
        // Arrange & Act
        let listDetailView: UINavigationController =  Router.getDetailViewController(nil, title: nil, gender: nil, sinopsis: nil, puntuation: 10.0)!
        // Assert
        assertSnapshot(matching: listDetailView, as: .image)
    }
}
