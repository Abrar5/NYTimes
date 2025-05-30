//
//  ArticleRepositoryImplementation.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import Foundation

class ArticleRepositoryImplementation: ArticleRepository {
    private let apiService: NYTAPIService

    init(apiService: NYTAPIService = NYTAPIServiceImplementation()) {
        self.apiService = apiService
    }

    func fetchMostPopularArticles(period: Int) async throws -> [Article] {
        let result = try await apiService.getMostPopularArticles(period: period)
        return result.map { $0.toDomainModel() }
    }
}
