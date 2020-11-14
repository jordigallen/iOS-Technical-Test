//
//  CoreLog.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import Foundation
import os.log

public class CoreLog {
    public let identifier: String
    public let category: String
    public let internalLog: OSLog?

    public init(identifier: String = "", category: String = "") {
        self.identifier = identifier
        self.category = category
        if !identifier.isEmpty, !category.isEmpty {
            self.internalLog = OSLog(subsystem: identifier, category: category)
        } else {
            self.internalLog = nil
        }
    }

    private func log(_ message: StaticString, _ type: OSLogType, _ args: CVarArg...) {
        os_log(message, log: self.internalLog ?? .default, type: type, args)
    }

    public func info(_ message: StaticString, _ args: CVarArg...) {
        self.log(message, .info, args)
    }

    public func debug(_ message: StaticString, _ args: CVarArg...) {
        self.log(message, .debug, args)
    }

    public func error(_ message: StaticString, _ args: CVarArg...) {
        self.log(message, .error, args)
    }

    public func fault(_ message: StaticString, _ args: CVarArg...) {
        self.log(message, .fault, args)
    }
}
