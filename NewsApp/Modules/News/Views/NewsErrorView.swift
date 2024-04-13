//
//  NewsErrorView.swift
//  NewsApp
//
//  Created by Darya Zhitova on 04.04.2024.
//

import UIKit

protocol DisplayNewsErrorView: UIView {
    func configure(title: String, subtitle: String)
}

protocol NewsErrorViewDelegate: AnyObject {
    func didRetryButtonTapped()
}

final class NewsErrorView: UIView {
    
    weak var retryDelegate: NewsErrorViewDelegate?
    
    private lazy var title: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 22, weight: .semibold)
        return view
    }()
    
    private lazy var subtitle: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .gray
        return view
    }()
    
    private lazy var retryButton: UIButton = {
        let view = UIButton(configuration: .borderedTinted())
        view.tintColor = .black
        view.layer.cornerRadius = 10
        view.setTitle("Retry", for: .normal)
        view.setImage(UIImage(systemName: "arrow.circlepath"), for: .normal)
        view.addTarget(
            self,
            action: #selector(didRetryButtonTapped),
            for: .touchUpInside
        )
        return view
    }()
    
    private lazy var textStack: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.spacing = 8
        view.axis = .vertical
        return view
    }()
    
    private lazy var mainStack: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.spacing = 32
        view.axis = .vertical
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func didRetryButtonTapped() {
        retryDelegate?.didRetryButtonTapped()
    }
}

extension NewsErrorView: DisplayNewsErrorView {
    func configure(title: String, subtitle: String) {
        self.title.text = title
        self.subtitle.text = subtitle
    }
}

private extension NewsErrorView {
    
    private func addSubviews() {
        [title, subtitle].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            textStack.addArrangedSubview($0)
        }
        
        [textStack, retryButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            mainStack.addArrangedSubview($0)
        }
        
        [mainStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            mainStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    
        NSLayoutConstraint.activate([
            retryButton.widthAnchor.constraint(equalToConstant: 150),
            retryButton.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
}
