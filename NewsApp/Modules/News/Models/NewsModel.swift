//
//  NewsModel.swift
//  NewsApp
//
//  Created by Darya Zhitova on 03.04.2024.
//

import Foundation

struct NewsModel: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Decodable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
}

struct Source: Decodable {
    let id: String?
    let name: String
}
