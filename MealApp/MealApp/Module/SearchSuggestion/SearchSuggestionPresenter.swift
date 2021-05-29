//
//  SearchSuggestionPresenter.swift
//  MealApp
//
//  Created by Emre Ergün on 29.05.2021.
//

import Foundation

protocol SearchSuggestionPresenterInterface {
    func viewDidLoad()
    func numberOfItems(at section: Int) -> Int
    func sizeOfItem(at indexPath: IndexPath) -> (Double, Double)
    func updateSearchResults(searchText: String?)
    
    var numberOfSections: Int { get }
    var headerSize: (Double, Double) { get }
    
    func item(at indexPath: IndexPath) -> SearchItem?
    func suggestion(at section: Int) -> Suggestion?
    func sectionType(at section: Int) -> SuggestionType
    func didSelectItem(at indexPath: IndexPath)
}

protocol SearchSuggestionDelegate: AnyObject {
    func searchSuggestionItemTapped(item: SearchItem)
}

class SearchSuggestionPresenter {
    weak var view: SearchSuggestionViewInterface?
    let router: SearchSuggestionRouterInterface
    let interactor: SearchSuggestionInteractorInterface
    private weak var delegate: SearchSuggestionDelegate?
    
    var suggestions: [Suggestion]?
    
    init(view: SearchSuggestionViewInterface?, router: SearchSuggestionRouterInterface, interactor: SearchSuggestionInteractorInterface, delegate: SearchSuggestionDelegate?) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.delegate = delegate
    }
}

extension SearchSuggestionPresenter: SearchSuggestionPresenterInterface {
    func viewDidLoad() {
        view?.prepareCollectionView()
        interactor.fetchSuggestions(keyword: "pi")
    }
    
    func numberOfItems(at section: Int) -> Int {
        guard let suggestions = suggestions else { return 0 }
        return suggestions[section].items.count
    }
    
    var numberOfSections: Int {
        suggestions?.count ?? 0
    }
    
    func sizeOfItem(at indexPath: IndexPath) -> (Double, Double) {
        if indexPath.section == 0 {
            return (view?.collectionViewWidth ?? .zero, 80.0)
        } else {
            return (view?.collectionViewWidth ?? .zero, 44.0)
        }
    }
    
    var headerSize: (Double, Double) {
        return (view?.collectionViewWidth ?? .zero, 44.0)
    }
    
    func updateSearchResults(searchText: String?) {
        guard let searchText = searchText, !searchText.isEmpty else { return }
        interactor.fetchSuggestions(keyword: searchText)
    }
    
    func item(at indexPath: IndexPath) -> SearchItem? {
        guard let suggestions = suggestions else { return nil }
        return suggestions[indexPath.section].items[indexPath.row]
    }
    
    func suggestion(at section: Int) -> Suggestion? {
        guard let suggestions = suggestions else { return nil }
        return suggestions[section]
    }
    
    func sectionType(at section: Int) -> SuggestionType {
        guard let suggestions = suggestions else { return .text }
        return suggestions[section].type
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        guard let item = item(at: indexPath) else { return }
        delegate?.searchSuggestionItemTapped(item: item)
    }
}

extension SearchSuggestionPresenter: SearchSuggestionInteractorOutput {
    func handleFetchSuggestionsResponse(_ result: SearchSuggestionResult) {
        switch result {
        case .success(let response):
            self.suggestions = response.suggestions
            view?.reload()
        case .failure(let error):
            // Show error
        print(error)
        }
    }
}
