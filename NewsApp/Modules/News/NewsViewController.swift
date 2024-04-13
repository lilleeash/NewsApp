//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Darya Zhitova on 03.04.2024.
//

import UIKit

protocol DisplayNewsViewController: AnyObject {
    func display(with state: NewsViewControllerState)
}

final class NewsViewController: UIViewController {
    
    private lazy var contentView: DisplayNewsView = {
        let view = NewsView()
        view.retryDelegate = self
        return view
    }()
    
    private var state: NewsViewControllerState = .error(title: "Title", subtitle: "Subtitle")
    
    private let presenter: PresentNews?
    
    init(presenter: PresentNews?) {
        self.presenter = presenter
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
        view.backgroundColor = .white
        navigationItem.title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        display(with: state)
    }
}

// MARK: - DisplayNewsViewController
extension NewsViewController: DisplayNewsViewController {
    func display(with state: NewsViewControllerState) {
        switch state {
        case .loading:
            contentView.showLoading()
            presenter?.loadNews()
        case .result(let model):
            contentView.showCollection(with: model)
        case .error(let title, let subtitle):
            contentView.showError(title: title, subtitle: subtitle)
        }
    }
}

extension NewsViewController: NewsErrorViewDelegate {
    func didRetryButtonTapped() {
        display(with: .loading)
    }
}
