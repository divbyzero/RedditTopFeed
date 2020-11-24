//
//  Identifiable.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import UIKit

protocol Identifiable: AnyObject {
    static var identifier: String { get }
    static var nib: UINib { get }
}

extension Identifiable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}

