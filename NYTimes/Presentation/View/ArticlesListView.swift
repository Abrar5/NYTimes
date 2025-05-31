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
                if viewModel.errorMessage != nil {
                    errorView
                } else if viewModel.articles.isEmpty {
                    progressView
                } else {
                    articlesList
                }
            }
            .padding(.horizontal, 8)
            .navigationTitle("Most Viewed Articles")
            .onAppear {
                viewModel.fetchArticles(period: $viewModel.selectedNumber.wrappedValue)
            }
        }
        .onChange(of: viewModel.selectedNumber) { _, newValue in
            viewModel.shouldClearCache = true
            viewModel.fetchArticles(period: newValue)
        }
    }
    
    private var errorView: some View {
        VStack {
            if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    private var progressView: some View {
        ProgressView("Loading Articles...")
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
    }
    
    private var articlesList: some View {
        VStack(spacing: 8) {
            PickerView(selectedValue: $viewModel.selectedNumber, numberOptions: viewModel.numberOptions)
                .padding(.horizontal)
            
            List(viewModel.articles, id: \.id) { article in
                NavigationLink(destination: ArticleDetailsView(article: article).environmentObject(viewModel)) {
                    ArticleView(article: article)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}
