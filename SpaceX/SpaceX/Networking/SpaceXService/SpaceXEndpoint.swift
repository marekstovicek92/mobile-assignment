//
//  SpaceXEndpoint.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import Foundation

enum SpaceXEndpoint: APIEndpoint {
    case list
    case detail(String)

    var path: String {
        switch self {
        case .list:
            return "/v4/rockets"
        case .detail(let id):
            return "/v4/rockets/\(id)"
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .list, .detail:
            return nil
        }
    }
}
