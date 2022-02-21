//
//  BusinessDetailController.swift
//
//  Created by Muhammad Ikhsan on 11/02/22.
//

import Foundation
import UIKit
import CoreLocation
import SafariServices
import MapKit

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
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let yelpServices = YelpFusionServices(session: CustomSessionManager.default, plugins: defaultPlugins, decoder: jsonDecoder)
        let viewModel = BusinessDetailViewModelImpl(businessId: business.id, yelpServices: yelpServices)
        let reviewsViewModel = BusinessReviewViewModelImpl(businessId: business.id, yelpServices: yelpServices)
        let detailController = BusinessDetailViewController(business: business, viewModel: viewModel, reviewsViewModel: reviewsViewModel)
        detailController.delegate = self
        navigationController.pushViewController(detailController, animated: true)
        self.detailController = detailController
    }
}

extension BusinessDetailCoordinator: BusinessDetailViewControllerDelegate {
    func businessDetailFindRoute(name: String, coordinates: CLLocationCoordinate2D) {
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        _ = mapItem.openInMaps(launchOptions: options)
    }
    func businessDetailCallBusiness(phoneUrl: URL) {
        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneUrl)) {
            application.open(phoneUrl, options: [:], completionHandler: nil)
        }
    }
    func businessDetailOpenWebsite(url: URL) {
        let svc = SFSafariViewController(url: url)
        detailController?.present(svc, animated: true, completion: nil)
    }
}
