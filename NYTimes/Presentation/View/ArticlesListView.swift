//
//  ArticlesListView.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import SwiftUI

struct ArticleListView: View {
    @StateObject private var viewModel = ArticlesListViewModel()

    var body: some View {
        NavigationView {
            Group {
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else if viewModel.articles.isEmpty {
                    ProgressView("Loading articles...")
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    List(viewModel.articles, id: \.id) { article in
                        NavigationLink(destination: ArticleDetailsView(article: article)) {
                            ArticleView(article: article)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("NY Times Most Popular Articles")
            .onAppear {
                viewModel.fetchArticles()
            }
        }
    }
}
