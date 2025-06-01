//
//  ArticlesRealmManager.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import Foundation
import RealmSwift

class ArticlesRealmManager {
    func save(articles: [ArticleObject]) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.add(articles, update: .modified)
                    }
                } catch {
                    print("Failed to save to Realm:", error)
                }
            }
        }
    }
    
    func load() async -> [ArticleEntity] {
        await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                autoreleasepool {
                    do {
                        let realm = try Realm()
                        let result = realm.objects(ArticleObject.self)
                        let articles = result.map { ArticleObjectMapper().map(object: $0) }
                        continuation.resume(returning: Array(articles))
                    } catch {
                        print("Failed to load from Realm:", error)
                    }
                }
            }
        }
    }
    
    func clearAllCachedArticles(completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            autoreleasepool {
                do {
                    let realm = try Realm()
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
    }
}
