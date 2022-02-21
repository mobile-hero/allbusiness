//
//  BusinessListCoordinator.swift
//
//  Created by Muhammad Ikhsan on 11/02/22.
//

import Foundation
import UIKit
import CoreLocation

class BusinessListCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private var listController: BusinessListViewController?
    private var filterController: BusinessFilterViewController?
    private var locationPickerController: BusinessLocationPickerViewController?
    
    private var detailCoordinator: BusinessDetailCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let yelpServices = YelpFusionServices(session: CustomSessionManager.default,
                                              plugins: defaultPlugins,
                                              decoder: jsonDecoder)
        let locationServices = LocationServicesImpl(locationManager: CLLocationManager())
        let viewModel = BusinessListViewModelImpl(yelpServices: yelpServices, locationServices: locationServices)
        let listController = BusinessListViewController(viewModel: viewModel)
        listController.delegate = self
        navigationController.pushViewController(listController, animated: true)
        self.listController = listController
    }
}

extension BusinessListCoordinator: BusinessListViewControllerDelegate {
    func businessListDidTappedFilter(listViewModel: BusinessListViewModel) {
        let filterController = BusinessFilterViewController(businessListViewModel: listViewModel)
        filterController.delegate = self
        navigationController.present(UINavigationController(rootViewController: filterController), animated: true, completion: nil)
        self.filterController = filterController
    }
    
    func businessListDidSelectItem(business: Business) {
        detailCoordinator = BusinessDetailCoordinator(navigationController: navigationController, business: business)
        detailCoordinator?.start()
    }
}

extension BusinessListCoordinator: BusinessFilterViewControllerDelegate {
    func businessFilterDidClosed() {
        if (listController?.viewModel?.location.isEmpty == true) {
            listController?.viewModel?.requestLocation()
        } else {
            listController?.viewModel?.loadBusiness()
        }
    }
    
    func businessFilterSelectLocation() {
        let searchServices = LocationSearchServicesImpl()
        let pickerViewModel = BusinessLocationPickerViewModelImpl(locationSearchServices: searchServices)
        let locationPickerController = BusinessLocationPickerViewController(locationPickerViewModel: pickerViewModel)
        locationPickerController.delegate = self
        filterController?.navigationController?.pushViewController(locationPickerController, animated: true)
        self.locationPickerController = locationPickerController
    }
}

extension BusinessListCoordinator: BusinessLocationPickerViewControllerDelegate {
    func locationPickerCurrentLocationSelected() {
        locationPickerController?.navigationController?.popViewController(animated: true)
        listController?.viewModel?.location = ""
        filterController?.locationField.text = ""
    }
    
    func locationPickerNewLocationSelected(address: String) {
        locationPickerController?.navigationController?.popViewController(animated: true)
        listController?.viewModel?.location = address
        filterController?.locationField.text = address
    }
}
