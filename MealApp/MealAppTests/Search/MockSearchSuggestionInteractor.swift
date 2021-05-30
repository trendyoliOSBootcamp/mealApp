//
//  MockSearchSuggestionInteractor.swift
//  MealAppTests
//
//  Created by Yusuf Özgül on 30.05.2021.
//

import Foundation
@testable import MealApp

final class MockSearchSuggestionInteractor: SearchSuggestionInteractorInterface {
    var invokedFetchSuggestions = false
    var invokedFetchSuggestionsCount = 0
    var invokedFetchSuggestionsParameters: (keyword: String, Void)?
    var invokedFetchSuggestionsParametersList = [(keyword: String, Void)]()

    func fetchSuggestions(keyword: String) {
        invokedFetchSuggestions = true
        invokedFetchSuggestionsCount += 1
        invokedFetchSuggestionsParameters = (keyword, ())
        invokedFetchSuggestionsParametersList.append((keyword, ()))
    }
}
