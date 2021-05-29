//
//  SearchSuggestionRouter.swift
//  MealApp
//
//  Created by Emre Ergün on 29.05.2021.
//

import UIKit

protocol SearchSuggestionRouterInterface {
    
}

class SearchSuggestionRouter {
    static func createModule(delegate: SearchSuggestionDelegate?) -> SearchSuggestionViewController {
        let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchSuggestionViewController") as! SearchSuggestionViewController
        let router = SearchSuggestionRouter()
        let interactor = SearchSuggestionInteractor()
        let presenter = SearchSuggestionPresenter(view: viewController, router: router, interactor: interactor, delegate: delegate)
        
        viewController.presenter = presenter
        interactor.output = presenter
        
        return viewController
    }
}

extension SearchSuggestionRouter: SearchSuggestionRouterInterface {
    
}
