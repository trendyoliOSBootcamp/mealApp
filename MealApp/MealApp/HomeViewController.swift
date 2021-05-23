//
//  ViewController.swift
//  MealApp
//
//  Created by Anıl Taşkıran on 22.05.2021.
//

import UIKit

class HomeViewController: UIViewController, LoadingShowable {
    @IBOutlet private weak var restaurantsCollectionView: UICollectionView!

    var viewModel: HomeViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
    }

    @objc
    private func pullToRefresh() {
        viewModel.pullToRefresh()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: RestaurantCollectionViewCell.self, indexPath: indexPath)
        if let restaurant = viewModel.restaurant(indexPath.item) {
            cell.viewModel = RestaurantCollectionViewCellViewModel(restaurant: restaurant)
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = viewModel.calculateCellSize(collectionViewWidth: Double(collectionView.frame.size.width))
             return .init(width: size.width, height: size.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: .zero, left: CGFloat(viewModel.cellPadding), bottom: .zero, right: CGFloat(viewModel.cellPadding))
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.willDisplay(indexPath.item)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func showLoadingView() {
        showLoading()
    }

    func hideLoadingView() {
        hideLoading()
    }

    func reloadData() {
        restaurantsCollectionView.reloadData()
    }

    func endRefreshing() {
        restaurantsCollectionView.refreshControl?.endRefreshing()
    }

    func prepareCollectionView() {
        restaurantsCollectionView.dataSource = self
        restaurantsCollectionView.delegate = self
        restaurantsCollectionView.register(cellType: RestaurantCollectionViewCell.self)
    }

    func addRefreshControl() {
       let refreshControl = UIRefreshControl()
       refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
       restaurantsCollectionView.refreshControl = refreshControl
   }
}
