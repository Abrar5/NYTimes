//
//  FetchMostPopularArticlesUseCase.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import Foundation

class FetchMostPopularArticlesUseCase {
    private let repository: ArticleRepository

    init(repository: ArticleRepository) {
        self.repository = repository
    }

    func execute(period: Int = 7) async throws -> [Article] {
        return try await repository.fetchMostPopularArticles(period: period)
    }
}

