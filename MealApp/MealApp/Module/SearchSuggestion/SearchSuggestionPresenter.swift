//
//  SearchSuggestionPresenter.swift
//  MealApp
//
//  Created by Emre Ergün on 29.05.2021.
//

import Foundation

protocol SearchSuggestionPresenterInterface {
    
}

class SearchSuggestionPresenter {
    weak var view: SearchSuggestionViewInterface?
    let router: SearchSuggestionRouterInterface
    let interactor: SearchSuggestionInteractorInterface
    
    init(view: SearchSuggestionViewInterface?, router: SearchSuggestionRouterInterface, interactor: SearchSuggestionInteractorInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension SearchSuggestionPresenter: SearchSuggestionPresenterInterface {
    
}
