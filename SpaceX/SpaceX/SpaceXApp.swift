//
//  SpaceXApp.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import SwiftUI
import FactoryKit

@main
struct SpaceXApp: App {

    let rocketListContainer = RocketListContainer()

    var body: some Scene {
        WindowGroup {
            RocketListView(
                viewModel: rocketListContainer.rocketListViewModel.resolve(),
                router: RocketListRouter(
                    rocketDetailContainer: RocketDetailContainer(),
                    launchRocketContainer: LaunchRocketContainer()
                )
            )
        }
    }
}
