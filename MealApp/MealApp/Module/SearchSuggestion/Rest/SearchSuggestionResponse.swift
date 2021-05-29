//
//  SearchSuggestionResponse.swift
//  MealApp
//
//  Created by Emre Ergün on 29.05.2021.
//

import Foundation

// MARK: - SearchSuggestionResponse
struct SearchSuggestionResponse: Decodable {
    let suggestions: [Suggestion]
}

// MARK: - Suggestion
struct Suggestion: Decodable {
    let type: SuggestionType
    let title: String
    let items: [SearchItem]
}

// MARK: - Item
struct SearchItem: Decodable {
    let restaurantID: Int?
    let deeplink, title: String
    let kitchen: String?
    let averageDeliveryInterval: String?
    let minBasketPrice: Int?
    let rating: Double?
    let ratingBackgroundColor: String?
    let imageUrl: String?
    let deliveryTypeImage: String?
}

enum SuggestionType: String, Decodable {
    case restaurant = "RESTAURANT"
    case text = "TEXT"
}
