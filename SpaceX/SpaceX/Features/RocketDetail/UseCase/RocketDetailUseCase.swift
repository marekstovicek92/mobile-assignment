//
//  RocketDetailUseCase.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import Foundation

protocol RocketDetailRepositoryProtocol {
    func fetchRocket(id: String) async throws -> RocketDetail
}

protocol RocketDetailUseCaseProtocol {
    func callAsFunction(id: String) async throws -> RocketDetail
}

struct RocketDetailUseCase: RocketDetailUseCaseProtocol {

    let repository: RocketDetailRepositoryProtocol

    init(repository: RocketDetailRepositoryProtocol) {
        self.repository = repository
    }

    func callAsFunction(id: String) async throws -> RocketDetail {
        try await repository.fetchRocket(id: id)
    }
}

struct RocketDetailUseCaseMock: RocketDetailUseCaseProtocol {
    func callAsFunction(id: String) async throws -> RocketDetail {
        .mock
    }
}
