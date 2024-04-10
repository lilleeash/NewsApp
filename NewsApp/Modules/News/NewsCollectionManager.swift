//
//  NewsCollectionManager.swift
//  NewsApp
//
//  Created by Darya Zhitova on 10.04.2024.
//

import UIKit

final class NewsCollectionManager: NSObject {
    var collectionData: [NewsViewModel] = []
}

extension NewsCollectionManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model: NewsViewModel = collectionData[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NewsCollectionCellView.identifier,
            for: indexPath
        ) as? NewsCollectionCellView else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: model)
        
        return cell
    }
}
