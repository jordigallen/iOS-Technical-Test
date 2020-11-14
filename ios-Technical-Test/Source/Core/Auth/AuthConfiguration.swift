//
//  AuthConfiguration.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import Foundation

public enum AuthType {
    case other([String: String])
    case none
}

extension AuthType: Equatable {
    public static func == (lhs: AuthType, rhs: AuthType) -> Bool {
        switch (lhs, rhs) {
        case let (.other(lhsValue), .other(rhsValue)):
            return lhsValue == rhsValue
        case (.none, .none):
            return true
        default:
            return false
        }
    }
}
