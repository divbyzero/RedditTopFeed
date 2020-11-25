//
//  Image.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import Foundation

struct Image: Decodable {
    struct Source: Decodable {
        let url: URL
    }
    
    let source: Source
}

// MARK: - Mock

extension Image {
    
    static func mock() -> Image {
        return Image(source: Source(url: URL(staticString: "https://i.redd.it/fm0borvoi0161.jpg")))
    }
    
}
