//
//  ListAssembly.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import Swinject

class ListAssembly: Assembly {
    func assemble(container: Container) {

        container.register(ListPresenterProtocol.self) { _ in
            let useCase = container.synchronize().resolve(ListUseCaseProtocol.self)!
            return ListPresenter(useCase: useCase)
        }

        container.register(ListUseCaseProtocol.self) { _ in
            let repository = container.synchronize().resolve(ListRepositoryProtocol.self)!
            return ListUseCase(repository: repository)
        }

        container.register( ListRepositoryProtocol.self) { _ in
            let Remote = RemoteManager(RemoteConfiguration(baseUrl: Endpoints.Api.production.rawValue))
            let storage = container.synchronize().resolve(StorageManagerProtocol.self)!
            return ListRepository(remote: Remote, storage: storage)
        }
    }
}
