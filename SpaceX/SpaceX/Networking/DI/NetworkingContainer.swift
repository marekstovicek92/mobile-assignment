//
//  NetworkingContainer.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 27.12.2025.
//

import Foundation
import FactoryKit

final class NetworkingContainer: ManagedContainer {
    let manager = ContainerManager()
}

extension NetworkingContainer {
    var spaceXClient: Factory<APIClient> {
        self { @MainActor in
            APIClient(baseURL: URL(string: "https://api.spacexdata.com"))
        }
        .shared
    }

    var imageRepository: Factory<ImageRepository> {
        self { @MainActor in
            ImageRepository()
        }
    }
}
