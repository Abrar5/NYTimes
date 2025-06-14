//
//  NYTimesWidgetEntryView.swift
//  NYTimes
//
//  Created by Abrar on 14/06/2025.
//

import SwiftUI

struct NYTimesWidgetEntryView: View {
    var entry: NYTimesWidgetProvider.Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(entry.latestArticle?.title ?? "")
                .font(.title)
            Divider()
                .frame(height: 1)
                .background(Color.gray.opacity(0.1))
            Text(entry.latestArticle?.abstract ?? "")
            Spacer()
        }
        .padding()
    }
}
