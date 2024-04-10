//
//  NewsCollectionCellView.swift
//  NewsApp
//
//  Created by Darya Zhitova on 10.04.2024.
//

import UIKit
import Kingfisher

final class NewsCollectionCellView: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with model: NewsViewModel) {
        imageView.kf.setImage(with: URL(string: model.urlToImage ?? ""))
    }
}

private extension NewsCollectionCellView {
    private func addSubviews() {
        [imageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}
