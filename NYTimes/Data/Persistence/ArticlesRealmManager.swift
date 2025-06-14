//
//  ArticlesRealmManager.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import Foundation
import RealmSwift
import WidgetKit

class ArticlesRealmManager {
    func save(articles: [ArticleObject]) {
        do {
            let config = self.realmConfigurationForAppGroup()
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(articles, update: .modified)
            }
            self.reloadWidgetTimelines()
        } catch {
            print("Failed to save to Realm:", error)
        }
    }
    
    func load() -> [ArticleEntity] {
        do {
            let config = self.realmConfigurationForAppGroup()
            let realm = try Realm(configuration: config)
            let result = realm.objects(ArticleObject.self)
            let articles = result.map { ArticleObjectMapper().map(object: $0) }
            self.reloadWidgetTimelines()
            return Array(articles)
        } catch {
            print("Failed to load from Realm:", error)
            return []
        }
    }
    
    func getLatestArticle() -> ArticleEntity? {
        do {
            let config = self.realmConfigurationForAppGroup()
            let realm = try Realm(configuration: config)
            let result = realm.objects(ArticleObject.self)
            let articles = result.map { ArticleObjectMapper().map(object: $0) }
            let sortedArticles = self.getSortArticlesByDate(Array(articles))
            return sortedArticles.first
        } catch {
            print("Failed to load from Realm:", error)
            return nil
        }
    }
    
    func clearAllCachedArticles(completion: @escaping () -> Void) {
        do {
            let config = self.realmConfigurationForAppGroup()
            let realm = try Realm(configuration: config)
            let allArticles = realm.objects(ArticleObject.self)
            try realm.write {
                realm.delete(allArticles)
            }
        } catch {
            print("Failed to clear all cached articles from Realm:", error)
        }
        
        DispatchQueue.main.async {
            completion()
        }
    }
}

extension ArticlesRealmManager {
    private func getSortArticlesByDate(_ articles: [ArticleEntity]) -> [ArticleEntity] {
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
    
    private func reloadWidgetTimelines() {
        WidgetCenter.shared.reloadTimelines(ofKind: "NYTimesWidget")
    }
    
    private func realmConfigurationForAppGroup() -> Realm.Configuration {
        let appGroupID = "group.com.NYTimes.NYTimes"
        
        guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupID) else {
            fatalError("Failed to find container for app group: \(appGroupID).")
        }
        
        let realmURL = containerURL.appendingPathComponent("articles.realm")
        var config = Realm.Configuration(fileURL: realmURL)
        
        // Widgets must not write to Realm, only read
        if Bundle.main.bundlePath.hasSuffix(".appex") {
            config.readOnly = true
        }
        
        return config
    }
}
