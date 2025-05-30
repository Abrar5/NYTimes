//
//  NYTAPIServiceImplementation.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import Foundation

protocol NYTAPIService {
    func getMostPopularArticles(period: Int) async throws -> [ResultDTO]
}

class NYTAPIServiceImplementation: NYTAPIService {
    private let apiKey = "tkM1UwG9jpmiA46iMay9LjG2nEwTXlPB"
    
    func getMostPopularArticles(period: Int) async throws -> [ResultDTO] {
        guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/\(period).json?api-key=\(apiKey)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(NYTimesDTO.self, from: data)
        return decoded.results ?? []
    }
}
