//
//  RootAPI.swift
//
//  Created by Muhammad Ikhsan on 05/09/18.
//

import Foundation
import Moya
import CoreLocation

class RootAPI: TargetType {
    var baseURLString: String = ""
    var baseURL: URL {
        return URL(string: baseURLString)!
    }
    var path: String = ""
    var method: Moya.Method = .get
    var sampleData: Data = Data()
    var task: Task = .requestPlain
    var headers: [String : String]?
    
    init(baseURL: String? = nil,
         path: String = "",
         method: Moya.Method = .post,
         task: Task = .requestPlain,
         headers: [String: String] = [:]) {
        if let baseURL = baseURL {
            self.baseURLString = baseURL
        }
        self.path = path
        self.method = method
        self.task = task
        self.headers = headers
    }
}

class PokemonAPI: RootAPI {
    init(
        path: String = "",
        method: Moya.Method = .post,
        task: Task = .requestPlain
    ) {
        super.init(
            baseURL: "https://api.pokemontcg.io/v2",
            path: path,
            method: method,
            task: task,
            headers: ["X-Api-Key": "274ac064-fc2c-41d5-bcd5-46930cafe0dd"]
        )
    }
}

class YelpFusionAPI: RootAPI {
    init(
        path: String = "",
        method: Moya.Method = .post,
        task: Task = .requestPlain
    ) {
        super.init(
            baseURL: "https://api.yelp.com/v3",
            path: path,
            method: method,
            task: task,
            headers: ["Authorization": "Bearer QD0z0NpUuqZ_LNaw2Nkxt-tQlYGMciKrzReIZnEVn7icBvBjgZz1P13RhZfRvYyzpQpE9_u4vEnkPwhA-E4EO0UQYoonETGOX6TMwHW4wAYSeJ1n3Pqji-gF5DsOYnYx"]
        )
    }
}

extension Task {
    
    static func requestWith(query: [String: Any]) -> Task {
        return .requestParameters(parameters: query, encoding: URLEncoding.default)
    }
}
