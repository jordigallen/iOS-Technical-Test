//
//  StorageManager.swift
//  PropertyFinder
//
//  Created by JORDI GALLEN on 14/11/2020.
//

import Foundation

public protocol StorageManagerProtocol {
    func save<T: Codable>(object: T, by key: String, isSecured: Bool)
    func get<T: Codable>(by key: String, isSecured: Bool) -> T?
    func delete(by key: String)
    func deleteAll()
}

public class StorageManager: StorageManagerProtocol {
    public func save<T: Codable>(object: T, by key: String, isSecured: Bool) {
        if #available(iOS 13.0, *) {
            CryptoKitStorageManager().save(object: object, by: key, isSecured: isSecured)
        }
    }

    public func get<T: Codable>(by key: String, isSecured: Bool) -> T? {
        if #available(iOS 13.0, *) {
            return CryptoKitStorageManager().get(by: key, isSecured: isSecured)
        }
        return nil
    }

    public func delete(by key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }

    public func deleteAll() {
        if let domain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: domain)
        }
    }
}

