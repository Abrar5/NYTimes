//
//  Articles.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import Foundation

struct ArticleEntity: Identifiable {
    let id: Int
    let title: String
    let abstract: String
    let url: String
    let authors: String?
    let publishedDate: String
    let thumbnailURL: String?
    let savedDate: Date?
}
