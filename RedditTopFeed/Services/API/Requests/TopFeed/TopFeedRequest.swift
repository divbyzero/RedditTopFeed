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
    private(set) var limit: Int = 30
    private(set) var rawJson: Int = 1
    
    init(after: String? = nil) {
        self.after = after
    }
    
}
