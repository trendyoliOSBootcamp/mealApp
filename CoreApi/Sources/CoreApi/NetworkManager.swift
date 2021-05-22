//
//  NetworkManager.swift
//  
//
//  Created by Anıl Taşkıran on 22.05.2021.
//

import Alamofire
import Foundation

public typealias Completion<T> = (Result<T, APIClientError>) -> Void where T: Decodable

public final class NetworkManager<EndpointItem: Endpoint> {
    public init() { }
    
    private var possibleEmptyResponseCodes: Set<Int> {
        var defaultSet = DataResponseSerializer.defaultEmptyResponseCodes
        defaultSet.insert(200)
        defaultSet.insert(201)
        return defaultSet
    }

    public func request <T: Decodable>(endpoint: EndpointItem, type: T.Type, completion: @escaping Completion<T>) {
        AF.request(endpoint.url,
                   method: endpoint.method,
                   parameters: endpoint.parameters,
                   encoding: endpoint.encoding,
                   headers: HTTPHeaders(endpoint.headers))
            .validate()
            .response(responseSerializer: DataResponseSerializer(emptyResponseCodes: possibleEmptyResponseCodes), completionHandler: { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedObject = try JSONDecoder().decode(type, from: data)
                        completion(.success(decodedObject))
                    } catch {
                        let decodingError = APIClientError.decoding(error: error as? DecodingError)
                        completion(.failure(decodingError))
                    }
                case .failure(let error):
                    if NSURLErrorTimedOut == (error as NSError).code {
                        completion(.failure(.timeout))
                    } else {
                        guard let data = response.data else {
                            completion(.failure(.networkError))
                            return
                        }
                        do {
                            let clientError = try JSONDecoder().decode(ClientError.self, from: data)
                            completion(.failure(.handledError(error: clientError)))
                        } catch {
                            let decodingError = APIClientError.decoding(error: error as? DecodingError)
                            completion(.failure(decodingError))
                        }
                    }
                }
            })
    }
}
