//
//  PokemonListCoordinator.swift
//  PokemonLibrary
//
//  Created by Muhammad Ikhsan on 11/02/22.
//

import Foundation
import UIKit
import CoreLocation

class BusinessListCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private var listController: BusinessListViewController?
    private var detailCoordinator: BusinessDetailCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let yelpServices = YelpFusionServices(session: CustomSessionManager.default, plugins: defaultPlugins, decoder: JSONDecoder())
        let locationServices = LocationServicesImpl(locationManager: CLLocationManager())
        let viewModel = BusinessListViewModelImpl(yelpServices: yelpServices, locationServices: locationServices)
        let listController = BusinessListViewController(viewModel: viewModel)
        listController.delegate = self
        navigationController.pushViewController(listController, animated: true)
        self.listController = listController
    }
}

extension BusinessListCoordinator: BusinessListViewControllerDelegate {
    func businessListDidSelectItem(business: Business) {
        detailCoordinator = BusinessDetailCoordinator(navigationController: navigationController, business: business)
        detailCoordinator?.start()
    }
}
