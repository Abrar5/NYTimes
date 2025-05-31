//
//  DefaultAPIService.swift
//  NYTimes
//
//  Created by Abrar on 31/05/2025.
//

import Foundation

protocol APIService {
    func request<T: Decodable>(_ endpoint: ArticlesTarget, responseType: T.Type) async throws -> T
}

final class DefaultAPIService: APIService {
    func request<T: Decodable>(_ endpoint: ArticlesTarget, responseType: T.Type) async throws -> T {
        var urlComponents = URLComponents(string: ArticlesTarget.baseURL + endpoint.path)!
        urlComponents.queryItems = [URLQueryItem(name: "api-key", value: ArticlesTarget.apiKey)]
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
