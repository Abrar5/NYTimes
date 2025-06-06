//
//  FetchMostPopularArticlesUseCaseTest.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import XCTest
@testable import NYTimes

final class FetchMostPopularArticlesUseCaseTest: XCTestCase {
    var sut: FetchMostPopularArticlesUseCase!
    
    override func setUp() {
        super.setUp()
        sut = FetchMostPopularArticlesUseCase(repository: ArticleRepositoryImplementation())
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testFetchArticles_success() async {
        let expect = XCTestExpectation(description: "Fetch Most Popular Articles Use Case_success")
        do {
            let result = try await sut.execute()
            XCTAssertNotNil(result)
        } catch {
            XCTFail("Failed to fetch most popular articles")
            XCTAssertNotNil(error.localizedDescription)
        }
        expect.fulfill()
    }
    
    func testFetchArticles_fail() async {
        let expect = XCTestExpectation(description: "Fetch Most Popular Articles Use Case_fail")
        do {
            let result = try await sut.execute(period: 0)
            print(result)
            XCTAssertNotNil(result)
        } catch {
            XCTAssertNotNil(error.localizedDescription)
        }
        expect.fulfill()
    }
}
