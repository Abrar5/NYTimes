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
    
    static let baseURL = "https://api.nytimes.com/svc/"
    static let apiKey = "tkM1UwG9jpmiA46iMay9LjG2nEwTXlPB"
}
