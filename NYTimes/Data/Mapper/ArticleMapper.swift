//
//  ArticleMapper.swift
//  NYTimes
//
//  Created by Abrar on 31/05/2025.
//

import Foundation

class ArticleMapper {
    func map(dto: ResultDTO) -> ArticleEntity {
        let thumbnail = dto.media?.first?.mediaMetadata?.first(where: { $0.format == .medium })?.url
        
        return ArticleEntity(
            id: dto.id ?? 0,
            title: dto.title ?? "",
            abstract: dto.abstract ?? "",
            url: dto.url ?? "",
            authors: dto.byline,
            publishedDate: dto.publishedDate?.formatDate() ?? "",
            thumbnailURL: thumbnail,
            savedDate: Date()
        )
    }
}
