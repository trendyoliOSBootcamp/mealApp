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
    }
}

class HomeViewController: UIViewController {
    let networkManager: NetworkManager<HomeEndpointItem> = NetworkManager()
    @IBOutlet private weak var restaurantsCollectionView: UICollectionView!
    private var widgets: [Widget]?

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        fetchWidgets()
    }

    private func prepareCollectionView() {
        restaurantsCollectionView.dataSource = self
        restaurantsCollectionView.delegate = self

        restaurantsCollectionView.register(cellType: RestaurantCollectionViewCell.self)
    }

    private func fetchWidgets() {
        networkManager.request(endpoint: .homepage(query: "page=1"), type: HomeResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.widgets = response.widgets
                self?.restaurantsCollectionView.reloadData()
                print(response)
                break
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
        widgets?.count ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: RestaurantCollectionViewCell.self, indexPath: indexPath)
        if let restaurant = widgets?[indexPath.item].restaurants?.first {
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
