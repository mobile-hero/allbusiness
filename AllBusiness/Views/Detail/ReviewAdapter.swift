//
//  OpenHourAdapter.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 21/02/22.
//

import Foundation
import UIKit

class ReviewAdapter: NSObject, BLTableViewDelegate {
    
    var tableView: UITableView?
    var heightConstraint: NSLayoutConstraint?
    
    var source: [Review] = []
    
    convenience init(tableView: UITableView, heightConstraint: NSLayoutConstraint) {
        self.init()
        self.tableView = tableView
        self.heightConstraint = heightConstraint
        tableView.setup(delegate: self, estimatedRowHeight: 170)
        tableView.registerCell(ReviewCell.self)
        tableView.reloadData()
    }
    
    func reloadData() {
        tableView?.reloadData()
        tableView?.layoutSubviews()
        heightConstraint?.constant = tableView!.contentSize.height
        tableView?.setNeedsLayout()
        tableView?.layoutIfNeeded()
    }
    
    func setData(source: [Review]) {
        self.source = source
        reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReviewCell = tableView.reusableCell(for: indexPath)
        cell.bind(data: source[indexPath.row])
        return cell
    }
}
