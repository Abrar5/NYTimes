//
//  ApiService.swift
//  NYTimes
//
//  Created by Abrar on 02/06/2025.
//

protocol ApiService {
    func request<T: Decodable>(_ endpoint: ApiTarget, responseType: T.Type) async throws -> T
}
