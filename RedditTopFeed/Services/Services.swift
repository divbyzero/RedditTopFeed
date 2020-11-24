//
//  Services.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import Foundation

final class Services {
    
    private(set) static var dependencies: Dependencies!
    
    static func register(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
}
