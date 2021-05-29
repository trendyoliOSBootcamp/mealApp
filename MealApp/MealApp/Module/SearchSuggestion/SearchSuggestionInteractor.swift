//
//  SearchSuggestionInteractor.swift
//  MealApp
//
//  Created by Emre Ergün on 29.05.2021.
//

import CoreApi

protocol SearchSuggestionInteractorInterface {
    func fetchSuggestions(keyword: String)
}

protocol SearchSuggestionInteractorOutput: AnyObject {
    func handleFetchSuggestionsResponse(_ result: SearchSuggestionResult)
}

typealias SearchSuggestionResult = Result<SearchSuggestionResponse, APIClientError>

class SearchSuggestionInteractor {
    let networkManager: NetworkManager<SearchEndpointItem>
    weak var output: SearchSuggestionInteractorOutput?
    
    init(networkManager: NetworkManager<SearchEndpointItem> = NetworkManager()) {
        self.networkManager = networkManager
    }
}

extension SearchSuggestionInteractor: SearchSuggestionInteractorInterface {
    func fetchSuggestions(keyword: String) {
        networkManager.request(endpoint: .suggestions(keyword: keyword), type: SearchSuggestionResponse.self) { [weak self] (result) in
            self?.output?.handleFetchSuggestionsResponse(result)
        }
    }
}
