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
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var imageUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateImage()
    }
    
    // MARK: - Actions
    
    @IBAction func onSaveButtonPreseed(_ sender: Any) {
        guard let image = imageView?.image else {
            return
        }
        
        saveImageToImageLibrary(image)
    }
    
    // MARK: - Image
    
    private func updateImage() {
        // prevent several requests
        guard let activityIndicator = activityIndicator,
              activityIndicator.isAnimating == false else {
            return
        }
        
        guard let imageView = imageView,
              imageView.image == nil,
              let imageUrl = imageUrl else {
            return
        }
        
        activityIndicator.startAnimating()
        
        Services.shared.imageService.getImage(by: imageUrl) { [weak self] (image) in
            guard let self = self,
                  let image = image else {
                return
            }
            
            self.imageView?.image = image
            self.activityIndicator?.stopAnimating()
            self.saveButton?.isEnabled = true
        }
    }
    
    private func saveImageToImageLibrary(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(onImageDidSave(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func onImageDidSave(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print(error)
            AlertManager.alert(message: "Please allow access to the photo library in the application settings")
            return
        }
        
        AlertManager.alert(message: "Image was saved successfully", action: { [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        })
    }
    
}
