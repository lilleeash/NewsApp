//
//  NewsView.swift
//  NewsApp
//
//  Created by Darya Zhitova on 04.04.2024.
//

import UIKit

protocol DisplayNewsView: UIView {
    func configure(with model: [NewsViewModel])
    func showLoading()
    func showCollection(with model: [NewsViewModel])
    func showError(title: String, subtitle: String)
}

final class NewsView: UIView {
    
    weak var retryDelegate: NewsErrorViewDelegate?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: (width - 60) / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = collectionManager
        view.register(NewsCollectionCellView.self, forCellWithReuseIdentifier: NewsCollectionCellView.identifier)
        return view
    }()
    
    private lazy var errorView: DisplayNewsErrorView = {
        let view = NewsErrorView()
        view.retryDelegate = retryDelegate
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private let collectionManager = NewsCollectionManager()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func show(view: UIView) {
        subviews.forEach { $0.isHidden = ($0 != view) }
    }
}

// MARK: - DisplayNewsView
extension NewsView: DisplayNewsView {
    
    func showLoading() {
        show(view: activityIndicator)
    }
    
    func showCollection(with model: [NewsViewModel]) {
        show(view: collectionView)
        configure(with: model)
    }
    
    func showError(title: String, subtitle: String) {
        show(view: errorView)
        errorView.configure(title: title, subtitle: subtitle)
    }
    
    func configure(with model: [NewsViewModel]) {
        collectionManager.collectionData = model
        collectionView.reloadData()
    }
}

// MARK: - private
private extension NewsView {
    private func addSubviews() {
        [collectionView, errorView, activityIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            errorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
