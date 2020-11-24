//
//  TopFeedImagePreviewViewController.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import UIKit

final class TopFeedImagePreviewViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var imageUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateImage()
    }
    
    // MARK: - Actions
    
    @IBAction func onSaveButtonPreseed(_ sender: Any) {}
    
    // MARK: - Image
    
    private func updateImage() {
        guard let imageView = imageView,
              imageView.image == nil,
              let imageUrl = imageUrl else {
            return
        }
        
        activityIndicator?.startAnimating()
        
        ImageService.shared.getImage(by: imageUrl) { [weak self] (image) in
            guard let self = self,
                  let image = image else {
                return
            }
            
            self.imageView?.image = image
            self.activityIndicator?.stopAnimating()
        }
    }
    
}
