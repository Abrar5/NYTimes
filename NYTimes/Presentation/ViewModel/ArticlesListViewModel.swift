//
//  ArticlesListViewModel.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import Foundation
import AVFAudio

class ArticlesListViewModel: ObservableObject {
    @Published var articles: [ArticleEntity] = []
    @Published var errorMessage: String?
    @Published var selectedNumber: Int = 7 {
        didSet {
            savePeriod(selectedNumber)
        }
    }
    
    @Published var numberOptions: [Int] = [1, 7, 30]
    var shouldClearCache: Bool = false
    
    init() {
        selectedNumber = UserDefaults.standard.object(forKey: "selectedPeriod") as? Int ?? 7
    }
    
    @MainActor
    private func getArticles(period: Int = 7) {
        Task {
            do {
                let fetchUseCase = FetchMostPopularArticlesUseCase(repository: ArticleRepositoryImplementation())
                let articlesList = try await fetchUseCase.execute(period: period)
                self.articles = getSortArticlesByDate(articlesList)
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    @MainActor
    func fetchArticles(period: Int = 7) {
        if shouldClearCache {
            ArticlesRealmManager().clearAllCachedArticles() {
                self.shouldClearCache = false
                self.getArticles(period: period)
                return
            }
        } else {
            getArticles(period: period)
            return
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

// MARK: - Picker
extension ArticlesListViewModel {
    func getPickerTitle() -> String {
        return "Select Number of Days:"
    }
    
    private func savePeriod(_ value: Int) {
        UserDefaults.standard.set(value, forKey: "selectedPeriod")
    }
}
