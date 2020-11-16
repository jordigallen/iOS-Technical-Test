//
//  NotificationsError+Extension.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import Foundation

extension Notification.Name {
     struct Error {
         struct Remote {
             static let generic = Notification.Name(rawValue: "com.tvMaze.ios-Technical-Test.notification.name.error.remote.generic")
             static let maintenance = Notification.Name(rawValue: "com.tvMaze.ios-Technical-Test,notification.name.error.remote.maintenance")
        }
    }
    public struct Response {
        public static let emptyData = Notification.Name(rawValue: "com.tvMaze.ios-Technical-Test.notification.name.response.remote.emptyData")
    }
}
