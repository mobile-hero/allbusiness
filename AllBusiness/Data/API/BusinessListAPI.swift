//
//  BusinessListAPI.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 19/02/22.
//

import Foundation
import CoreLocation

class BusinessListAPI: YelpFusionAPI {
    init(limit: Int, offset: Int, coord: CLLocationCoordinate2D?, location: String?, term: String?, sortBy: String) throws {
        guard coord != nil || location != nil else {
            throw NSError(domain: "BusinessListAPI",
                          code: 100,
                          userInfo: ["msg": "Should declare location or locString"])
        }
        var query: [String: Any] = ["limit": limit, "offset": offset, "sortBy": sortBy]
        if (location != nil) {
            query["location"] = location
        } else if (coord != nil) {
            query["latitude"] = coord.unsafelyUnwrapped.latitude
            query["longitude"] = coord.unsafelyUnwrapped.longitude
        }
        if (term != nil) {
            query["term"] = term
        }
        super.init(path: "/businesses/search", method: .get, task: .requestWith(query: query))
    }
}
