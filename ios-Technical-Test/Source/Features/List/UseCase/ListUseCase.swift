//
//  ListUseCase.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import Foundation

protocol ListUseCaseProtocol: AnyObject {
    func fetchTVShows(_ page: Int,  completion: @escaping (Result<[TVShowModel], BaseError>) -> Void)
}

class ListUseCase: ListUseCaseProtocol {
    private var repository: ListRepositoryProtocol?

    init(repository: ListRepositoryProtocol) {
        self.repository = repository
    }

    func fetchTVShows(_ page: Int,  completion: @escaping (Result<[TVShowModel], BaseError>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.repository?.fetchTVShows(page) { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
}
