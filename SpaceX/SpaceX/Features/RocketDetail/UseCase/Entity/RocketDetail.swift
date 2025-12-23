//
//  RocketDetail.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import Foundation

struct RocketDetail {
    let name: String
    let overview: String
    let height: Distance
    let diameter: Distance
    let mass: Weight
    let firstStage: Stage?
    let secondStage: Stage?
    let images: [URL]?

    struct Distance {
        let meters: Double?
        let feet: Double?
    }

    struct Weight {
        let kg: Double
        let lb: Double
    }

    struct Stage {
        let reusable: Bool
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Int?
    }
}

extension RocketDetail {
    static let mock = RocketDetail(
        name: "Falcon 9",
        overview: "Falcon 9 is a two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit. Falcon 9 is the first orbital class rocket capable of reflight.",
        height: RocketDetail.Distance(meters: 70.0, feet: 229.6),
        diameter: RocketDetail.Distance(meters: 3.7, feet: 12.1),
        mass: RocketDetail.Weight(kg: 549_054, lb: 1_207_920),
        firstStage: nil,
        secondStage: nil,
        images: []
    )
}
