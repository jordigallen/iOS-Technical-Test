//
//  TVShowModel.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import Foundation

class TVShowModel: Codable, Equatable {
    var id: Int?
    var name: String?
    var type: String?
    var image: ImageModel?
    var summary: String?
    var rating: RatingModel?

    init(
        id: Int?,
        name: String?,
        type: String?,
        image: ImageModel?,
        summary: String?,
        rating: RatingModel?
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.image = image
        self.summary = summary
        self.rating = rating
    }

    static func == (lhs: TVShowModel, rhs: TVShowModel) -> Bool {
        return lhs.id == rhs.id
    }
}

class ImageModel: Codable {
    var path: String?

    public enum CodingKeys: String, CodingKey {
        case path = "medium"
    }

    init(path: String?) {
        self.path = path
    }
}

class RatingModel: Codable {
    var ratingAverage: Double?

    public enum CodingKeys: String, CodingKey {
        case ratingAverage = "average"
    }

    init(ratingAverage: Double?) {
        self.ratingAverage = ratingAverage
    }
}

struct TVShowModelNumber: Codable, Equatable {
    let number: Int
}

