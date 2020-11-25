//
//  AppDependencies.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import Foundation

final class AppDependencies: Dependencies {
    
    private lazy var urlSessionImageService: URLSessionImageService = {
        return URLSessionImageService()
    }()
    
    private lazy var urlSessionAPIService: URLSessionAPIService = {
        return URLSessionAPIService()
    }()
    
    var imageService: ImageServiceProtocol {
        return urlSessionImageService
    }
    
    var apiService: APIServiceProtocol {
        return urlSessionAPIService
    }
    
}
