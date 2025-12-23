//
//  RocketListUseCaseTests.swift
//  SpaceXTests
//
//  Created by Marek Šťovíček on 23.12.2025.
//

import Testing

struct RocketListUseCaseTests {

    @Test func dataLoadingSuccess() async throws {
        let sut = makeSUT()

        let rockets = try await sut()

        #expect(rockets.count == 2)
    }

    @Test func dataLoadingFailure() async {
        let sut = makeSUT(repository: RocketListRepositoryProtocolFailingMock())

        do {
            _ = try await sut()
            #expect(Bool(false))
        } catch is RocketListRepositoryProtocolFailingMock.RocketListRepositoryErrorMock {
            #expect(Bool(true))
        } catch {
            #expect(Bool(false))
        }
    }

    private func makeSUT(
        repository: RocketListRepositoryProtocol = RocketListRepositoryProtocolMock()
    ) -> some RocketListUseCaseProtocol {
        RocketListUseCase(repository: repository)
    }
}

struct RocketListRepositoryProtocolMock: RocketListRepositoryProtocol {
    func fetchRockets() async throws -> [RocketOverview] {
        [.mock1, .mock2]
    }
}

struct RocketListRepositoryProtocolFailingMock: RocketListRepositoryProtocol {
    enum RocketListRepositoryErrorMock: Error {
        case generic
    }

    func fetchRockets() async throws -> [RocketOverview] {
        throw RocketListRepositoryErrorMock.generic
    }
}
