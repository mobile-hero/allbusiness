//
//  LocationGeocoderServices.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 22/02/22.
//

import Foundation
import CoreLocation
import MapKit
import Alamofire

protocol LocationSearchServices: AnyObject {
    func search(keyword: String, completion: @escaping ([String]?) -> Void)
}

class LocationSearchServicesImpl: NSObject, LocationSearchServices {
    
    var localSearch: MKLocalSearch?
    
    func search(keyword: String, completion: @escaping ([String]?) -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = keyword
        if #available(iOS 13.0, *) {
            request.resultTypes = .address
        }
        
        localSearch = MKLocalSearch(request: request)
        localSearch?.start { result, error in
            guard error == nil else {
                print(error!)
                completion(nil)
                return
            }
            print(result!)
            completion(result?.mapItems.map { $0.name ?? "-" })
        }
    }
}
