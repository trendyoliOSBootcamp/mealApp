//
//  HomePresenter.swift
//  MealApp
//
//  Created by Mine on 23.05.2021.
//

import Foundation

//ViewController -> HomePresenterInterface
protocol HomePresenterInterface {
    var numberOfItems: Int { get }
    var cellPadding: Double { get }

    func viewDidLoad()
    func restaurant(_ index: Int) -> Restaurant?
    func calculateCellSize(collectionViewWidth: Double) -> (width: Double, height: Double)
    func pullToRefresh()
    func willDisplay(_ index: Int)
}

extension HomePresenter {
    fileprivate enum Constants {
        static let cellLeftPadding: Double = 15
        static let cellRightPadding: Double = 15
        static let firstPageHref: String = "page=1"
        static let cellBannerImageViewAspectRatio: Double = 130/345
        static let cellDescriptionViewHeight: Double = 60
    }
}

final class HomePresenter {
    weak var view: HomeViewInterface?
    private let interactor: HomeInteractorInterface

    private var widgets: [Widget] = []
    private var shouldFetchNextPage: Bool = true
    private var href: String = Constants.firstPageHref

    init(view: HomeViewInterface?,
         interactor: HomeInteractorInterface) {
        self.view = view
        self.interactor = interactor
    }

    private func fetchWidgets(query: String) {
        view?.showLoadingView()
        interactor.fetchWidgets(query: query)
    }
}

extension HomePresenter: HomePresenterInterface {
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

    func viewDidLoad() {
        view?.prepareNavigationBarUI()
        view?.setTitle("Home")
        view?.prepareSearchController()
        view?.prepareCollectionView()
        view?.addRefreshControl()
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

extension HomePresenter: HomeInteractorOutput {
    func handleWidgetResult(_ result: WidgetResult, query: String) {
        view?.hideLoadingView()
        switch result {
        case .success(let response):
            if let widgets = response.widgets {
                if query == Constants.firstPageHref {
                    self.widgets = widgets
                } else {
                  shouldFetchNextPage = !widgets.isEmpty
                    self.widgets.append(contentsOf: widgets)
                }
            } else {
               shouldFetchNextPage = false
            }
            href = response.href ?? ""
            view?.reloadData()
            view?.endRefreshing()
        case .failure(let error):
            print(error)
            break
        }
    }
}
