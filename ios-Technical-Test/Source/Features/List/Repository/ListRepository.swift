//
//  ListRepository.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import Foundation
import PromiseKit


typealias ListResponseTypeAlias = RemoteCompletionTypeAlias<[TVShowModel]>

protocol ListRepositoryProtocol: AnyObject {
    func fetchTVShows(_ page: Int, completion: @escaping ListResponseTypeAlias)
}

class ListRepository: ListRepositoryProtocol {

    enum Endpoint {
        static let Page = "/shows?page={page}"
    }

    private enum Key {
        static let TVShows = "\(String(describing: ListRepository.self))-TVShowList"
        static let TVShowListNumber = "\(String(describing: ListRepository.self))-TVShowListNumber"
    }

    private enum DefaultParameters: String {
        case apiKey
        case hash
        case timeStamp = "ts"
    }

    private var remote: RemoteManagerProtocol
    private var storage: StorageManagerProtocol
    private var storedListTVShow: [TVShowModel] = []

    init(remote: RemoteManagerProtocol, storage: StorageManagerProtocol) {
        self.remote = remote
        self.storage = storage
    }

    func fetchTVShows(_ page: Int, completion: @escaping ListResponseTypeAlias) {
        _ = firstly {
            self.retrieveListTVShows()
        }.then { storedListTVShows in
            self.execute(storedListTVShows, with: completion)
        }.done {
            self.fetchRemoteListTVShows(page) { result in
                completion(result)
            }
        }//save
    }

}

// MARK: Local Promises

extension ListRepository {

    private func retrieveListTVShows() -> Promise<[TVShowModel]> {
        return Promise<[TVShowModel]> { seal in
            let storedTVShows = getStoredListTVShows()
            self.storedListTVShow = storedTVShows
            seal.fulfill(storedTVShows)
        }
    }
}

// MARK: Local Storage

extension ListRepository {

    private func getStoredListTVShows() -> [TVShowModel] {
        return self.storage.get(by: Key.TVShows, isSecured: true) ?? []
    }

    private func getStoredNumberList() -> Int {
        let model: TVShowModelNumber? = self.storage.get(by: Key.TVShowListNumber, isSecured: true)
        return model?.number ?? 0
    }

    private func execute(_ storedList: [TVShowModel], with completion: @escaping ListResponseTypeAlias) -> Promise<Void> {
        return Promise<Void> { seal in
            completion(.success(storedList))
            seal.fulfill_()
        }
    }
}

// MARK: Remote Connection

extension ListRepository {

    private func fetchRemoteListTVShows(_ page: Int, completion: @escaping ListResponseTypeAlias) {

        let endpoint = Endpoint.Page.replacingOccurrences(of: "{page}", with: "\(page)")
        let storedNumberList = self.getStoredNumberList()
        let storedList = self.getStoredListTVShows()
        self.remote.get(endpoint, parameters: nil) { [weak self] (result: Swift.Result<[TVShowModel], BaseError>) in
            switch result {
            case let .success(value):
                if storedList != value || storedNumberList != value.count {
                    self?.storage.save(object: value, by: Key.TVShows, isSecured: true)
                    self?.storage.save(object: TVShowModelNumber(number: value.count), by: Key.TVShowListNumber, isSecured: true)
                }
                completion(.success(value))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

