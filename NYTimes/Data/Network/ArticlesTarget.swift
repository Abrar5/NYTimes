//
//  ArticlesTarget.swift
//  NYTimes
//
//  Created by Abrar on 31/05/2025.
//

import Foundation

enum ArticlesTarget {
    case getMostViewedArticles(days: Int)
    
    var path: String {
        switch self {
        case .getMostViewedArticles(let days):
            return "mostpopular/v2/viewed/\(days).json"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var baseURL: String {
        "https://api.nytimes.com/svc/"
    }
    
    private var apiKey: String {
        "tkM1UwG9jpmiA46iMay9LjG2nEwTXlPB"
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents()
        components.path = self.path
        components.queryItems = [
            URLQueryItem(name: "api-key", value: apiKey)
        ]
        return components
    }
    
    var url: URL {
        guard let finalURL = urlComponents.url else {
            fatalError("Invalid URL for endpoint: \(self)")
        }
        return finalURL
    }
}
