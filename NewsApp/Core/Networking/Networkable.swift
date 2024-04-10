//
//  Networkable.swift
//  NewsApp
//
//  Created by Darya Zhitova on 04.04.2024.
//

import Foundation

protocol Networkable<Responce> {
    associatedtype Responce: Decodable
    func fetch(with endpoint: String, queryParams: [URLQueryItem]?) async throws -> Responce
}

extension Networkable {
    
    func fetch(with endpoint: String, queryParams: [URLQueryItem]?) async throws -> Responce {
        
        guard let url = try? generateUrl(with: endpoint, queryParams: queryParams) else {
            throw URLError(.badURL)
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = NetworkSource.APIMethod.get
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            throw URLError(URLError.Code(rawValue: httpResponse.statusCode))
        }
        
        let fetchedNews = try JSONDecoder().decode(Responce.self, from: data)
        
        return fetchedNews
    }
}

// MARK: private

private extension Networkable {
    private func generateUrl(with endpoint: String, queryParams: [URLQueryItem]?) throws -> URL {
        guard var urlComponents = URLComponents(string: NetworkSource.APIEnviroment.prod) else {
            throw URLError(.badURL)
        }
        
        urlComponents.queryItems = queryParams
        urlComponents.path = "\(endpoint)"
        
        guard let finalURL = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        return finalURL
    }
}
