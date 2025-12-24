//
//  LaunchRocketContainer.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 24.12.2025.
//

import Foundation
import FactoryKit

final class LaunchRocketContainer: ManagedContainer {
    let manager = ContainerManager()
}

extension LaunchRocketContainer {
    var launchRocketRepository: Factory<MotionDetectionRepository> {
        self { @MainActor in
            MotionDetectionRepository()
        }
    }

    var launchRocketUseCase: Factory<MotionDetectionUseCaseProtocol> {
        self { @MainActor in
            MotionDetectionUseCase(repository: self.launchRocketRepository.resolve())
        }
    }

    var launchRocketViewModel: Factory<RocketLaunchViewModel> {
        self { @MainActor in
            RocketLaunchViewModel(motionDetectionUseCase: self.launchRocketUseCase.resolve())
        }
    }
}
