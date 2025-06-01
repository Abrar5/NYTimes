//
//  ArticleObjectMapper.swift
//  NYTimes
//
//  Created by Abrar on 31/05/2025.
//

import Foundation

class ArticleObjectMapper {
    func map(object: ArticleObject) -> ArticleEntity {
        return ArticleEntity(
            id: object.id,
            title: object.title,
            abstract: object.abstract,
            url: object.url,
            authors: object.authors,
            publishedDate: object.publishedDate.formatDate(),
            thumbnailURL: object.thumbnailURL,
            savedDate: object.savedDate
        )
    }
}
