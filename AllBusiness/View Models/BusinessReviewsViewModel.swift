//
//  BusinessReviewsViewModel.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 21/02/22.
//

import Foundation

protocol BusinessReviewsViewModel: AnyObject {
    var source: Box<[Review]> { get }
    var error: Box<APIError?> { get }
    var isLoading: Box<Bool> { get }
    
    func getReviews()
}

class BusinessReviewViewModelImpl: NSObject, BusinessReviewsViewModel {
    var source: Box<[Review]> = Box([])
    var error: Box<APIError?> = Box(nil)
    var isLoading: Box<Bool> = Box(false)
    
    let businessId: String
    let yelpServices: YelpFusionServices
    
    init(businessId: String, yelpServices: YelpFusionServices) {
        self.businessId = businessId
        self.yelpServices = yelpServices
    }
    
    func getReviews() {
        isLoading.value = true
        yelpServices.getReviews(businessId: businessId) { value, error in
            self.isLoading.value = false
            if (value != nil) {
                let value = value.unsafelyUnwrapped
                self.source.value.append(contentsOf: value.reviews)
            } else {
                self.error.value = error as? APIError
            }
        }
    }
    
}
