//
//  ArticleRepositoryImplementation.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import Foundation

class ArticleRepositoryImplementation: ArticleRepository {
    private let apiService: NetworkService
    private let cache: ArticlesRealmManager
    
    init(apiService: NetworkService = NetworkService(), cache: ArticlesRealmManager = ArticlesRealmManager()) {
        self.apiService = apiService
        self.cache = cache
    }
    
    func fetchMostViewedArticles(period: Int) async throws -> [ArticleEntity] {
        let cachedArticles = self.cache.load()
        
        // Check current cache validity
        if !cachedArticles.isEmpty, let savedRecordDate = cachedArticles.first?.savedDate {
            let isValidRecordDate = isValidRecordDate(savedRecordDate)
            if isValidRecordDate {
                return cachedArticles
            } else {
                clearCache()
            }
        }
        
        // Get New Record
        let result = try await apiService.request(ArticlesTarget.getMostViewedArticles(days: period), responseType: NYTimesDTO.self)
        let articles = result.results?.map { ArticleMapper().map(dto: $0) } ?? []
        let cachedObject = articles.map { ArticleObject(article: $0) }
        saveCache(cachedObject)
        return articles
    }
    
    private func isValidRecordDate(_ savedRecordDate: Date) -> Bool {
        return Calendar.current.isDateInToday(savedRecordDate)
    }
    
    private func clearCache() {
        self.cache.clearAllCachedArticles() { }
    }
    
    private func saveCache(_ articles: [ArticleObject]) {
        self.cache.save(articles: articles)
    }
}
