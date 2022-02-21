//
//  PhotoAdapter.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 10/02/22.
//

import Foundation
import UIKit

class PhotoAdapter: NSObject, BLCollectionViewDelegate {
    
    var collectionView: UICollectionView?
    
    var source: [String] = []
    
    convenience init(collectionView: UICollectionView) {
        self.init()
        self.collectionView = collectionView
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.setup(delegate: self)
        collectionView.registerCell(PhotoCell.self)
        collectionView.reloadData()
    }
    
    func reloadData() {
        collectionView?.reloadData()
    }
    
    func setData(source: [String]) {
        self.source = source
        reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCell = collectionView.reusableCell(for: indexPath)
        cell.bind(source[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.size.height
        return CGSize(width: size, height: size)
    }
}
