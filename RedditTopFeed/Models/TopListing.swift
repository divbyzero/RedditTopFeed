//
//  TopListing.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import Foundation

struct TopListing: Decodable {
    struct Data: Decodable {
        let dist: Int
        let children: [TopEntry]
        let after: String?
    }
    
    let data: Data
}
