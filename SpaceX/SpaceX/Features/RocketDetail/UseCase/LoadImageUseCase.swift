//
//  LoadImageUseCase.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 27.12.2025.
//

import Foundation

protocol LoadImageRepositoryProtocol {
    func loadData(from url: URL) async throws -> Data
}

protocol LoadImageUseCaseProtocol {
    func callAsFunction(for urls: [URL]) -> AsyncStream<RocketImage>
}

struct LoadImageUseCase: LoadImageUseCaseProtocol {

    private let repository: LoadImageRepositoryProtocol

    init(repository: LoadImageRepositoryProtocol) {
        self.repository = repository
    }

    func callAsFunction(for urls: [URL]) -> AsyncStream<RocketImage> {
        AsyncStream { continuation in
            Task {
                await withTaskGroup(of: (URL, Data)?.self) { group in
                    for url in urls {
                        group.addTask {
                            do {
                                let data = try await self.repository.loadData(from: url)
                                return (url, data)
                            } catch {
                                return nil
                            }
                        }
                    }

                    for await result in group {
                        if let result {
                            // We can store imageData to cache, prepare thumbnails or other processes here
                            continuation.yield(RocketImage(url: result.0.absoluteString, data: result.1))
                        }
                    }

                    continuation.finish()
                }
            }
        }
    }
}
