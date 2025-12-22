//
//  RocketListViewModel.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import Foundation

@Observable
final class RocketListViewModel {

    var state: State = .loading
    var selectedRocketId: String?

    private let loadRocketList: RocketListUseCaseProtocol

    init(loadRocketList: RocketListUseCaseProtocol) {
        self.loadRocketList = loadRocketList
    }

    @MainActor
    func onAppear() async {
        do {
            let rockets = try await loadRocketList().map(mapToContent)
            state = .loaded(rockets)
        } catch {
            // TODO: Handle error
            state = .error
        }
    }

    private func mapToContent(_ rocket: RocketOverview) -> RocketListView.Content {
        return RocketListView.Content(
            id: rocket.id,
            rocketName: rocket.name,
            firstFlightDate: formatDate(rocket.firstFlight)
        )
    }

    private func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "dd. MM. yyyy"
            return formatter.string(from: date)
        } else {
            return dateString
        }
    }
}

extension RocketListViewModel {
    enum State {
        case loading
        case loaded([RocketListView.Content])
        case error
    }
}
