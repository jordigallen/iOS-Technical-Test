//
//  CoreLog+Extension.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import Foundation

extension CoreLog {
    public static let business = CoreLog(identifier: "com.promofarma.iosTechnicalTest", category: "business")
    public static let ui = CoreLog(identifier: "com.promofarma.iosTechnicalTest", category: "ui")
    public static let firebase = CoreLog(identifier: "com.promofarma.iosTechnicalTest", category: "firebase")
    public static let remote = CoreLog(identifier: "com.promofarma.iosTechnicalTest", category: "remote")
}
