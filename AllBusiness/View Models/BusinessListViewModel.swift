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
    var location: String { get set }
    var coordinate: CLLocationCoordinate2D? { get set }
    var sortBy: String { get set }
    
    func getLatestLocation() -> CLLocationCoordinate2D
    func requestLocation()
    func loadBusiness()
    func loadMoreBusiness()
    func searchBusiness(keyword: String)
    func retryLoad()
}

class BusinessListViewModelImpl: NSObject, BusinessListViewModel {
    var source = Box<[Business]>([])
    var error = Box<APIError?>(nil)
    var firstLoad = Box<Bool>(true)
    var isLoading = Box<Bool>(true)
    
    var limit: Int = 30
    var offset: Int = 0
    var lastKeyword: String = ""
    var location: String = ""
    var coordinate: CLLocationCoordinate2D? = nil
    var sortBy: String = "rating"
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
    
    func getLatestLocation() -> CLLocationCoordinate2D {
        let location = locationService.getLatestLocation()
        print(location)
        return location.coordinate
    }
    
    func loadBusiness() {
        firstLoad.value = true
        source.value.removeAll()
        offset = 0
        if (!location.isEmpty) {
            loadAllBusiness(coord: nil, location: location, sortBy: sortBy, term: lastKeyword)
        } else {
            loadAllBusiness(coord: coordinate, location: nil, sortBy: sortBy, term: lastKeyword)
        }
    }
    
    func loadMoreBusiness() {
        if (hasMore && !isLoading.value) {
            if (!location.isEmpty) {
                loadAllBusiness(coord: nil, location: location, sortBy: sortBy, term: lastKeyword)
            } else {
                loadAllBusiness(coord: coordinate, location: nil, sortBy: sortBy, term: lastKeyword)
            }
        }
    }

    private func loadAllBusiness(coord: CLLocationCoordinate2D?, location: String?, sortBy: String, term: String?) {
        isLoading.value = true
        yelpServices.getBusinesses(limit: limit, offset: offset, coord: coord, location: location, sortBy: sortBy, term: term) { value, error in
            self.firstLoad.value = false
            self.isLoading.value = false
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
    
    func searchBusiness(keyword: String) {
        self.lastKeyword = keyword
        self.loadBusiness()
    }
    
    func retryLoad() {
        self.loadBusiness()
    }
}

extension BusinessListViewModelImpl: LocationServicesDelegate {
    func locationServicesOnLatest(locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        self.coordinate = locations.first?.coordinate
        loadAllBusiness(coord: locations.first?.coordinate, location: nil, sortBy: sortBy, term: nil)
    }
}
