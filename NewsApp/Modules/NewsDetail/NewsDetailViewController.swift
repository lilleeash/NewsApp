//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Darya Zhitova on 12.04.2024.
//

import UIKit
import WebKit

final class NewsDetailViewController: UIViewController {
    
    let news: NewsViewModel
    
    private lazy var contentView: NewsDetailView = NewsDetailView()
    
    private lazy var wkView: WKWebView = WKWebView()
    
    private var myRequest: URLRequest?
    
    init(news: NewsViewModel) {
        self.news = news
        myRequest = URLRequest(url: URL(string: news.url)!)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        wkView.uiDelegate = self
    }
}

extension NewsDetailViewController: NewsDetailViewDelegate {
    func didOpenInSafariButtonTapped() {
        view = wkView
        guard let myRequest else { return }
        wkView.load(myRequest)
    }
}

extension NewsDetailViewController: WKUIDelegate {}
