//
//  BusinessDetailViewModel.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 21/02/22.
//

import Foundation

protocol BusinessDetailViewModel: AnyObject {
    var source: Box<Business?> { get }
    var error: Box<APIError?> { get }
    var isLoading: Box<Bool> { get }
    
    func getDetails()
}

class BusinessDetailViewModelImpl: NSObject, BusinessDetailViewModel {
    var source: Box<Business?> = Box(nil)
    var error: Box<APIError?> = Box(nil)
    var isLoading: Box<Bool> = Box(false)
    
    let businessId: String
    let yelpServices: YelpFusionServices
    
    init(businessId: String, yelpServices: YelpFusionServices) {
        self.businessId = businessId
        self.yelpServices = yelpServices
    }
    
    func getDetails() {
        isLoading.value = true
        yelpServices.getDetails(businessId: businessId) { value, error in
            self.isLoading.value = false
            if (value != nil) {
                let value = value.unsafelyUnwrapped
                self.source.value = value
            } else {
                self.error.value = error as? APIError
            }
        }
    }
    
}
