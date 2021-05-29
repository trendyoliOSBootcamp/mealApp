//
//  SearchEndpointItem.swift
//  MealApp
//
//  Created by Emre Ergün on 29.05.2021.
//

import CoreApi

enum SearchEndpointItem: Endpoint {
    case suggestions(keyword: String)
    
    var baseUrl: String { "https://us-central1-infumar.cloudfunctions.net/" }
    
    var path: String {
        switch self {
        case .suggestions(let keyword):
            return "suggestions?text=\(keyword.lowercased())"
        }

    }
    
    var method: HTTPMethod { .get }
}
