//
//  StubGenerator.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import Foundation
@testable import NYTimes

class StubGenerator {
    func stubArticleNews() -> NYTimesDTO {
        guard let path = Bundle.main.path(forResource: "mostViewed", ofType: "json") else {
            fatalError("mostViewed.json not found in bundle.")
        }
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let articles = try! decoder.decode(NYTimesDTO.self, from: data)
        return articles
    }
}
