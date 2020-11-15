//
//  CommonAssembly.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import Swinject

class CommonAssembly: Assembly {
    func assemble(container: Container) {
        container.register(StorageManagerProtocol.self) { _ in
            return StorageManager()
        }
        container.register(RemoteManagerProtocol.self) { _ in
            let configuration = RemoteConfiguration(baseUrl: Endpoints.Api.production.rawValue)
            return RemoteManager(configuration)
        }
    }
}
