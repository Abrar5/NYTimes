//
//  Articles.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import Foundation

public struct ArticleEntity: Identifiable {
    public let id: Int
    public let title: String
    public let abstract: String
    public let url: String
    public let authors: String?
    public let publishedDate: String
    public let thumbnailURL: String?
    public let savedDate: Date?
    
    public init(id: Int, title: String, abstract: String, url: String, authors: String? = nil, publishedDate: String, thumbnailURL: String? = nil, savedDate: Date? = nil) {
        self.id = id
        self.title = title
        self.abstract = abstract
        self.url = url
        self.authors = authors
        self.publishedDate = publishedDate
        self.thumbnailURL = thumbnailURL
        self.savedDate = savedDate
    }
    
}
