//
//  ArticleRepositoryImplementation.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import Foundation

class ArticleRepositoryImplementation: ArticleRepository {
    private let apiService: DefaultAPIService
    private let cache: ArticlesRealmManager

    init(apiService: DefaultAPIService = DefaultAPIService(), cache: ArticlesRealmManager = ArticlesRealmManager()) {
        self.apiService = apiService
        self.cache = cache
    }

    func fetchMostViewedArticles(period: Int) async throws -> [ArticleEntity] {
        let cachedArticles = await self.cache.load()
        if cachedArticles.isEmpty {
            let result = try await apiService.request(.getMostViewedArticles(days: period), responseType: NYTimesDTO.self)
            let articles = result.results?.map { $0.toDomain() } ?? []
            let cachedObject = articles.map { ArticleObject(article: $0) }
            self.cache.save(articles: cachedObject)
            return articles
        }
        return cachedArticles
    }
}
