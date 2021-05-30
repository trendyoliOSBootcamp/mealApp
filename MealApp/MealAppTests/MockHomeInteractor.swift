//
//  MockHomeInteractor.swift
//  MealAppTests
//
//  Created by Anıl Taşkıran on 30.05.2021.
//

import Foundation
@testable import MealApp

final class MockHomeInteractor: HomeInteractorInterface {
    var invokedFetchWidgets = false
    var invokedFetchWidgetsCount = 0
    var invokedFetchWidgetsParameters: (query: String, Void)?
    var invokedFetchWidgetsParametersList = [(query: String, Void)]()

    func fetchWidgets(query: String) {
        invokedFetchWidgets = true
        invokedFetchWidgetsCount += 1
        invokedFetchWidgetsParameters = (query, ())
        invokedFetchWidgetsParametersList.append((query, ()))
    }
}
