//
//  ArticleRepositoryImplementation.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import Foundation

class ArticleRepositoryImplementation: ArticleRepository {
    private let apiService: NYTAPIService
    private let cache: ArticlesRealmManager

    init(apiService: NYTAPIService = NYTAPIServiceImplementation(), cache: ArticlesRealmManager = ArticlesRealmManager()) {
        self.apiService = apiService
        self.cache = cache
    }

    func fetchMostPopularArticles(period: Int) async throws -> [ArticleEntity] {
        let cachedArticle = await self.cache.load()
        if cachedArticle.isEmpty {
            let result = try await apiService.getMostPopularArticles(period: period)
            let articles = result.map { $0.toDomain() }
            let cachedObject = articles.map { ArticleObject(article: $0) }
            self.cache.save(articles: cachedObject)
            return articles
        }
        return cachedArticle
    }
}
