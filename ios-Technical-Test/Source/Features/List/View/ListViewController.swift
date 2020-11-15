//
//  ViewController.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 12/11/20.
//

import UIKit

class ListViewController: UIViewController {


    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView?

    
    internal var presenter: ListPresenterProtocol!
    static let cellTableId = "ResultTableViewCell"

    private var tvShows = [TVShowModel]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.activityIndicator?.hidesWhenStopped = true
        self.presenter.attachView(self)
        self.presenter.fetchTVShows()
        self.prepareTableView()
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tvShows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: ListViewController.cellTableId, for: indexPath) as? ResultTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configureTVShow(with: tvShows[indexPath.row])
        return cell
    }
}

extension ListViewController: UserView {
    func startLoading() {
        self.activityIndicator?.startAnimating()
    }

    func finishLoading() {
        self.activityIndicator?.stopAnimating()
    }

    func setTVShows(_ tvShows: [TVShowModel]) {
        self.tvShows = tvShows
        self.tvShows.append(contentsOf: tvShows)
        self.tableView?.reloadData()
    }

    func toggleTableViewBackground() {
        if self.tvShows.isEmpty {
            (self.tableView.backgroundView as? BaseEmptyView)?.show()
            if self.tableView.backgroundView == nil {
                self.tableView.backgroundView = self.createEmptyView(Asset.noTVShowsFoundedIcon.image, and: L10n.IosTechnicalTest.ListViewController.Searching.title)
            }
        } else {
            self.tableView.separatorStyle = .singleLine
            (self.tableView.backgroundView as? BaseEmptyView)?.hide()
        }
    }
}

extension ListViewController {
    private func prepareTableView() {
        self.toggleTableViewBackground()
        self.tableView.register(UINib.init(nibName: ListViewController.cellTableId, bundle: nil), forCellReuseIdentifier: ListViewController.cellTableId)
    }

    private func createEmptyView( _ image: UIImage, and title: String) -> BaseEmptyView? {
        let baseEmptyView: BaseEmptyView? = BaseEmptyView.loadFromNib()
        baseEmptyView?.configure(withImage: image, caption: title, attributedCaption: nil)
        return baseEmptyView
    }
}
