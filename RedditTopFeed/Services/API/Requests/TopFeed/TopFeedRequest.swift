//
//  TopFeedRequest.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import Foundation

struct TopFeedRequest: APIRequest {
    
    typealias Response = TopListing
    
    var path: String {
        return "/top.json"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    private(set) var after: String?
    private(set) var limit: Int
    
    init(after: String? = nil, limit: Int = 30) {
        self.after = after
        self.limit = limit
    }
    
}
