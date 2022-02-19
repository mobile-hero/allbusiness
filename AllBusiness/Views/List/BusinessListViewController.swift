//
//  BusinessListViewController.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 19/02/22.
//

import Foundation

protocol BusinessListViewControllerDelegate: AnyObject {
    func businessListDidSelectItem(business: Business)
}

class BusinessListViewController: ViewController {
    
    weak var delegate: BusinessListViewControllerDelegate?
    
    private var collectionAdapter: BusinessListAdapter?
//    private var searchBarAdapter: BusinessSearchAdapter?
    
    var viewModel: BusinessListViewModel?
    
    init(viewModel: BusinessListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
