//
//  NewsViewControllerState.swift
//  NewsApp
//
//  Created by Darya Zhitova on 12.04.2024.
//

enum NewsViewControllerState {
    case loading
    case result(model: [NewsViewModel])
    case error(title: String, subtitle: String)
}
