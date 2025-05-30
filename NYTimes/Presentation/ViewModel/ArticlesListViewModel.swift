//
//  ArticlesListViewModel.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import Foundation

@MainActor
class ArticlesListViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var errorMessage: String?

    private let fetchUseCase: FetchMostPopularArticlesUseCase

    init() {
        self.fetchUseCase = FetchMostPopularArticlesUseCase(repository: ArticleRepositoryImplementation())
    }

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
    
    func getSortArticlesByDate(_ articles: [Article]) -> [Article] {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        return articles.sorted {
            guard let date1 = formatter.date(from: $0.publishedDate),
                  let date2 = formatter.date(from: $1.publishedDate) else {
                return false
            }
            return date1 > date2
        }
    }
}
