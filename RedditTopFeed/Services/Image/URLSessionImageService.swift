//
//  URLSessionImageService.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import UIKit

final class URLSessionImageService: ImageServiceProtocol {
    
    private let cache = Cache<URL, UIImage>()
    
    func getImage(by url: URL, then handler: @escaping (UIImage?) -> Void) {
        if let image = cache.value(forKey: url) {
            print("from cache \(url.absoluteString)")
            
            handler(image)
            return
        }
        
        print("request \(url.absoluteString)")
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print(error) // debug
                handler(nil)
                return
            }
            
            guard let data = data,
                  let image = UIImage(data: data) else {
                print("invalid image data")
                handler(nil)
                return
            }
            
            // save to cache
            self?.cache[url] = image
            
            DispatchQueue.main.async {
                handler(image)
            }
        }.resume()
    }
    
}
