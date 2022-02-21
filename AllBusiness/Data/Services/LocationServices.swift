//
//  LocationServices.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 19/02/22.
//

import Foundation
import CoreLocation

protocol LocationServicesDelegate: AnyObject {
    func locationServicesOnLatest(locations: [CLLocation])
}

protocol LocationServices: AnyObject {
    var delegate: LocationServicesDelegate? { get set }
    func requestLocation()
    func getLatestLocation() -> CLLocation
}

class LocationServicesImpl: NSObject, LocationServices {
    let locationManager: CLLocationManager
    
    var delegate: LocationServicesDelegate?
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        locationManager.requestWhenInUseAuthorization()
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func getLatestLocation() -> CLLocation {
        return locationManager.location ?? CLLocation(latitude: 0.0, longitude: 0.0)
    }
}

extension LocationServicesImpl: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.delegate?.locationServicesOnLatest(locations: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
