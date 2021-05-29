//
//  SearchPresentable.swift
//  MealApp
//
//  Created by Emre Ergün on 29.05.2021.
//

import UIKit

protocol SearchPresentable {
    var navigationItem: UINavigationItem { get }
    var searchController: UISearchController? { get set }
    
    var searchSuggestionViewController: UIViewController? { get }
    var searchResultUpdating: UISearchResultsUpdating { get }
    var searchIcon: UIImage? { get }
    var horizontalPadding: CGFloat { get }
    var placeholder: String { get }
    var placeholderFont: UIFont { get }
    
    mutating func prepareSearchController()
}

extension SearchPresentable {
    mutating func prepareSearchController() {
        let searchController = UISearchController(searchResultsController: searchSuggestionViewController)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchResultsUpdater = searchResultUpdating
        
        searchController.searchBar.setImage(searchIcon, for: .search, state: .normal)
        searchController.searchBar.setPositionAdjustment(.init(horizontal: horizontalPadding, vertical: 0), for: .search)
        searchController.searchBar.searchTextPositionAdjustment = .init(horizontal: horizontalPadding, vertical: 0)
        searchController.searchBar.placeholder = placeholder
        
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Vazgeç"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.primaryColor
        
        navigationItem.searchController = searchController
        self.searchController = searchController
    }
}
