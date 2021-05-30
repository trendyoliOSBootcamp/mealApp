//
//  MockSearchSuggestionDelegate.swift
//  MealAppTests
//
//  Created by Yusuf Özgül on 30.05.2021.
//

import Foundation
@testable import MealApp

final class MockSearchSuggestionDelegate: SearchSuggestionDelegate {
    var invokedSearchSuggestionItemTapped = false
    var invokedSearchSuggestionItemTappedCount = 0
    var invokedSearchSuggestionItemTappedParameters: (item: SearchItem, Void)?
    var invokedSearchSuggestionItemTappedParametersList = [(item: SearchItem, Void)]()

    func searchSuggestionItemTapped(item: SearchItem) {
        invokedSearchSuggestionItemTapped = true
        invokedSearchSuggestionItemTappedCount += 1
        invokedSearchSuggestionItemTappedParameters = (item, ())
        invokedSearchSuggestionItemTappedParametersList.append((item, ()))
    }
}
