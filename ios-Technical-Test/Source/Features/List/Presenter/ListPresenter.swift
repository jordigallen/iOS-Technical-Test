//
//  ListPresenter.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import Foundation

protocol ListPresenterProtocol: AnyObject {
    func fetchTVShows()
    func attachView(_ view: UserView)
    func detachView()
    var newPage: Int { get }
    var items: Int { get }
}

protocol UserView: AnyObject {
    func startLoading()
    func finishLoading()
    func setTVShows(_ tvShows: [TVShowModel])
    func toggleTableViewBackground()
}

class ListPresenter: ListPresenterProtocol {
    
    private var useCase: ListUseCaseProtocol?
    private var userView: UserView?

    var newPage = 0
    var items = 240

    init(useCase: ListUseCaseProtocol) {
        self.useCase = useCase
    }

    internal func attachView(_ view: UserView){
        userView = view
    }

    internal func detachView() {
        userView = nil
    }


    internal func fetchTVShows() {
        self.userView?.startLoading()
        self.useCase?.fetchTVShows(self.newPage) { [weak self] tvShows  in
            guard let self = self else { return }
            self.userView?.finishLoading()
            if case let .success(response) = tvShows, !response.isEmpty {
                self.userView?.setTVShows(response)
                self.newPage += 1
//                print("[TEST] newPage \(self.newPage)")
            } else {
                self.userView?.toggleTableViewBackground()
            }
            if case let .failure(error) = tvShows {
                CoreLog.ui.error("Error fetching TVShows: %@", error.localizedDescription)
            }
        }
    }
}
