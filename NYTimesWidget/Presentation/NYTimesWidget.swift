//
//  NYTimesWidget.swift
//  NYTimesWidget
//
//  Created by Abrar on 14/06/2025.
//

import WidgetKit
import SwiftUI

struct NYTimesWidget: Widget {
    let kind: String = "NYTimesWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: NYTimesWidgetProvider()) { entry in
            if let latestArticle = entry.latestArticle {
                NYTimesWidgetEntryView(latestArticle: latestArticle)
            } else if !entry.isDataLoaded {
                Text("The latest article is not yet available.")
            } else {
                Text("Loading the latest article...")
            }
        }
        .configurationDisplayName("Latest Article")
        .description("Shows the most recent article.")
        .supportedFamilies([.systemLarge])
    }
}
