//
//  RocketDetailContainer.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 24.12.2025.
//

import Foundation
import FactoryKit

final class RocketDetailContainer: ManagedContainer {
    let manager = ContainerManager()
    let networkingContainer: NetworkingContainer

    init(networkingContainer: NetworkingContainer) {
        self.networkingContainer = networkingContainer
    }
}

extension RocketDetailContainer {

    var rocketDetailRepository: Factory<RocketDetailRepositoryProtocol> {
        self { @MainActor in
            RocketDetailRepository(apiClient: self.networkingContainer.spaceXClient.resolve())
        }
    }

    var rocketDetailUseCase: Factory<RocketDetailUseCaseProtocol> {
        self { @MainActor in
            RocketDetailUseCase(repository: self.rocketDetailRepository.resolve())
        }
    }

    var rocketImagesUseCase: Factory<LoadImageUseCaseProtocol> {
        self { @MainActor in
            LoadImageUseCase(repository: self.networkingContainer.imageRepository.resolve())
        }
    }

    var rocketDetailViewModel: ParameterFactory<String, RocketDetailViewModel> {
        self { @MainActor id in
            RocketDetailViewModel(
                rocketId: id,
                loadRocketDetail: self.rocketDetailUseCase.resolve(),
                loadImages: self.rocketImagesUseCase.resolve()
            )
        }
    }
}
