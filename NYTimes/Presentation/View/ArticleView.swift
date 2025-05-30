//
//  ArticleView.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import SwiftUI

struct ArticleView: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 8) {
                image
                title
            }
            VStack(alignment: .leading) {
                description
                date
            }
        }
        .padding(.horizontal, 8)
    }
    
    private var image: some View {
        VStack {
            if let urlString = article.thumbnailURL, let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
    }
    
    private var title: some View {
        Text(article.title)
            .font(.headline)
    }
    
    private var description: some View {
        Text(article.authors ?? "")
            .font(.subheadline)
            .foregroundColor(.secondary)
            .frame(alignment: .leading)
    }
    
    private var date: some View {
        Text(article.publishedDate)
            .font(.caption)
            .foregroundColor(.secondary)
            .frame(alignment: .leading)
    }
}
