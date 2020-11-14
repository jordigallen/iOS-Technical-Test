//
//  RemoteConfiguration.swift
//  iosTechnicalTest
//
//  Created by JORDI GALLEN on 11/08/2020.
//  Copyright © 2020 JORDI GALLEN RENAU. All rights reserved.
//

import Alamofire
import UIKit

public struct RemoteConfiguration {
    public typealias AuthRequest = () -> AuthType
    let baseUrl: String
    public let defaultHeaders: HTTPHeaders
    public let timeout: Int
    public let retryAttempts: Int
    public let authAttempt: AuthRequest

    public init(baseUrl: String, defaultHeaders: HTTPHeaders = [:], timeout: Int = 30, retryAttempts: Int = 1, authAttempt: @escaping AuthRequest = { return .none }) {
        self.baseUrl = baseUrl
        self.defaultHeaders = defaultHeaders
        self.timeout = timeout
        self.retryAttempts = retryAttempts
        self.authAttempt = authAttempt
    }

    public let session = SessionManager(serverTrustPolicyManager: ServerTrustPolicyManager(policies: [:]))
}
