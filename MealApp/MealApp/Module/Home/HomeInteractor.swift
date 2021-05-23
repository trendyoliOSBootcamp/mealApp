//
//  HomeInteractor.swift
//  MealApp
//
//  Created by Mine on 23.05.2021.
//

import Foundation
import CoreApi

// HomePresenter -> HomeInteractorInterface
protocol HomeInteractorInterface {
    func fetchWidgets(query: String)
}

//HomeInteractorOutput -> HomePresenter
protocol HomeInteractorOutput: AnyObject {
    func handleWidgetResult(_ result: WidgetResult, query: String)
}

typealias WidgetResult = Result<HomeResponse, APIClientError>

final class HomeInteractor {
    private let networkManager: NetworkManager<HomeEndpointItem>
    weak var output: HomeInteractorOutput?

    init(networkManager: NetworkManager<HomeEndpointItem> = NetworkManager()) {
        self.networkManager = networkManager
    }
}

extension HomeInteractor: HomeInteractorInterface {
    func fetchWidgets(query: String) {
        networkManager.request(endpoint: .homepage(query: query), type: HomeResponse.self) { [weak self] result in
            self?.output?.handleWidgetResult(result, query: query)
        }
    }
}
