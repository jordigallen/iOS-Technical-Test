//
//  TVShowModelTest.swift
//  ios-Technical-TestTests
//
//  Created by JORDI GALLEN RENAU on 15/11/20.
//

import Nimble
import XCTest

@testable import ios_Technical_Test

class TVShowModelTest: XCTestCase {
    func test_Decode_Success() {
        // Arrange
        let jsonString = "{\"id\": 0, \"name\": \"NAMETEST\", \"type\": \"TYPETEST\", \"image\": {\"path\": \"IMAGEPATHTEST\"}, \"summary\": \"SUMMARYTEST\", \"rating\": {\"ratingAverage\": 8.5}}"

        // Act
        let expectedTVShow = TVShowModel.generateTVShow()
        let data = jsonString.data(using: .utf8) ?? Data()

        // Assert
        expect(try JSONDecoder().decode(TVShowModel.self, from: data)).to(equal(expectedTVShow))
    }

    func test_Decode_Success_MissingName() {
        // Arrange
        let jsonString = "{\"id\": 0, \"name\": \"\", \"type\": \"TYPETEST\", \"image\": {\"path\": \"IMAGEPATHTEST\"}, \"summary\": \"SUMMARYTEST\", \"rating\": {\"ratingAverage\": 8.5}}"

        // Act
        let expectedTVShow = TVShowModel(id: 0, name: "", type: "TYPETEST", image: ImageModel(path: "IMAGEPATHTEST"), summary: "SUMMARYTEST", rating: RatingModel(ratingAverage: 8.5))
        let data = jsonString.data(using: .utf8) ?? Data()

        // Assert
        expect(try JSONDecoder().decode(TVShowModel.self, from: data)).to(equal(expectedTVShow))
    }

    func test_Decode_Success_MissingType() {
        // Arrange
        let jsonString = "{\"id\": 0, \"name\": \"NAMETEST\", \"type\": \"\", \"image\": {\"path\": \"IMAGEPATHTEST\"}, \"summary\": \"SUMMARYTEST\", \"rating\": {\"ratingAverage\": 8.5}}"

        // Act
        let expectedTVShow = TVShowModel(id: 0, name: "NAMETEST", type: "", image: ImageModel(path: "IMAGEPATHTEST"), summary: "SUMMARYTEST", rating: RatingModel(ratingAverage: 8.5))
        let data = jsonString.data(using: .utf8) ?? Data()

        // Assert
        expect(try JSONDecoder().decode(TVShowModel.self, from: data)).to(equal(expectedTVShow))
    }

    func test_Decode_Success_MissingImage() {
        // Arrange
        let jsonString = "{\"id\": 0, \"name\": \"NAMETEST\", \"type\": \"TYPETEST\", \"image\": {\"path\": \"\"}, \"summary\": \"SUMMARYTEST\", \"rating\": {\"ratingAverage\": 8.5}}"

        // Act
        let expectedTVShow = TVShowModel(id: 0, name: "NAMETEST", type: "", image: ImageModel(path: ""), summary: "SUMMARYTEST", rating: RatingModel(ratingAverage: 8.5))
        let data = jsonString.data(using: .utf8) ?? Data()

        // Assert
        expect(try JSONDecoder().decode(TVShowModel.self, from: data)).to(equal(expectedTVShow))
    }

    func test_Decode_Success_MissingSummary() {
        // Arrange
        let jsonString = "{\"id\": 0, \"name\": \"NAMETEST\", \"type\": \"TYPETEST\", \"image\": {\"path\": \"IMAGEPATHTEST\"}, \"summary\": \"\", \"rating\": {\"ratingAverage\": 8.5}}"

        // Act
        let expectedTVShow = TVShowModel(id: 0, name: "NAMETEST", type: "", image: ImageModel(path: ""), summary: "", rating: RatingModel(ratingAverage: 8.5))
        let data = jsonString.data(using: .utf8) ?? Data()

        // Assert
        expect(try JSONDecoder().decode(TVShowModel.self, from: data)).to(equal(expectedTVShow))
    }


    func test_Encode() throws {
        // Arrange
        let tvShow = TVShowModel.generateTVShow()

        // Act
        let data = try JSONEncoder().encode(tvShow)
        let jsonString = String(data: data, encoding: .utf8)

        // Assert
        let expectedJsonString = "{\"summary\":\"SUMMARYTEST\",\"id\":0,\"rating\":{\"average\":8.5},\"name\":\"NAMETEST\",\"type\":\"TYPETEST\",\"image\":{\"medium\":\"IMAGEPATHTEST\"}}"
        expect(jsonString).to(equal(expectedJsonString))
    }
}
