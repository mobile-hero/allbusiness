//
//  BusinessReviewsAPI.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 21/02/22.
//

import Foundation

class BusinessReviewsAPI: YelpFusionAPI {
    
    init(businessId: String) {
        super.init(path: "/business/\(businessId)/reviews", method: .get, task: .requestPlain)
    }
}
