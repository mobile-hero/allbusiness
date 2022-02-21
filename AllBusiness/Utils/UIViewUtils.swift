//
//  UIView.swift
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

typealias BLTableViewDelegate = UITableViewDelegate & UITableViewDataSource

extension UITableView {
    func setup(delegate: BLTableViewDelegate, estimatedRowHeight: CGFloat) {
        self.delegate = delegate
        self.dataSource = delegate
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = estimatedRowHeight
    }
    
    func setup(delegate: BLTableViewDelegate, rowHeight: CGFloat) {
        self.delegate = delegate
        self.dataSource = delegate
        self.rowHeight = rowHeight
    }
    
    func registerCellClass(_ cell: UITableViewCell.Type) {
        self.register(cell, forCellReuseIdentifier: cell.className)
    }
    
    func registerCell(_ cell: UITableViewCell.Type) {
        self.register(cell.NIB, forCellReuseIdentifier: cell.className)
    }
    
    func registerCells(_ cells: [UITableViewCell.Type]) {
        cells.forEach({ registerCell($0) })
    }
    
    func registerHeaderFooter(_ view: UITableViewHeaderFooterView.Type) {
        self.register(view.NIB, forHeaderFooterViewReuseIdentifier: view.className)
    }
    
    func reusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.className, for: indexPath) as! T
    }
    
    func reusableCell<T: UITableViewCell>() -> T {
        return dequeueReusableCell(withIdentifier: T.className) as! T
    }
    
    func reusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: T.className) as! T
    }
}

extension UITableViewCell {
    static var NIB: UINib {
        return UINib.init(nibName: self.className, bundle: Bundle.main)
    }
}

extension UITableViewHeaderFooterView {
    static var NIB: UINib {
        return UINib.init(nibName: self.className, bundle: Bundle.main)
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
