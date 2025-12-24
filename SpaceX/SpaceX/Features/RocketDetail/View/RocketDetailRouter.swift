//
//  RocketDetailRouter.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 24.12.2025.
//

import Foundation
import FactoryKit

struct RocketDetailRouter {
    private let launchRocketContainer: LaunchRocketContainer

    init(launchRocketContainer: LaunchRocketContainer) {
        self.launchRocketContainer = launchRocketContainer
    }

    func makeLaunchView() -> RocketLaunchView {
        RocketLaunchView(
            viewModel: launchRocketContainer.launchRocketViewModel.resolve()
        )
    }
}
