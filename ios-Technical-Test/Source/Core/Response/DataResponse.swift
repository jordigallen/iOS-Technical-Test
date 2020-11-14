//
//  DataResponse.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import Foundation

public struct DataResponse<Data: Codable>: Codable {
    public enum CodingKeys: String, CodingKey {
        case data
    }

    public let data: Data
}

public struct ResultsResponse<Data: Codable>: Codable {
    public enum CodingKeys: String, CodingKey {
        case results
    }

    public let results: Data
}
