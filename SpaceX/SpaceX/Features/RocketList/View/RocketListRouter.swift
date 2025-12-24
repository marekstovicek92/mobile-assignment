//
//  RocketListRouter.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 24.12.2025.
//

import Foundation
import FactoryKit

struct RocketListRouter {
    private let rocketDetailContainer: RocketDetailContainer
    private let launchRocketContainer: LaunchRocketContainer

    init(
        rocketDetailContainer: RocketDetailContainer,
        launchRocketContainer: LaunchRocketContainer
    ) {
        self.rocketDetailContainer = rocketDetailContainer
        self.launchRocketContainer = launchRocketContainer
    }
    
    func makeRocketDetailView(with id: String) -> RocketDetailView {
        RocketDetailView(
            viewModel: rocketDetailContainer.rocketDetailViewModel.resolve(id),
            router: RocketDetailRouter(
                launchRocketContainer: launchRocketContainer
            )
        )
    }
}
