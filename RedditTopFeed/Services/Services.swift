//
//  Services.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import Foundation

final class Services {
    
    static let shared: Services = .init()
    
    private(set) var imageService: ImageServiceProtocol
    
    private init() {
        imageService = UrlManagerImageService()
    }
    
    private(set) static var dependencies: Dependencies!
    
    static func register(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
}
