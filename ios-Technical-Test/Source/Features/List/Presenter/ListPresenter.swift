//
//  ListPresenter.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import Foundation

protocol ListPresenterProtocol: AnyObject {
    func fetchTVShows()
    func attachView(_ view: UserViewProtocol)
    func detachView()
    var newPage: Int { get }
}

protocol UserViewProtocol: AnyObject {
    func startLoading()
    func finishLoading()
    func setTVShows(_ tvShows: [TVShowModel])
    func toggleTableViewBackground()
}

class ListPresenter: ListPresenterProtocol {

    private enum PagingConstantType: Int {
        case onePage = 1
        case itemsPerPage = 240
    }

    var newPage = 0

    private var useCase: ListUseCaseProtocol?
    private weak var userView: UserViewProtocol?

    init(useCase: ListUseCaseProtocol) {
        self.useCase = useCase
    }

    internal func attachView(_ view: UserViewProtocol){
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
                self.newPage += PagingConstantType.onePage.rawValue
            } else {
                self.userView?.toggleTableViewBackground()
            }
            if case let .failure(error) = tvShows {
                CoreLog.ui.error("Error fetching TVShows: %@", error.localizedDescription)
            }
        }
    }
}
