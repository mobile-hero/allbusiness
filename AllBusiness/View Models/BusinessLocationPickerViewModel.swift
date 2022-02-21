//
//  BusinessLocationPickerViewModel.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 22/02/22.
//

import Foundation
import CoreLocation

protocol BusinessLocationPickerViewModel: AnyObject {
    var source: Box<[String]> { get }
    var error: Box<APIError?> { get }
    var isLoading: Box<Bool> { get }
    
    func findLocations(keyword: String)
}

class BusinessLocationPickerViewModelImpl: NSObject, BusinessLocationPickerViewModel {
    var source: Box<[String]> = Box([])
    var error: Box<APIError?> = Box(nil)
    var isLoading: Box<Bool> = Box(false)
    
    let locationSearchServices: LocationSearchServices
    
    init(locationSearchServices: LocationSearchServices) {
        self.locationSearchServices = locationSearchServices
    }
    
    func findLocations(keyword: String) {
        isLoading.value = true
        locationSearchServices.search(keyword: keyword) { result in
            self.isLoading.value = false
            guard result != nil else {
                self.error.value = APIError(code: 400, message: "No places found")
                return
            }
            self.error.value = nil
            self.source.value = result!
        }
    }
}
