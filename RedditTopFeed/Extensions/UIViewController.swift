//
//  UIViewController.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import UIKit

extension UIViewController {
    
    class var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static func instantiate(fromStoryboardType storyboard: Storyboard) -> Self {
        return storyboard.viewController(viewControllerClass: self)
    }
}
