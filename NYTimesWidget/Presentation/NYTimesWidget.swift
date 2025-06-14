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
            NYTimesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Latest Article")
        .description("Shows the most recent article.")
        .supportedFamilies([.systemLarge])
    }
}
