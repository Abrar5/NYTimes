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
    
    func load() async -> [ArticleEntity] {
        await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .background).async {
                do {
                    let realm = try Realm()
                    let result = realm.objects(ArticleObject.self)
                    let articles = result.map { $0.toDomain() }
                    continuation.resume(returning: Array(articles))
                } catch {
                    print("Failed to load from Realm:", error)
                }
            }
        }
    }
}
