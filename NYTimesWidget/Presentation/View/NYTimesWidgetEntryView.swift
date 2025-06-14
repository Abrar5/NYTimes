//
//  NYTimesWidgetEntryView.swift
//  NYTimes
//
//  Created by Abrar on 14/06/2025.
//

import SwiftUI

struct NYTimesWidgetEntryView: View {
    var latestArticle: ArticleEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(latestArticle.title)
                .font(.title)
            Divider()
                .frame(height: 1)
                .background(Color.gray.opacity(0.1))
            Text(latestArticle.abstract)
            Spacer()
        }
        .padding()
    }
}
