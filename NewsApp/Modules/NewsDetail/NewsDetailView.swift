//
//  NewsDetailView.swift
//  NewsApp
//
//  Created by Darya Zhitova on 12.04.2024.
//

import UIKit

protocol NewsDetailViewDelegate: AnyObject {
    func didOpenInSafariButtonTapped()
}

final class NewsDetailView: UIView {
    
    weak var delegate: NewsDetailViewDelegate?
    
    lazy private var openInSafaryButton: UIButton = {
        let view = UIButton()
        view.setTitle("Open in Safari", for: .normal)
        view.setImage(UIImage(systemName: "safari.fill"), for: .normal)
        view.backgroundColor = .black
        view.addTarget(
            self,
            action: #selector(didOpenInSafariButtonTapped),
            for: .touchUpInside
        )
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setUpConstraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didOpenInSafariButtonTapped() {
        delegate?.didOpenInSafariButtonTapped()
    }
}

// MARK: - private
private extension NewsDetailView {
    private func addSubviews() {
        [openInSafaryButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            openInSafaryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            openInSafaryButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

