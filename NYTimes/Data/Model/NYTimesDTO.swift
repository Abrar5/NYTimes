//
//  NYTimesDTO.swift
//  NYTimes
//
//  Created by Abrar on 29/05/2025.
//

import Foundation

// MARK: - NYTimesDTO
struct NYTimesDTO: Codable {
    let status: String?
    let copyright: String?
    let numResults: Int?
    let results: [ResultDTO]?

    enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case numResults = "num_results"
        case results
    }
}

// MARK: - Result
struct ResultDTO: Codable {
    let uri: String?
    let url: String?
    let id: Int?
    let assetID: Int?
    let source: Source?
    let publishedDate: String?
    let updated: String?
    let section: String?
    let subsection: String?
    let nytdsection: String?
    let adxKeywords: String?
    let byline: String?
    let type: ResultType?
    let title: String?
    let abstract: String?
    let desFacet: [String]?
    let orgFacet: [String]?
    let perFacet: [String]?
    let geoFacet: [String]?
    let media: [Media]?
    let etaID: Int?

    enum CodingKeys: String, CodingKey {
        case uri
        case url
        case id
        case assetID = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated
        case section
        case subsection
        case nytdsection
        case adxKeywords = "adx_keywords"
        case byline
        case type
        case title
        case abstract
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case etaID = "eta_id"
    }
}

// MARK: - Media
struct Media: Codable {
    let type: MediaType?
    let subtype: Subtype?
    let caption: String?
    let copyright: String?
    let approvedForSyndication: Int?
    let mediaMetadata: [MediaMetadatum]?

    enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}

// MARK: - MediaMetadatum
struct MediaMetadatum: Codable {
    let url: String?
    let format: Format?
    let height: Int?
    let width: Int?
}

enum Format: String, Codable {
    case medium = "mediumThreeByTwo210"
    case large = "mediumThreeByTwo440"
    case standard = "Standard Thumbnail"
}

enum Subtype: String, Codable {
    case photo = "photo"
}

enum MediaType: String, Codable {
    case image = "image"
}

enum Source: String, Codable {
    case newYorkTimes = "New York Times"
}

enum ResultType: String, Codable {
    case article = "Article"
}

extension ResultDTO {
    func toDomain() -> ArticleEntity {
        let thumbnail = media?.first?.mediaMetadata?.first(where: { $0.format == .medium })?.url
        
        return ArticleEntity(
            id: id ?? 0,
            title: title ?? "",
            abstract: abstract ?? "",
            url: url ?? "",
            authors: byline,
            publishedDate: publishedDate?.formatDate() ?? "",
            thumbnailURL: thumbnail
        )
    }
}
