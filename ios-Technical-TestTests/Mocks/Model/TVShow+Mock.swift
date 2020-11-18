//
//  TVShow+Mock.swift
//  ios-Technical-TestTests
//
//  Created by JORDI GALLEN RENAU on 15/11/20.
//

@testable import ios_Technical_Test
import Foundation

extension TVShowModel {
    public static func generateTVShow(index: Int? = 0) -> TVShowModel {
        let tvShow = TVShowModel(id: index, name: "NAMETEST", type: "TYPETEST", image: ImageModel(path: "IMAGEPATHTEST"), summary: "SUMMARYTEST", rating: RatingModel(ratingAverage: 8.5))
        return tvShow
    }
}
