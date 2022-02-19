//
//  YelpFusionServices.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 19/02/22.
//

import Foundation
import CoreLocation

class YelpFusionServices: APIService<YelpFusionAPI> {
    
    func getBusinesses(limit: Int, offset: Int, coord: CLLocationCoordinate2D?, location: String?, sortBy: String, term: String?, completion: APIResult<BusinessResponse>) {
        request(try! BusinessListAPI(limit: limit, offset: offset, coord: coord, location: location, term: term, sortBy: sortBy), completion: completion)
    }
}
