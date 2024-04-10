//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Darya Zhitova on 03.04.2024.
//

import UIKit

protocol DisplayNewsViewController: AnyObject {
    func display(with model: [NewsViewModel])
}

final class NewsViewController: UIViewController {
    
    private lazy var contentView: DisplayNewsView = {
        let view = NewsView()
        return view
    }()
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.loadNews()
    }
    
}

// MARK: - DisplayNewsViewController
extension NewsViewController: DisplayNewsViewController {
    func display(with model: [NewsViewModel]) {
        contentView.configure(with: model)
    }
}

