//
//  Parameters.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import Foundation

typealias Parameters = [String: Any]

protocol ParameterEncoding {
    func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest
}

struct URLEncoding: ParameterEncoding {
    
    func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest {
        guard let parameters = parameters else {
            return urlRequest
        }
        
        var urlRequest = urlRequest
        
        if let method = HTTPMethod(rawValue: urlRequest.httpMethod ?? HTTPMethod.get.rawValue),
           method == .get {
            guard let url = urlRequest.url else {
                throw APIError.invalidRequestData
            }
            
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
                urlComponents.percentEncodedQuery = percentEncodedQuery
                urlRequest.url = urlComponents.url
            }
            
        } else {
            assertionFailure("Need to implement encoding for other methods")
        }
        
        return urlRequest
    }
    
    private func query(_ parameters: [String: Any]) -> String {
        return parameters.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
}
