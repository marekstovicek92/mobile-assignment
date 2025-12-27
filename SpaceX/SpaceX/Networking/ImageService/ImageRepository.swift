//
//  ImageRepository.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 27.12.2025.
//

import Foundation

struct ImageRepository: LoadImageRepositoryProtocol {
    func loadData(from url: URL) async throws -> Data {
        try await URLSession.shared.data(from: url).0
    }
}
