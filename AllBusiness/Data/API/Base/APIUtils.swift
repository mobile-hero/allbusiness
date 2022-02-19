//
//  APIUtils.swift
//
//  Created by Muhammad Ikhsan on 12/06/18.
//

import Foundation
import Moya
import Alamofire

typealias APIResult<T: Codable> = ((T?, Error?) -> Void)?
typealias MoyaResult = Result<Moya.Response, MoyaError>

let defaultPlugins = [
    NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))
]

class APIService<T: RootAPI> {
    
    var provider: MoyaProvider<T>!
    var decoder: JSONDecoder
    
    private let positiveStatusCodes: ClosedRange<Int> = (200...299)
    
    init(session: Alamofire.Session, plugins: [PluginType], decoder: JSONDecoder) {
        self.provider = MoyaProvider<T>(session: session, plugins: plugins)
        self.decoder = decoder
    }
    
    @discardableResult
    func request<C: Codable>(_ target: T, completion: APIResult<C>) -> Cancellable {
        return provider.request(target, callbackQueue: .none, progress: .none, completion: { (result) in
            self.handleResult(result, completion: completion)
        })
    }
}

extension APIService {
    func handleResult<T: Codable>(_ result: MoyaResult, completion: APIResult<T>) {
        switch result {
        case .success(let value):
            do {
                let result = try decoder.decode(T.self, from: value.data)
                completion?(result, nil)
            } catch {
                completion?(nil, APIError(message: "Terdapat kesalahan"))
            }
            break
        case .failure:
            completion?(nil, APIError.timeout)
            break
        }
    }
}
