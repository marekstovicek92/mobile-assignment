//
//  ContentView.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import SwiftUI
import FactoryKit

struct ContentView: View {

    let rocketListContainer = RocketListContainer()

    var body: some View {
        RocketListView(
            viewModel: rocketListContainer.rocketListViewModel.resolve(),
            router: RocketListRouter(
                rocketDetailContainer: RocketDetailContainer(),
                launchRocketContainer: LaunchRocketContainer()
            )
        )
    }
}

#Preview {
    ContentView()
}
