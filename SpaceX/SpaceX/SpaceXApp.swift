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

    let networkingContainer = NetworkingContainer()

    var body: some Scene {
        WindowGroup {
            RocketListView(
                viewModel: RocketListContainer(networkingContainer: networkingContainer).rocketListViewModel.resolve(),
                router: RocketListRouter(
                    rocketDetailContainer: RocketDetailContainer(networkingContainer: networkingContainer),
                    launchRocketContainer: LaunchRocketContainer()
                )
            )
        }
    }
}
