//
//  NYTimesWidgetProvider.swift
//  NYTimes
//
//  Created by Abrar on 14/06/2025.
//

import WidgetKit

struct NYTimesWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> LatestArticleEntry {
        LatestArticleEntry(date: Date(), latestArticle: nil, isDataLoaded: false)
    }
    
    func getSnapshot(in context: Context, completion: @escaping @Sendable (LatestArticleEntry) -> Void) {
        let article = ArticlesRealmManager().getLatestArticle()
        let entry = LatestArticleEntry(date: Date(), latestArticle: article, isDataLoaded: true)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<LatestArticleEntry>) -> Void) {
        let article = ArticlesRealmManager().getLatestArticle()
        let entry = LatestArticleEntry(date: Date(), latestArticle: article, isDataLoaded: true)
        let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(3600)))
        completion(timeline)
    }
}
