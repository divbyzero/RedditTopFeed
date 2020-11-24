//
//  ImageService.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import UIKit

final class ImageService {
    
    static let shared: ImageService = .init()
    
    private init() {}
    
    func getImage(by url: URL, then handler: @escaping (UIImage?) -> Void) {
        print("request \(url.absoluteString)")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
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
            
            DispatchQueue.main.async {
                handler(image)
            }
        }.resume()
    }
    
}
