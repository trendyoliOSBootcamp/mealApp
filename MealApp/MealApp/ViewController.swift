//
//  ViewController.swift
//  MealApp
//
//  Created by Anıl Taşkıran on 22.05.2021.
//

import UIKit
import CoreApi

class ViewController: UIViewController {
    let networkManager: NetworkManager<HomeEndpointItem> = NetworkManager()
    @IBOutlet private weak var widgetsCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWidgets()
    }

    private func fetchWidgets() {
        networkManager.request(endpoint: .homepage(query: "page=1"), type: HomeResponse.self) { result in
            switch result {
            case .success(let response):
                print(response)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

