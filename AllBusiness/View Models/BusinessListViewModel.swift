//
//  BusinessListViewModel.swift
//
//  Created by Muhammad Ikhsan on 12/02/22.
//

import Foundation
import SwiftUI
import CoreLocation

protocol BusinessListViewModel: AnyObject {
    var source: Box<[Business]> { get }
    var error: Box<APIError?> { get }
    var firstLoad: Box<Bool> { get }
    var isLoading: Box<Bool> { get }
    
    var limit: Int { get set }
    var offset: Int { get set }
    var lastKeyword: String { get set }
    
    func getLatestLocation()
    func requestLocation()
    func loadBusiness(coord: CLLocationCoordinate2D?, location: String?, sortBy: String, term: String?)
    func loadMoreBusiness(coord: CLLocationCoordinate2D?, location: String?, sortBy: String, term: String?)
}

class BusinessListViewModelImpl: NSObject, BusinessListViewModel {
    var source = Box<[Business]>([])
    var error = Box<APIError?>(nil)
    var firstLoad = Box<Bool>(true)
    var isLoading = Box<Bool>(true)
    
    var limit: Int = 30
    var offset: Int = 0
    var lastKeyword: String = ""
    private var hasMore: Bool = false
    
    let yelpServices: YelpFusionServices
    let locationService: LocationServices
    
    init(yelpServices: YelpFusionServices, locationServices: LocationServices) {
        self.yelpServices = yelpServices
        self.locationService = locationServices
        super.init()
        locationServices.delegate = self
    }
    
    func requestLocation() {
        locationService.requestLocation()
    }
    
    func getLatestLocation() {
        let location = locationService.getLatestLocation()
        print(location)
    }
    
    func loadBusiness(coord: CLLocationCoordinate2D? = nil, location: String? = nil, sortBy: String, term: String?) {
        firstLoad.value = true
        source.value.removeAll()
        offset = 0
        if (location != nil) {
            loadAllBusiness(coord: nil, location: location, sortBy: sortBy, term: term)
        } else {
            loadAllBusiness(coord: coord, location: nil, sortBy: sortBy, term: term)
        }
    }
    
    func loadMoreBusiness(coord: CLLocationCoordinate2D? = nil, location: String? = nil, sortBy: String, term: String?) {
        if (hasMore && !isLoading.value) {
            if (location != nil) {
                loadAllBusiness(coord: nil, location: location, sortBy: sortBy, term: term)
            } else {
                loadAllBusiness(coord: coord, location: nil, sortBy: sortBy, term: term)
            }
        }
    }

    private func loadAllBusiness(coord: CLLocationCoordinate2D?, location: String?, sortBy: String, term: String?) {
        yelpServices.getBusinesses(limit: limit, offset: offset, coord: coord, location: location, sortBy: sortBy, term: term) { value, error in
            self.firstLoad.value = false
            if (value != nil) {
                let value = value.unsafelyUnwrapped
                self.offset += value.businesses.count
                self.source.value.append(contentsOf: value.businesses)
                self.hasMore = value.businesses.count >= self.limit
            } else {
                self.error.value = error as? APIError
            }
        }
    }
}

extension BusinessListViewModelImpl: LocationServicesDelegate {
    func locationServicesOnLatest(locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        loadBusiness(coord: locations.first?.coordinate, location: nil, sortBy: "rating", term: nil)
    }
}
