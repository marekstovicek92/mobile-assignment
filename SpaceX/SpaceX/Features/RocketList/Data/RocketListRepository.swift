//
//  RocketListRepository.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import Foundation

struct RocketOverviewDTO: Decodable {
    let id: String
    let name: String
    let firstFlight: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firstFlight = "first_flight"
    }
}

struct RocketListRepository: RocketListRepositoryProtocol {

    let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchRockets() async throws -> [RocketOverview] {
        let response: [RocketOverviewDTO] = try await apiClient.data(
            for: SpaceXEndpoint.list
        )
        return response.map {
            RocketOverview(id: $0.id, name: $0.name, firstFlight: $0.firstFlight)
        }
    }
}
