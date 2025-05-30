//
//  ArticleRepository.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import Foundation

protocol ArticleRepository {
    func fetchMostPopularArticles(period: Int) async throws -> [ArticleEntity]
}
