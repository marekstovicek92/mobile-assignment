//
//  SpaceXEndpoint.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import Foundation

enum SpaceXEndpoint: APIEndpoint {
    case list
    case detail

    var path: String {
        switch self {
        case .list:
            return "/v4/rockets"
        case .detail:
            return ""
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .list, .detail:
            return nil
        }
    }
}
