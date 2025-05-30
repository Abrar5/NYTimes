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
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    errorView
                } else if viewModel.articles.isEmpty {
                    progressView
                } else {
                    articlesList
                }
            }
            .navigationTitle("NY Times Most Popular Articles")
            .onAppear {
                viewModel.fetchArticles(period: viewModel.selectedNumber)
            }
        }
    }
    
    var errorView: some View {
        VStack {
            if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
    
    var progressView: some View {
        ProgressView("Loading articles...")
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .padding()
    }
    
    var articlesList: some View {
        VStack {
            List(viewModel.articles, id: \.id) { article in
                NavigationLink(destination: ArticleDetailsView(article: article)) {
                    ArticleView(article: article)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}
