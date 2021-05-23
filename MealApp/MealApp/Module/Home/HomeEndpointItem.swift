//
//  HomeEndpointItem.swift
//  MealApp
//
//  Created by Anıl Taşkıran on 22.05.2021.
//

import Foundation
import CoreApi

enum HomeEndpointItem: Endpoint {
    case homepage(query: String)

    var baseUrl: String { "https://us-central1-infumar.cloudfunctions.net/" }
    var path: String {
        switch self {
        case .homepage(let query): return "homepage?\(query)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .homepage: return .get
        }
    }
}
