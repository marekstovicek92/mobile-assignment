//
//  ContentView.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RocketListView(
            viewModel: RocketListViewModel(
                loadRocketList: RocketListUseCase(
                    repository: RocketListRepository(
                        apiClient: APIClient(
                            // TODO: Inject from some DI container
                            baseURL: URL(string: "https://api.spacexdata.com")
                        )
                    )
                )
            )
        )
    }
}

#Preview {
    ContentView()
}
