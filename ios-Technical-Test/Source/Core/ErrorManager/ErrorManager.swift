//
//  ErrorManager.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import UIKit

public enum ErrorType {
    case generic
    case maintenance
    case specific
}

class ErrorManager {
    class func process(_ response: HTTPURLResponse) {
        if response.statusCode == 503 {
            NotificationCenter.default.post(name: Notification.Name.Error.Remote.maintenance, object: nil)
        } else {
            NotificationCenter.default.post(name: Notification.Name.Error.Remote.generic, object: nil,
                                            userInfo: [ErrorType.generic: BaseError.remoteError(.httpUrlResponse(response)).localizedDescription])
        }
        CoreLog.remote.error("%@", BaseError.remoteError(.httpUrlResponse(response)).localizedDescription)
    }

    class func process(error: String) {
        NotificationCenter.default.post(name: Notification.Name.Error.Remote.generic, object: nil, userInfo: [ErrorType.generic: error.debugDescription])
        CoreLog.remote.error("%@", error)
    }
}

