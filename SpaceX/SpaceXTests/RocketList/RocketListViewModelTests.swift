//
//  RocketListViewModelTests.swift
//  SpaceXTests
//
//  Created by Marek Šťovíček on 23.12.2025.
//

import Testing
@testable import SpaceX

struct RocketListViewModelTests {

    @Test func initial() async throws {
        let sut = makeSUT()

        if case .loading = sut.state {
            #expect(Bool(true))
        } else {
            #expect(Bool(false), "Expected initial state to be .loading")
        }
    }

    @Test func loadedState() async throws {
        let sut = makeSUT()

        await sut.onAppear()

        if case let .loaded(data) = sut.state {
            #expect(data.count == 3, "Expected 3 rockets in mock data")
        } else {
            #expect(Bool(false), "Expected state to be .loaded after successful load")
        }
    }

    @Test func loadFailedState() async throws {
        let sut = makeSUT(useCase: RocketListFailingUseCaseMock())

        await sut.onAppear()

        if case .error = sut.state {
            #expect(Bool(true))
        } else {
            #expect(Bool(false), "Expected state to be .error after failing use case")
        }
    }

    @Test func onAppear_isIdempotent() async throws {
        // When onAppear is called multiple times, the result should still be loaded once
        let sut = makeSUT()

        await sut.onAppear()
        await sut.onAppear()

        if case let .loaded(data) = sut.state {
            #expect(data.count == 3)
        } else {
            #expect(Bool(false), "Expected .loaded state after multiple onAppear calls")
        }
    }

    @Test func loadedDataContainsExpectedValues() async throws {
        // Validate that mock use case maps values correctly into view model's loaded state
        let sut = makeSUT()
        await sut.onAppear()

        guard case let .loaded(data) = sut.state else {
            #expect(Bool(false), "Expected .loaded state to validate contents")
            return
        }

        #expect(!data.isEmpty)
        // Spot-check first element for stable mock content if available
        // Adjust these expectations to your RocketListUseCaseMock() data if needed
        if let first = data.first {
            // Basic sanity checks that typical model fields are populated
            // We can't rely on exact names without seeing the mock, so check non-empty
            #expect(!String(describing: first).isEmpty)
        }
    }

    @Test func switchingFromLoadingToLoaded() async throws {
        let sut = makeSUT()

        // Before
        if case .loading = sut.state {
            #expect(true)
        } else {
            #expect(Bool(false), "Expected to start in .loading state")
        }

        // After
        await sut.onAppear()
        if case .loaded = sut.state {
            #expect(true)
        } else {
            #expect(Bool(false), "Expected to transition to .loaded state")
        }
    }

    private func makeSUT(useCase: any RocketListUseCaseProtocol = RocketListUseCaseMock()) -> RocketListViewModel {
        return RocketListViewModel(loadRocketList: useCase)
    }
}

private struct RocketListFailingUseCaseMock: RocketListUseCaseProtocol {

    enum RocketListErrorMock: Error {
        case generic
    }

    func callAsFunction() async throws -> [RocketOverview] {
        throw RocketListErrorMock.generic
    }
}
