//
//  PokemonDetailController.swift
//  PokemonLibrary
//
//  Created by Muhammad Ikhsan on 11/02/22.
//

import Foundation
import UIKit

class BusinessDetailCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    let business: Business
    private var detailController: BusinessDetailViewController?
    
    private var detailCoordinator: BusinessDetailCoordinator?
    
    init(navigationController: UINavigationController, business: Business) {
        self.navigationController = navigationController
        self.business = business
    }
    
    func start() {
        let yelpServices = YelpFusionServices(session: CustomSessionManager.default, plugins: defaultPlugins, decoder: JSONDecoder())
//        let viewModel = PokemonListViewModelImpl(pokemonServices: pokemonServices)
        let detailController = BusinessDetailViewController(business: business)
//        detailController.delegate = self
        navigationController.pushViewController(detailController, animated: true)
        self.detailController = detailController
    }
}

