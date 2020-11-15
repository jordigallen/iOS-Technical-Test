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

    private var page = 0
    private var newPage: Int = 240


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
        self.useCase?.fetchTVShows(self.page) { [weak self] tvShows  in
            guard let self = self else { return }
            self.userView?.finishLoading()
            if case let .success(response) = tvShows, !response.isEmpty {
                self.userView?.setTVShows(response)
                self.page += self.newPage
            } else {
                self.userView?.toggleTableViewBackground()
            }
            if case let .failure(error) = tvShows {
                CoreLog.ui.error("Error fetching TVShows: %@", error.localizedDescription)
            }
        }
    }
}
