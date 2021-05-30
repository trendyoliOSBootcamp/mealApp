//
//  MockRestaurantCollectionDelegate.swift
//  MealAppTests
//
//  Created by Mine on 30.05.2021.
//

import Foundation
@testable import MealApp

final class MockRestaurantCollectionDelegate: RestaurantCollectionDelegate {
    var invokedFavoriteButtonTapped = false
    var invokedFavoriteButtonTappedCount = 0

    func favoriteButtonTapped() {
        invokedFavoriteButtonTapped = true
        invokedFavoriteButtonTappedCount += 1
    }
}
