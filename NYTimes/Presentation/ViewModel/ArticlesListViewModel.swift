//
//  ArticlesListViewModel.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import Foundation

class ArticlesListViewModel: ObservableObject {
    @Published var articles: [ArticleEntity] = []
    @Published var errorMessage: String?

    private let fetchUseCase: FetchMostPopularArticlesUseCase

    init() {
        self.fetchUseCase = FetchMostPopularArticlesUseCase(repository: ArticleRepositoryImplementation())
    }

    @MainActor
    func fetchArticles(period: Int = 7) {
        Task {
            do {
                let articlesList = try await self.fetchUseCase.execute(period: period)
                self.articles = getSortArticlesByDate(articlesList)
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func getSortArticlesByDate(_ articles: [ArticleEntity]) -> [ArticleEntity] {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        return articles.sorted {
            guard let firstDate = formatter.date(from: $0.publishedDate),
                  let secondDate = formatter.date(from: $1.publishedDate) else {
                return false
            }
            return firstDate > secondDate
        }
    }
}
