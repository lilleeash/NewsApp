//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by Darya Zhitova on 04.04.2024.
//

protocol PresentNews {
    func loadNews()
}

final class NewsPresenter: PresentNews {
    
    private enum ErrorMessage {
        static let title: String = "Cannot connect"
        static let subtite: String = "Something went wrong. Please try again."
    }
    
    private let provider: ProvidesNews
    weak var viewController: DisplayNewsViewController?
    
    init(provider: ProvidesNews = NewsDataProvider()) {
        self.provider = provider
    }
    
    func loadNews() {
        Task.detached(priority: .medium) {
            do {
                let responce = try await self.provider.fetchNews()
                
                let result = responce.articles.map {
                    NewsViewModel(title: $0.title, description: $0.description, url: $0.url, urlToImage: $0.urlToImage, content: $0.content)
                }
                
                await MainActor.run {
                    self.viewController?.display(with: .result(model: result))
                }
            } catch let error {
                await MainActor.run {
                    self.viewController?.display(with: .error(
                        title: ErrorMessage.title,
                        subtitle: ErrorMessage.subtite)
                    )
                }
            }
        }
    }
}
