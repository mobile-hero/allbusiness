//
//  BusinessListViewController.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 19/02/22.
//

import Foundation
import UIKit

protocol BusinessListViewControllerDelegate: AnyObject {
    func businessListDidSelectItem(business: Business)
    func businessListDidTappedFilter(listViewModel: BusinessListViewModel)
}

class BusinessListViewController: ViewController, BusinessListAdapterDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var errorContainerView: UIView!
    var searchBar: UISearchBar!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindData()
    }
    
    private func setupView() {
        title = "All Businesses"
        view.backgroundColor = .background
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(filterButtonDidTapped))
        
        collectionView.backgroundColor = .background
        activityIndicator.color = .text
        activityIndicator.startAnimating()
        errorContainerView.isHidden = true
        messageLabel.textColor = .text
        
        retryButton.addClick(on: self, action: #selector(retryButtonDidTapped))
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search business or cuisine"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        
        collectionAdapter = BusinessListAdapter(collectionView: collectionView)
        collectionAdapter?.delegate = self
    }
    
    func bindData() {
        viewModel?.source.bind { source in
            if (source.isEmpty && self.viewModel?.firstLoad.value == false) {
                self.errorContainerView.isHidden = false
                self.messageLabel.text = "No result found"
                self.retryButton.isHidden = true
            } else {
                self.errorContainerView.isHidden = true
            }
            self.collectionAdapter?.setData(source: source)
        }
        
        viewModel?.firstLoad.bind { firstLoad in
            if (firstLoad) {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
        
        viewModel?.error.bind { error in
            if (error != nil && self.viewModel?.source.value.isEmpty == true) {
                self.errorContainerView.isHidden = false
                self.messageLabel.text = error?.message
                self.retryButton.isHidden = false
            } else {
                self.errorContainerView.isHidden = true
            }
        }
        
        viewModel?.requestLocation()
    }
    
    func businessAdapter(didSelected business: Business) {
        delegate?.businessListDidSelectItem(business: business)
    }
    
    func businessAdapterLoadMoreItems() {
        viewModel?.loadMoreBusiness()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel?.searchBusiness(keyword: searchController.searchBar.text!)
    }
    
    @objc func retryButtonDidTapped() {
        viewModel?.retryLoad()
    }
    
    @objc func filterButtonDidTapped() {
        guard let viewModel = viewModel else {
            return
        }

        delegate?.businessListDidTappedFilter(listViewModel: viewModel)
    }
}
