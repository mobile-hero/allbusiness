//
//  BusinessLocationPickerViewController.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 22/02/22.
//

import Foundation
import UIKit

protocol BusinessLocationPickerViewControllerDelegate: AnyObject {
    func locationPickerCurrentLocationSelected()
    func locationPickerNewLocationSelected(address: String)
}

class BusinessLocationPickerViewController: UIViewController, UISearchResultsUpdating, LocationPickerAdapterDelegate {
    
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var addressesTableView: UITableView!
    @IBOutlet weak var addressesErrorLabel: UILabel!
    @IBOutlet weak var addressesLoadingIndicator: UIActivityIndicatorView!
    
    var delegate: BusinessLocationPickerViewControllerDelegate?
    
    private var tableAdapter: LocationPickerAdapter?
    
    let locationPickerViewModel: BusinessLocationPickerViewModel
    
    init(locationPickerViewModel: BusinessLocationPickerViewModel) {
        self.locationPickerViewModel = locationPickerViewModel
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
    
    func setupView() {
        title = "Search Location"
        currentLocationButton.addClick(on: self, action: #selector(currentLocationButtonDidTapped))
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search location"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        
        addressesErrorLabel.isHidden = true
        addressesLoadingIndicator.hidesWhenStopped = true
        
        tableAdapter = LocationPickerAdapter(tableView: addressesTableView)
        tableAdapter?.delegate = self
    }
    
    func bindData() {
        locationPickerViewModel.isLoading.bind { value in
            if (value) {
                self.addressesLoadingIndicator.startAnimating()
            } else {
                self.addressesLoadingIndicator.stopAnimating()
            }
        }
        
        locationPickerViewModel.error.bind { value in
            self.addressesErrorLabel.isHidden = value == nil
            self.addressesErrorLabel.text = value?.message ?? ""
        }
        
        locationPickerViewModel.source.bind { value in
            self.addressesTableView.isHidden = false
            self.tableAdapter?.setData(source: value)
        }
        
        locationPickerViewModel.findLocations(keyword: "singapore")
    }
    
    @objc func currentLocationButtonDidTapped() {
        delegate?.locationPickerCurrentLocationSelected()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        locationPickerViewModel.findLocations(keyword: searchController.searchBar.text!)
    }
    
    func locationPicker(didSelected address: String) {
        delegate?.locationPickerNewLocationSelected(address: address)
    }
}
