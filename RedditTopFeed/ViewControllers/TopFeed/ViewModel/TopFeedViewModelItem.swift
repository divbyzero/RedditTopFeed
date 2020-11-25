//
//  TopFeedViewModelItem.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import Foundation

final class TopFeedViewModelItem: ViewModelItem {
    
    var rowCount: Int {
        return models.count
    }
    
    var models: [TopEntry.Data]
    
    init(_ models: [TopEntry.Data]) {
        self.models = models
    }
    
}
