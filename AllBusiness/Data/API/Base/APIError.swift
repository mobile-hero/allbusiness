//
//  APIError.swift
//
//  Created by Muhammad Ikhsan on 12/02/22.
//

import Foundation

class APIError: Codable, Error {
    
    var code: Int?
    var message: String?
    
    init(code: Int? = 400, message: String? = nil) {
        self.message = message
        self.code = code
    }
    
    var localizedDescription: String {
        return message ?? "Something wrong. Please try again later."
    }
    
    static var timeout: APIError {
        return APIError(message: "Connection timeout. Please make sure you have an internet connection.")
    }
}
