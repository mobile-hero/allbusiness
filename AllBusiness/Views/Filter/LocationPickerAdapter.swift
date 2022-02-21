//
//  LocationPickerAdapter.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 10/02/22.
//

import Foundation
import UIKit

protocol LocationPickerAdapterDelegate: NSObjectProtocol {
    func locationPicker(didSelected address: String)
}

class LocationPickerAdapter: NSObject, BLTableViewDelegate {
    
    var tableView: UITableView?
    
    var source: [String] = []
    
    weak var delegate: LocationPickerAdapterDelegate?
    
    convenience init(tableView: UITableView) {
        self.init()
        self.tableView = tableView
        tableView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        tableView.setup(delegate: self, estimatedRowHeight: 40)
        tableView.registerCell(LocationPickerCell.self)
        tableView.reloadData()
    }
    
    func reloadData() {
        tableView?.reloadData()
    }
    
    func setData(source: [String]) {
        self.source = source
        reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.locationPicker(didSelected: source[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LocationPickerCell = tableView.reusableCell(for: indexPath)
        cell.bind(data: source[indexPath.row])
        return cell
    }
}
