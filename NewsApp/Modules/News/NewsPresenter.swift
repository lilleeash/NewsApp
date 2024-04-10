//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by Darya Zhitova on 04.04.2024.
//

protocol PresentNews {
    func loadNews() -> [NewsViewModel]
}

final class NewsPresenter: PresentNews {
    
    private let provider: ProvidesNews
    
    init(provider: ProvidesNews = NewsDataProvider()) {
        self.provider = provider
    }
    
    func loadNews() -> [NewsViewModel] {
        Task {
            let responce = try await provider.fetchNews()
            
            var result = responce.articles.map {
                NewsViewModel(title: $0.title, description: $0.description, url: $0.url, urlToImage: $0.urlToImage, content: $0.content)
            }
            
            return result
        }
    }
}
