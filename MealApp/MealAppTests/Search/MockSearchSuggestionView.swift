//
//  MockSearchSuggestionView.swift
//  MealAppTests
//
//  Created by Yusuf Özgül on 30.05.2021.
//

import Foundation
@testable import MealApp

final class MockSearchSuggestionView: SearchSuggestionViewInterface {
    var invokedCollectionViewWidthGetter = false
    var invokedCollectionViewWidthGetterCount = 0
    var stubbedCollectionViewWidth: Double! = 0

    var collectionViewWidth: Double {
        invokedCollectionViewWidthGetter = true
        invokedCollectionViewWidthGetterCount += 1
        return stubbedCollectionViewWidth
    }

    var invokedPrepareCollectionView = false
    var invokedPrepareCollectionViewCount = 0

    func prepareCollectionView() {
        invokedPrepareCollectionView = true
        invokedPrepareCollectionViewCount += 1
    }

    var invokedReload = false
    var invokedReloadCount = 0

    func reload() {
        invokedReload = true
        invokedReloadCount += 1
    }
}
