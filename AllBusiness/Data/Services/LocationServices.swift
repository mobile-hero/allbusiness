//
//  LocationServices.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 19/02/22.
//

import Foundation
import CoreLocation

protocol LocationServices {
    func getLatestLocation() -> CLLocation
}

class LocationServicesImpl: LocationServices {
    let locationManager: CLLocationManager
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getLatestLocation() -> CLLocation {
        locationManager.requestLocation()
        return locationManager.location ?? CLLocation(latitude: 0.0, longitude: 0.0)
    }
}
