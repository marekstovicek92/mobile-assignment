//
//  RocketDetailViewModel.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import Foundation

@Observable
final class RocketDetailViewModel {

    var state: State = .loading

    private let loadRocketDetail: RocketDetailUseCaseProtocol
    private let locale: Locale
    private let rocketId: String

    init(
        rocketId: String,
        loadRocketDetail: RocketDetailUseCaseProtocol,
        locale: Locale = .current
    ) {
        self.rocketId = rocketId
        self.loadRocketDetail = loadRocketDetail
        self.locale = locale
    }

    @MainActor
    func onAppear() async {
        do {
            let detail = try await loadRocketDetail(id: rocketId)

            let content = RocketDetailView.Content(
                name: detail.name,
                description: detail.overview,
                height: formatDistanceValue(detail.height),
                diameter: formatDistanceValue(detail.diameter),
                mass: formatWeightValue(detail.mass),
                stages: [
                    .init(
                        id: UUID().uuidString,
                        title: "First Stage",
                        isReusable: detail.firstStage?.reusable == true,
                        engines: detail.firstStage?.engines ?? 0,
                        fuelInTons: detail.firstStage?.fuelAmountTons ?? 0,
                        burnTimeInSeconds: detail.firstStage?.burnTimeSec ?? 0
                    ),
                    .init(
                        id: UUID().uuidString,
                        title: "Second Stage",
                        isReusable: detail.secondStage?.reusable == true,
                        engines: detail.secondStage?.engines ?? 0,
                        fuelInTons: detail.secondStage?.fuelAmountTons ?? 0,
                        burnTimeInSeconds: detail.secondStage?.burnTimeSec ?? 0
                    )
                ],
                images: detail.images
            )
            state = .loaded(content)
        } catch {
            // TODO: Handle error
            state = .error(error)
        }
    }

    private func formatDistanceValue(_ distance: RocketDetail.Distance) -> String? {
        guard let meters = distance.meters, let feet = distance.feet else { return nil }
        return locale.measurementSystem == .metric ?
            String(format: "%.0fm", meters) :
            String(format: "%.0fft", feet)
    }

    private func formatWeightValue(_ mass: RocketDetail.Weight) -> String {
        let formatter = MeasurementFormatter()
        formatter.locale = locale
        formatter.unitStyle = .short
        formatter.unitOptions = .providedUnit

        let nf = NumberFormatter()
        nf.locale = locale
        nf.maximumFractionDigits = 1
        nf.minimumFractionDigits = 0
        formatter.numberFormatter = nf

        if locale.measurementSystem == .metric {
            let measurement: Measurement<UnitMass> =
                mass.kg >= 1000
                ? .init(value: mass.kg / 1000, unit: .metricTons)
                : .init(value: mass.kg, unit: .kilograms)

            return formatter.string(from: measurement)
        } else {
            let measurement: Measurement<UnitMass> =
                mass.lb >= 2000
                ? .init(value: mass.lb / 2000, unit: .shortTons)
                : .init(value: mass.lb, unit: .pounds)

            return formatter.string(from: measurement)
        }
    }
}

extension RocketDetailViewModel {
    enum State {
        case loading
        case loaded(RocketDetailView.Content)
        case error(Error)
    }
}
