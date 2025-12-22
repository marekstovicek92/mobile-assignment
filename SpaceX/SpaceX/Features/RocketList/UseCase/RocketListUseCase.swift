//
//  RocketListUseCase.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import Foundation

struct RocketOverview {
    let id: String
    let name: String
    let firstFlight: String
}

protocol RocketListRepositoryProtocol {
    func fetchRockets() async throws -> [RocketOverview]
}

protocol RocketListUseCaseProtocol {
    func callAsFunction() async throws -> [RocketOverview]
}

struct RocketListUseCase: RocketListUseCaseProtocol {

    let repository: RocketListRepositoryProtocol

    init(repository: RocketListRepositoryProtocol) {
        self.repository = repository
    }

    func callAsFunction() async throws -> [RocketOverview] {
        return try await repository.fetchRockets()
    }
}


struct RocketListUseCaseMock: RocketListUseCaseProtocol {
    func callAsFunction() async throws -> [RocketOverview] {
        [
            .init(
                id: UUID().uuidString,
                name: "Rocket 1",
                firstFlight: "1. 1. 1990"
            ),
            .init(
                id: UUID().uuidString,
                name: "Rocket 2",
                firstFlight: "1. 2. 1990"
            ),
            .init(
                id: UUID().uuidString,
                name: "Rocket 3",
                firstFlight: "1. 3. 1990"
            )
        ]
    }


}
