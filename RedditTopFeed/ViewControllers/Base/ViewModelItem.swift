//
//  ViewModelItem.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import Foundation

protocol ViewModelItem: AnyObject {
    var rowCount: Int { get }
}

extension ViewModelItem {
    
    var rowCount: Int {
        return 0
    }
    
}
