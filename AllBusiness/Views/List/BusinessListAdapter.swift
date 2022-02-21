//
//  BusinessListAdapter.swift
//  BusinessLibrary
//
//  Created by Muhammad Ikhsan on 10/02/22.
//

import Foundation
import UIKit

protocol BusinessListAdapterDelegate: NSObjectProtocol {
    func businessAdapter(didSelected business: Business)
    func businessAdapterLoadMoreItems()
}

class BusinessListAdapter: NSObject, BLCollectionViewDelegate {
    
    var collectionView: UICollectionView?
    
    var source: [Business] = []
    
    weak var delegate: BusinessListAdapterDelegate?
    
    convenience init(collectionView: UICollectionView) {
        self.init()
        self.collectionView = collectionView
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        collectionView.setup(delegate: self)
        collectionView.registerCell(BusinessListCell.self)
        collectionView.reloadData()
    }
    
    func reloadData() {
        collectionView?.reloadData()
    }
    
    func setData(source: [Business]) {
        self.source = source
        reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.businessAdapter(didSelected: source[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BusinessListCell = collectionView.reusableCell(for: indexPath)
        cell.bind(source[indexPath.row].imageUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width - 24
        return CGSize(
            width: width / 2,
            height: width * (2 / 3)
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == source.count - 3) {
            self.delegate?.businessAdapterLoadMoreItems()
        }
    }
}
