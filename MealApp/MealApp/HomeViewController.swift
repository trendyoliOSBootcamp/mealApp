//
//  ViewController.swift
//  MealApp
//
//  Created by Anıl Taşkıran on 22.05.2021.
//

import UIKit
import CoreApi

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
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        widgets?.count ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: RestaurantCollectionViewCell.self, indexPath: indexPath)
        // cell configure
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {

}
