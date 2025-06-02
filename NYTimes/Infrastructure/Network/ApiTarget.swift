//
//  ApiTarget.swift
//  NYTimes
//
//  Created by Abrar on 02/06/2025.
//

import Foundation

protocol ApiTarget {
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
    var urlComponents: URLComponents { get }
}
