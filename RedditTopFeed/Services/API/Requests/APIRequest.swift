//
//  APIRequest.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import Foundation

protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    
    var path: String { get }
    var method: HTTPMethod { get }
    var parameterEncoding: ParameterEncoding { get }
    
    func parameters() -> Any?
}

// MARK: - Defaults

extension APIRequest {
    
    var parameterEncoding: ParameterEncoding {
       return URLEncoding()
    }
    
    var jsonEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .init(rawValue: 0)
        encoder.dateEncodingStrategy = .secondsSince1970
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
        
    func prepareParameters<T>(_ parameters: T) -> Any? where T: Encodable {
        guard let data = try? jsonEncoder.encode(parameters) else {
            return nil
        }

        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
    }
    
    func parameters() -> Any? {
        return prepareParameters(self)
    }
    
}
