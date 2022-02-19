//
//  UIView.swift
//  Altic
//
//  Created by Nanang Rafsanjani on 7/27/17.
//

import UIKit

extension UIView {
    static var className: String {
        return String(describing: self)
    }
}

extension UIButton {
    func addClick(on observer: Any, action: Selector) {
        addTarget(observer, action: action, for: .touchUpInside)
    }
    
    func removeClick(on observer: Any, action: Selector) {
        removeTarget(observer, action: action, for: .touchUpInside)
    }
}

extension UIView {
    @discardableResult
    func enableTap(on: Any, with selector: Selector) -> UITapGestureRecognizer {
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: on, action: selector)
        addGestureRecognizer(tapGesture)
        return tapGesture
    }
    
    func disableTap(gesture: UITapGestureRecognizer) {
        removeGestureRecognizer(gesture)
    }
}

typealias BLCollectionViewDelegate = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

extension UICollectionReusableView {
    static var NIB: UINib {
        return UINib.init(nibName: self.className, bundle: Bundle.main)
    }
}

extension UICollectionView {
    func setup(delegate: BLCollectionViewDelegate) {
        self.delegate = delegate
        self.dataSource = delegate
    }
    
    func registerCell(_ cell: UICollectionViewCell.Type) {
        self.register(cell.NIB, forCellWithReuseIdentifier: cell.className)
    }
    
    func reusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as! T
    }
}
