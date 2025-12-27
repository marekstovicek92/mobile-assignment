//
//  RocketListContainer.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 24.12.2025.
//

import Foundation
import FactoryKit

final class RocketListContainer: ManagedContainer {
    let manager = ContainerManager()
    let networkingContainer: NetworkingContainer

    init(networkingContainer: NetworkingContainer) {
        self.networkingContainer = networkingContainer
    }
}

extension RocketListContainer {
    var rocketListRepository: Factory<RocketListRepositoryProtocol> {
        self { @MainActor in
            RocketListRepository(apiClient: self.networkingContainer.spaceXClient.resolve())
        }
    }

    var rocketListUseCase: Factory<RocketListUseCaseProtocol> {
        self { @MainActor in
            RocketListUseCase(
                repository: self.rocketListRepository.resolve()
            )
        }
    }

    var rocketListViewModel: Factory<RocketListViewModel> {
        self { @MainActor in
            RocketListViewModel(
                loadRocketList: self.rocketListUseCase.resolve()
            )
        }
    }
}
