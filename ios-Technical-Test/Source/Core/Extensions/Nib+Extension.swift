//
//  Nib+Extension.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import Foundation

public protocol Nib: AnyObject {
    static var nibName: String { get }
    static func loadFromNib<T: Nib>() -> T?
}

extension Nib {
    public static func loadFromNib<T: Nib>() -> T? {
        return Bundle(for: T.self).loadNibNamed(T.nibName, owner: nil, options: [:])?.first as? T
    }
}
