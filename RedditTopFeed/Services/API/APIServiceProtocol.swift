//
//  APIServiceProtocol.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import Foundation

protocol APIServiceProtocol {
    func send<T>(_ request: T, then handler: @escaping (Result<T.Response, Error>) -> Void) where T: APIRequest
}
