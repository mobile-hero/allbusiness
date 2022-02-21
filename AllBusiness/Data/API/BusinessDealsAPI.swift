//
//  BusinessDealsAPI.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 21/02/22.
//

import Foundation
import CoreLocation

class BusinessDealsAPI: YelpFusionAPI {
    
    init(coord: CLLocationCoordinate2D?, location: String?) throws {
        guard location != nil || coord != nil else {
            throw NSError(domain: "BusinessDealsAPI",
                          code: 100,
                          userInfo: ["msg": "Should declare location or locString"])
        }
        var query: [String: Any] = [:]
        if (location != nil) {
            query["location"] = location
        } else if (coord != nil) {
            query["latitude"] = coord.unsafelyUnwrapped.latitude
            query["longitude"] = coord.unsafelyUnwrapped.longitude
        }
        super.init(path: "/events/featured", method: .get, task: .requestWith(query: query))
    }
}
