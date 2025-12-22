//
//  RocketDetailDTO.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import Foundation

// MARK: - RocketDetailDTO
struct RocketDetailDTO: Decodable {
    let height: DimensionDTO
    let diameter: DimensionDTO
    let mass: MassDTO
    let firstStage: FirstStageDTO
    let secondStage: SecondStageDTO
    let engines: EnginesDTO
    let landingLegs: LandingLegsDTO
    let payloadWeights: [PayloadWeightDTO]
    let flickrImages: [URL]
    let name: String
    let type: String
    let active: Bool
    let stages: Int
    let boosters: Int
    let costPerLaunch: Int
    let successRatePct: Int
    let firstFlight: String
    let country: String
    let company: String
    let wikipedia: URL
    let description: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case height, diameter, mass
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case engines
        case landingLegs = "landing_legs"
        case payloadWeights = "payload_weights"
        case flickrImages = "flickr_images"
        case name, type, active, stages, boosters
        case costPerLaunch = "cost_per_launch"
        case successRatePct = "success_rate_pct"
        case firstFlight = "first_flight"
        case country, company, wikipedia, description, id
    }
}

// MARK: - DimensionDTO
struct DimensionDTO: Decodable {
    let meters: Double
    let feet: Double
}

// MARK: - MassDTO
struct MassDTO: Decodable {
    let kg: Double
    let lb: Double
}

// MARK: - ThrustDTO
struct ThrustDTO: Decodable {
    let kN: Int
    let lbf: Int

    enum CodingKeys: String, CodingKey {
        case kN = "kN"
        case lbf
    }
}

// MARK: - FirstStageDTO
struct FirstStageDTO: Decodable {
    let thrustSeaLevel: ThrustDTO
    let thrustVacuum: ThrustDTO
    let reusable: Bool
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSec: Int?

    enum CodingKeys: String, CodingKey {
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
        case reusable, engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSec = "burn_time_sec"
    }
}

// MARK: - SecondStageDTO
struct SecondStageDTO: Decodable {
    let thrust: ThrustDTO
    let payloads: PayloadsDTO
    let reusable: Bool
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSec: Int?

    enum CodingKeys: String, CodingKey {
        case thrust, payloads, reusable, engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSec = "burn_time_sec"
    }
}

// MARK: - PayloadsDTO
struct PayloadsDTO: Decodable {
    let compositeFairing: CompositeFairingDTO
    let option1: String

    enum CodingKeys: String, CodingKey {
        case compositeFairing = "composite_fairing"
        case option1 = "option_1"
    }
}

// MARK: - CompositeFairingDTO
struct CompositeFairingDTO: Decodable {
    let height: DimensionDTO
    let diameter: DimensionDTO
}

// MARK: - EnginesDTO
struct EnginesDTO: Decodable {
    struct ISPDTO: Decodable {
        let seaLevel: Int
        let vacuum: Int

        enum CodingKeys: String, CodingKey {
            case seaLevel = "sea_level"
            case vacuum
        }
    }

    let isp: ISPDTO
    let thrustSeaLevel: ThrustDTO
    let thrustVacuum: ThrustDTO
    let number: Int
    let type: String
    let version: String
    let layout: String?
    let engineLossMax: Int?
    let propellant1: String
    let propellant2: String
    let thrustToWeight: Double

    enum CodingKeys: String, CodingKey {
        case isp
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
        case number, type, version, layout
        case engineLossMax = "engine_loss_max"
        case propellant1 = "propellant_1"
        case propellant2 = "propellant_2"
        case thrustToWeight = "thrust_to_weight"
    }
}

// MARK: - LandingLegsDTO
struct LandingLegsDTO: Decodable {
    let number: Int
    let material: String?
}

// MARK: - PayloadWeightDTO
struct PayloadWeightDTO: Decodable {
    let id: String
    let name: String
    let kg: Int
    let lb: Int
}
