//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by Abrar on 01/12/1446 AH.
//

import XCTest
@testable import NYTimes

final class NYTimesTests: XCTestCase {

    func getArticles() -> NYTimesDTO {
        StubGenerator().stubArticleNews()
    }
    
    func testNYTimesNewsToArticleEntity() {
        let expect = XCTestExpectation(description: "Map from DTO to Entity")
        
        let results = StubGenerator().stubArticleNews().results ?? []
        XCTAssertNotNil(results)

        let articles = results.map{ $0.toDomain()}
        XCTAssertNotNil(articles)
        
        XCTAssertEqual(articles.count, results.count)
        expect.fulfill()
    }
}
