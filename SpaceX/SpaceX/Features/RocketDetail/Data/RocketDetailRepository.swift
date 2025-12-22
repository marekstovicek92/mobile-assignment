//
//  RocketDetailRepository.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import Foundation

struct RocketDetailRepository: RocketDetailRepositoryProtocol {
    let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchRocket(id: String) async throws -> RocketDetail {
        let response: RocketDetailDTO = try await apiClient.data(
            for: SpaceXEndpoint.detail(id)
        )
        return RocketDetail(
            name: response.name,
            overview: response.description,
            height: .init(meters: response.height.meters, feet: response.height.feet),
            diameter: .init(meters: response.diameter.meters, feet: response.diameter.feet),
            mass: .init(kg: response.mass.kg, lb: response.mass.lb),
            firstStage: .init(
                reusable: response.firstStage.reusable,
                engines: response.firstStage.engines,
                fuelAmountTons: response.firstStage.fuelAmountTons,
                burnTimeSec: response.firstStage.burnTimeSec
            ),
            secondStage: .init(
                reusable: response.secondStage.reusable,
                engines: response.secondStage.engines,
                fuelAmountTons: response.secondStage.fuelAmountTons,
                burnTimeSec: response.secondStage.burnTimeSec
            ),
            images: response.flickrImages
        )
    }
}
