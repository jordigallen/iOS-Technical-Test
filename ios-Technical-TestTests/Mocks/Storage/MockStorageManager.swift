//
//  MockStorageManager.swift
//  ios-Technical-TestTests
//
//  Created by JORDI GALLEN RENAU on 15/11/20.
//

import ios_Technical_Test
import UIKit

class MockStorageManager {
    private var objects: [String: Data] = [:]

    func registerMock<T: Codable>(_ object: T, for key: String) {
        objects[key] = try? JSONEncoder().encode(object)
    }

    func cleanRegisteredMocks() {
        objects.removeAll()
    }
}

extension MockStorageManager: StorageManagerProtocol {
    func save<T: Codable>(object: T, by key: String, isSecured: Bool) {
        objects[key] = try? JSONEncoder().encode(object)
    }

    func get<T: Codable>(by key: String, isSecured: Bool) -> T? {
        guard let data = objects[key] else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }

    func delete(by key: String) {
        _ = objects.removeValue(forKey: key)
    }

    func deleteAll() {
        objects.removeAll()
    }
}
