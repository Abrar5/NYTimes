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
    @Published var selectedNumber: Int = 7
    @Published var numberOptions: [Int] = [1, 7, 30]
    var shouldClearCache: Bool = false
    private var speechSynthesizer = AVSpeechSynthesizer()
    private var currentUtterance: AVSpeechUtterance?
    
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

// MARK: - Picker Title
extension ArticlesListViewModel {
    func getPickerTitle() -> String {
        return "Select Number of Days:"
    }
}

// MARK: - Reading Text
extension ArticlesListViewModel {
    func readText(_ text: String) {
        if speechSynthesizer.isPaused {
            resumeSpeaking()
            return
        }
        
        if speechSynthesizer.isSpeaking {
            stopSpeaking()
            return
        }
        
        startSpeaking(text)
    }
    
    private func startSpeaking(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        currentUtterance = utterance
        
        speechSynthesizer.speak(utterance)
        print("Speech started.")
    }
    
    private func stopSpeaking() {
        speechSynthesizer.pauseSpeaking(at: .word)
        print("Speech paused.")
    }
    
    private func resumeSpeaking() {
        speechSynthesizer.continueSpeaking()
        print("Speech continued.")
    }
}
