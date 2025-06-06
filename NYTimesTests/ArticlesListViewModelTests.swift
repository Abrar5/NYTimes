//
//  ArticlesListViewModelTests.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import XCTest
@testable import NYTimes

final class ArticlesListViewModelTests: XCTestCase {
    var sut: ArticlesListViewModel!
    var articles: [ArticleEntity] = []
    
    override func setUp() {
        super.setUp()
        sut = ArticlesListViewModel()
        let results = StubGenerator().stubArticleNews().results ?? []
        articles = results.map { ArticleMapper().map(dto: $0) }
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    @MainActor func testFetchArticles() {
        let expect = XCTestExpectation(description: "Fetch Atrticles Successfully")
        let result: () = sut.fetchArticles()
        XCTAssertNotNil(result)
        expect.fulfill()
    }
    
    @MainActor func testFetchArticles_fail() {
        let expect = XCTestExpectation(description: "Fetch Atrticles_Failure")
        let result: () = sut.fetchArticles(period: 2)
        XCTAssertNotNil(result)
        expect.fulfill()
    }
    
    func testGetSortArticlesByDate() {
        let expect = XCTestExpectation(description: "Get Sorted Articles By Date")
        let result = sut.getSortArticlesByDate(articles)
        
        guard let firstRecoed = result.first?.publishedDate else {
            return
        }
        
        guard let secondRecoed = result.last?.publishedDate else {
            return
        }
        
        XCTAssertGreaterThanOrEqual(firstRecoed, secondRecoed)
        expect.fulfill()
    }
    
}
