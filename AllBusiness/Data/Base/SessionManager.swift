//
//  AlamofireManager.swift
//
//  Created by Muhammad Ikhsan on 08/01/19.
//

import Foundation
import Alamofire

class CustomSessionManager: Alamofire.Session {
    static let defaultManager: CustomSessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return CustomSessionManager(configuration: configuration)
    }()
}
