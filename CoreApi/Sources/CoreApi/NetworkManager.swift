//
//  NetworkManager.swift
//  
//
//  Created by Anıl Taşkıran on 22.05.2021.
//

import Alamofire

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var headers: [String: String] { get}
}

extension Endpoint {
    var encoding: ParameterEncoding {
        switch method {
        case .get: return URLEncoding.default
        default: return JSONEncoding.default
        }
    }

    var headers: [String: String]? { [:] }
    var url: String { "\(baseUrl)\(path)"}
}

public final class NetworkManager {
    private var possibleEmptyResponseCodes: Set<Int> {
        var defaultSet = DataResponseSerializer.defaultEmptyResponseCodes
        defaultSet.insert(200)
        defaultSet.insert(201)
        return defaultSet
    }

    func request(endpoint: Endpoint) {
        AF.request(endpoint.url,
                   method: endpoint.method,
                   parameters: endpoint.parameters,
                   encoding: endpoint.encoding,
                   headers: HTTPHeaders(endpoint.headers))
            .validate()
            .response(responseSerializer: DataResponseSerializer(emptyResponseCodes: possibleEmptyResponseCodes), completionHandler: { response in
                switch response.result {
                case .success(let data):
                    break
                case .failure(let error):
                    break
                }
            })
    }
}
