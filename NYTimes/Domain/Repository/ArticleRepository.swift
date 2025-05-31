//
//  ArticleRepository.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import Foundation

protocol ArticleRepository {
    func fetchMostViewedArticles(period: Int) async throws -> [ArticleEntity]
}
