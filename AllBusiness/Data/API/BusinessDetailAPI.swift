//
//  BusinessDetailAPI.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 21/02/22.
//

import Foundation

class BusinessDetailAPI: YelpFusionAPI {
    
    init(businessId: String) {
        super.init(path: "/businesses/\(businessId)", method: .get, task: .requestPlain)
    }
}
