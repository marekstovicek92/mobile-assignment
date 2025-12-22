//
//  RocketListView.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import SwiftUI

enum RocketListRouter: Hashable {
    case detail(RocketListView.Content)
}

struct RocketListView: View {

    @State var viewModel: RocketListViewModel

    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let data):
                contentView(for: data)
            case .error:
                // TODO: Error handling
                Text("Error")
            }
        }
        .task {
            await viewModel.onAppear()
        }
    }

    private func contentView(for data: [Content]) -> some View {
        List(data) { row in
            NavigationLink(value: row) {
                HStack(alignment: .center) {
                    Image(.rocket)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                    VStack(alignment: .leading) {
                        Text(row.rocketName)
                            .font(.system(size: 14, weight: .bold))
                        Text("First flight: \(row.firstFlightDate)")
                    }
                }
            }
        }
        .navigationTitle("Rockets")
        .navigationDestination(for: Content.self) { content in
            RocketDetailView()
        }
    }
}

extension RocketListView {
    struct Content: Identifiable, Hashable {
        let id: String
        let rocketName: String
        let firstFlightDate: String
    }
}

#Preview {
    RocketListView(
        viewModel: RocketListViewModel(
            loadRocketList: RocketListUseCaseMock()
        )
    )
}
