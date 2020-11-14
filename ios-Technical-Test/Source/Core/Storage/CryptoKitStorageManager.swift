//
//  CryptoKitStorageManager.swift
//  PropertyFinder
//º
//  Created by JORDI GALLEN on 14/11/2020.
//

import UIKit
import Foundation
import CryptoKit

// Only for >= iOS 13.0
@available(iOS 13.0, *)
public class CryptoKitStorageManager: StorageManager {
    public override init() {}

    public override func save<T: Codable>(object: T, by key: String, isSecured: Bool) {
        if isSecured {
            if let symmetricKey = SymmetricKeyGenerator.shared.generateKey(),
                let data = try? JSONEncoder().encode(object),
                let encryptObject = try? ChaChaPoly.seal(data, using: symmetricKey).combined {
                UserDefaults.standard.set(encryptObject, forKey: key)
            }
        } else {
            let objectEncoded = try? PropertyListEncoder().encode(object)
            UserDefaults.standard.set(objectEncoded, forKey: key)
        }
    }

    public override func get<T: Codable>(by key: String, isSecured: Bool) -> T? {
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            if isSecured {
                if let symmetricKey = SymmetricKeyGenerator.shared.generateKey(),
                    let sealedBox = try? ChaChaPoly.SealedBox(combined: data),
                    let data = try? ChaChaPoly.open(sealedBox, using: symmetricKey),
                    let object = try? JSONDecoder().decode(T.self, from: data) {
                    return object
                }
            } else {
                return try? PropertyListDecoder().decode(T.self, from: data)
            }
        }
        return nil
    }
}

@available(iOS 13.0, *)
private class SymmetricKeyGenerator {
    static let shared = SymmetricKeyGenerator()

    private init() {}

    internal func generateKey() -> SymmetricKey? {
        guard let uuid = UIDevice.current.identifierForVendor?.uuidString else {
            return nil
        }
        return SymmetricKey(data: Array(uuid.prefix(32).description.utf8))
    }
}
