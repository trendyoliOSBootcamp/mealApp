//
//  HomeViewModel.swift
//  MealApp
//
//  Created by Beyza İnce on 23.05.2021.
//

import Foundation
import CoreApi

extension HomeViewModel {
    fileprivate enum Constants {
        static let cellLeftPadding: Double = 15
        static let cellRightPadding: Double = 15
        static let firstPageHref: String = "page=1"
        static let cellBannerImageViewAspectRatio: Double = 130/345
        static let cellDescriptionViewHeight: Double = 60
    }
}


protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    var cellPadding: Double { get }

    func load()
    func restaurant(_ index: Int) -> Restaurant?
    func calculateCellSize(collectionViewWidth: Double) -> (width: Double, height: Double)
    func pullToRefresh()
    func willDisplay(_ index: Int)
}

protocol HomeViewModelDelegate: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
    func endRefreshing()
    func prepareCollectionView()
    func addRefreshControl()
}


final class HomeViewModel {
    private var widgets: [Widget] = []
    let networkManager: NetworkManager<HomeEndpointItem>
    private var shouldFetchNextPage: Bool = true
    weak var delegate: HomeViewModelDelegate?
    private var href: String = Constants.firstPageHref


    init(networkManager: NetworkManager<HomeEndpointItem>) {
        self.networkManager = networkManager
    }

    private func fetchWidgets(query: String) {
        delegate?.showLoadingView()
        networkManager.request(endpoint: .homepage(query: query), type: HomeResponse.self) { [weak self] result in
            self?.delegate?.hideLoadingView()
            switch result {
            case .success(let response):
                if let widgets = response.widgets {
                    if query == Constants.firstPageHref {
                        self?.widgets = widgets
                    } else {
                        self?.shouldFetchNextPage = !widgets.isEmpty
                        self?.widgets.append(contentsOf: widgets)
                    }
                } else {
                    self?.shouldFetchNextPage = false
                }
                self?.href = response.href ?? ""
                self?.delegate?.reloadData()
                self?.delegate?.endRefreshing()
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}


extension HomeViewModel: HomeViewModelProtocol {
    var cellPadding: Double {
        Constants.cellLeftPadding
    }

    func willDisplay(_ index: Int) {
        if index == (widgets.count - 1), shouldFetchNextPage {
            fetchWidgets(query: href)
        }
    }

    func pullToRefresh() {
        href = Constants.firstPageHref
        shouldFetchNextPage = true
        fetchWidgets(query: href)
    }

    var numberOfItems: Int {
        widgets.count
    }

    func load() {
        delegate?.prepareCollectionView()
        delegate?.addRefreshControl()
        fetchWidgets(query: href)
    }

    func restaurant(_ index: Int) -> Restaurant? {
        widgets[safe: index]?.restaurants?.first
    }

    func calculateCellSize(collectionViewWidth: Double) -> (width: Double, height: Double) {
        let cellWidth = collectionViewWidth - (Constants.cellLeftPadding + Constants.cellRightPadding)
        let bannerImageHeight = cellWidth * Constants.cellBannerImageViewAspectRatio
        return (width: cellWidth, height: Constants.cellDescriptionViewHeight + bannerImageHeight)
    }
}
