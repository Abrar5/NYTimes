//
//  ArticlesDetailsView.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import SwiftUI

struct ArticleDetailsView: View {
    private var article: ArticleEntity
    @EnvironmentObject private var viewModel: ArticlesListViewModel
    let speechToText = TextToSpeechUseCase()
    
    init(article: ArticleEntity) {
        self.article = article
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                title
                authors
                date
                Divider()
                Image(systemName: "speaker")
                    .onTapGesture {
                        speechToText.readText(article.abstract)
                    }
                description
                readFullArticle
            }
            .padding()
        }
        .navigationTitle(article.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var title: some View {
        Text(article.title)
            .font(.title)
            .bold()
    }
    
    private var authors: some View {
        Text(article.authors ?? "")
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
    
    private var date: some View {
        Text(article.publishedDate)
            .font(.caption)
            .foregroundColor(.secondary)
    }
    
    private var description: some View {
        Text(article.abstract)
            .font(.body)
    }
    
    private var image: some View {
        VStack {
            if let urlString = article.thumbnailURL, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
    
    private var readFullArticle: some View {
        Link("Read Full Article", destination: URL(string: article.url)!)
            .font(.headline)
            .foregroundColor(.blue)
            .padding(.top)
    }
}
