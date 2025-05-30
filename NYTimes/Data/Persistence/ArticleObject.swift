//
//  ArticleObject.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import RealmSwift
import Foundation

class ArticleObject: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String = ""
    @Persisted var abstract: String = ""
    @Persisted var publishedDate: String = ""
    @Persisted var url: String
    @Persisted var authors: String?
    @Persisted var thumbnailURL: String?
    
    convenience init(article: ArticleEntity) {
        self.init()
        self.id = article.id
        self.title = article.title
        self.abstract = article.abstract
        self.publishedDate = article.publishedDate
        self.url = article.url
        self.authors = article.authors
        self.thumbnailURL = article.thumbnailURL
    }
    
    func toDomain() -> ArticleEntity {
        ArticleEntity(id: id,
                title: title,
                abstract: abstract,
                url: url,
                authors: authors,
                publishedDate: publishedDate,
                thumbnailURL: thumbnailURL)
    }
}
