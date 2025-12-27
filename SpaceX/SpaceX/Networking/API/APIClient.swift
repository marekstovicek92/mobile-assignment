//
//  APIClient.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import Foundation

protocol APIEndpoint {
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

enum APIClientError: Error {
    case invalidBaseURL
    case invalidURL
}

final class APIClient {

    private let urlSession: URLSession
    private let baseURL: URL?

    init(baseURL: URL?, urlSession: URLSession =  URLSession.shared) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }

    func data(for url: URL) async throws -> Data {
        let (data, _ ) = try await urlSession.data(for: .init(url: url))
        return data
    }

    func data<T: Decodable>(for endpoint: APIEndpoint) async throws -> T {
        let request = try makeURLRequest(for: endpoint)
        let (data, _) = try await urlSession.data(for: request)
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }

    private func makeURLRequest(for endpoint: APIEndpoint) throws -> URLRequest {
        guard let baseURL else { throw APIClientError.invalidBaseURL }
        guard var urlComponents = URLComponents(
                    url: baseURL.appendingPathComponent(endpoint.path),
                    resolvingAgainstBaseURL: false
                )
        else { throw APIClientError.invalidBaseURL }

        urlComponents.queryItems = endpoint.queryItems

        guard let url = urlComponents.url else { throw APIClientError.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
