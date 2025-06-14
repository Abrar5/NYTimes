//
//  LatestArticleEntry.swift
//  NYTimes
//
//  Created by Abrar on 14/06/2025.
//

import WidgetKit

struct LatestArticleEntry: TimelineEntry {
    let date: Date
    let latestArticle: ArticleEntity?
    let isDataLoaded: Bool
}
