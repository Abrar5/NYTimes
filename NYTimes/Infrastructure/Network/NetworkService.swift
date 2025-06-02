//
//  NetworkService.swift
//  NYTimes
//
//  Created by Abrar on 31/05/2025.
//

import Foundation

final class NetworkService: ApiService {
    func request<T: Decodable>(_ endpoint: ApiTarget, responseType: T.Type) async throws -> T {
        guard var urlComponents = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            throw URLError(.badURL)
        }
        
        urlComponents.queryItems = endpoint.urlComponents.queryItems
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
