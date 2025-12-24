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
}

extension RocketListContainer {
    var rocketListRepository: Factory<RocketListRepositoryProtocol> {
        self { @MainActor in
            RocketListRepository(apiClient: APIClient(
                baseURL: URL(string: "https://api.spacexdata.com")
            ))
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
