//
//  ViewController.swift
//  MealApp
//
//  Created by Anıl Taşkıran on 22.05.2021.
//

import UIKit
import CoreApi

extension HomeViewController {
    fileprivate enum Constants {
        static let cellDescriptionViewHeight: CGFloat = 60
        static let cellBannerImageViewAspectRatio: CGFloat = 130/345
        static let cellLeftPadding: CGFloat = 15
        static let cellRightPadding: CGFloat = 15
        static let firstPageHref: String = "page=1"
    }
}

class HomeViewController: UIViewController, LoadingShowable {
    let networkManager: NetworkManager<HomeEndpointItem> = NetworkManager()
    @IBOutlet private weak var restaurantsCollectionView: UICollectionView!
    private var widgets: [Widget] = []
    private var href: String = Constants.firstPageHref
    private var shouldFetchNextPage: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        addRefreshControl()
    }

    override func viewDidAppear(_ animated: Bool) {
        fetchWidgets(query: href)
    }
    
    private func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        restaurantsCollectionView.refreshControl = refreshControl
    }

    @objc
    private func pullToRefresh() {
        href = Constants.firstPageHref
        shouldFetchNextPage = true
        fetchWidgets(query: href)
    }

    private func prepareCollectionView() {
        restaurantsCollectionView.dataSource = self
        restaurantsCollectionView.delegate = self

        restaurantsCollectionView.register(cellType: RestaurantCollectionViewCell.self)
    }

    private func fetchWidgets(query: String) {
        showLoading()
        networkManager.request(endpoint: .homepage(query: query), type: HomeResponse.self) { [weak self] result in
            self?.hideLoading()
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
                self?.restaurantsCollectionView.reloadData()
                self?.restaurantsCollectionView.refreshControl?.endRefreshing()
            case .failure(let error):
                print(error)
                break
            }
        }
    }

    private func calculateCellHeight() -> CGFloat {
        let cellWidth = restaurantsCollectionView.frame.size.width - (Constants.cellLeftPadding + Constants.cellRightPadding)
        let bannerImageHeight = cellWidth * Constants.cellBannerImageViewAspectRatio
        return Constants.cellDescriptionViewHeight + bannerImageHeight
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        widgets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: RestaurantCollectionViewCell.self, indexPath: indexPath)
        if let restaurant = widgets[indexPath.item].restaurants?.first {
            cell.configure(restaurant: restaurant)
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.size.width - (Constants.cellLeftPadding + Constants.cellRightPadding), height: calculateCellHeight())
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: .zero, left: Constants.cellLeftPadding, bottom: .zero, right: Constants.cellRightPadding)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == (widgets.count - 1), shouldFetchNextPage {
            fetchWidgets(query: href)
        }
    }
}
