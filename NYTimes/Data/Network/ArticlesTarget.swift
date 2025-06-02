//
//  ArticlesTarget.swift
//  NYTimes
//
//  Created by Abrar on 31/05/2025.
//

import Foundation

enum ArticlesTarget: ApiTarget {
    case getMostViewedArticles(days: Int)
    
    var path: String {
        switch self {
        case .getMostViewedArticles(let days):
            return "mostpopular/v2/viewed/\(days).json"
        }
    }
    
    var method: String {
        switch self {
        case .getMostViewedArticles:
            return "GET"
        }
    }
    
    var baseURL: String {
        switch self {
        case .getMostViewedArticles:
            return "https://api.nytimes.com/svc/"
        }
    }
    
    private var apiKey: String {
        switch self {
        case .getMostViewedArticles:
            return "tkM1UwG9jpmiA46iMay9LjG2nEwTXlPB"
        }
    }
    
    var urlComponents: URLComponents {
        switch self {
        case .getMostViewedArticles:
            var components = URLComponents()
            components.path = self.path
            components.queryItems = [
                URLQueryItem(name: "api-key", value: apiKey)
            ]
            return components
        }
    }
    
    var url: URL {
        switch self {
        case .getMostViewedArticles:
            guard let finalURL = urlComponents.url else {
                fatalError("Invalid URL for endpoint: \(self)")
            }
            return finalURL
        }
    }
}
