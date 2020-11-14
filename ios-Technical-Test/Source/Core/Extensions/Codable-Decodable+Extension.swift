//
//  Codable-Decodable+Extension.swift
//  PropertyFinder
//
//  Created by JORDI GALLEN on 14/11/2020.
//

import Foundation

extension Decodable {
    static func decode<T: Decodable>(from dictionary: [String: Any]) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        return try self.decode(data)
    }

    static func decode<T: Decodable>(_ data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}

extension Encodable {
    public var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
