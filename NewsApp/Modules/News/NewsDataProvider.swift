//
//  NewsDataProvider.swift
//  NewsApp
//
//  Created by Darya Zhitova on 03.04.2024.
//

import Foundation

protocol ProvidesNews {
    func fetchNews() async throws -> NewsModel
}

final class NewsDataProvider: ProvidesNews {
    
    private let service: any Networkable<NewsModel>
    
    init(service: any Networkable<NewsModel> = NewsService()) {
        self.service = service
    }
    
    func fetchNews() async throws -> NewsModel {
        try await service.fetch(
            with: NewsEndpoints.everything,
            queryParams: [
                URLQueryItem(name: "q", value: "bitcoin"),
                URLQueryItem(name: "apiKey", value: NetworkSource.apiKey)
            ]
        )
    }
}
