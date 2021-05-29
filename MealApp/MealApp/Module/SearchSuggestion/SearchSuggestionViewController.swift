//
//  SearchSuggestionViewController.swift
//  MealApp
//
//  Created by Emre Ergün on 29.05.2021.
//

import UIKit

protocol SearchSuggestionViewInterface: AnyObject {
    
}

final class SearchSuggestionViewController: UIViewController {
    var presenter: SearchSuggestionPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

extension SearchSuggestionViewController: SearchSuggestionViewInterface {
    // Interface methods implmenetation
}
