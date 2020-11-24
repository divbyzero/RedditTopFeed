//
//  AppDependencies.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import Foundation

final class AppDependencies: Dependencies {
    
    private lazy var urlSessionImageService: UrlManagerImageService = {
        return UrlManagerImageService()
    }()
    
    var imageService: ImageServiceProtocol {
        return urlSessionImageService
    }
    
}
