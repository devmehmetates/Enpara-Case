//
//  NetworkManager.swift
//  EnparaCase
//
//  Created by Mehmet Ateş on 9.08.2022.
//

import Alamofire

class NetworkManager<T: RequestModel> {
    
    static func apiRequest(
        _ path: String, method: HTTPMethod? = .get,
        parameters: T? = nil,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil,
        requestModifier: Session.RequestModifier? = nil,
        result: @escaping(Result<(data: Data, code: Int), AFError>) -> Void
    ) {
        AF.request(
            path,
            method: method ?? .get,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: headers,
            interceptor: interceptor,
            requestModifier: requestModifier
        ).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                guard let responseCode = response.response?.statusCode else { return }
                return result(.success((data: data, code: responseCode)))
            case .failure(let err):
                return result(.failure(err))
            }
        }
    }
}

// MARK: Request Dependencies
protocol RequestModel: Codable { }
struct MockModel: RequestModel { } // It is used if the parameter is nil.
