//
//  ImageServiceProtocol.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import UIKit

protocol ImageServiceProtocol {
    func getImage(by url: URL, then handler: @escaping (UIImage?) -> Void)
}
