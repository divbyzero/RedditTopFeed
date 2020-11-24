//
//  TopFeedCell.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import UIKit

protocol TopFeedCellDelegate: AnyObject {
    func topFeedCell(_ cell: TopFeedCell, didImagePressedWithUrl url: URL)
}

final class TopFeedCell: UITableViewCell, Identifiable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var numCommentsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var thumbnailImageButton: UIButton!
    
    private let imageService = Services.dependencies.imageService
    
    weak var delegate: TopFeedCellDelegate?
    
    var item: TopEntry.Data? {
        didSet {
            guard let item = item else {
                return
            }
            
            updateUI(with: item)
        }
    }
    
    private func updateUI(with item: TopEntry.Data) {
        titleLabel?.text = item.title
        authorLabel?.text = item.author
        numCommentsLabel?.text = item.numCommentsFormatted
        dateLabel?.text = item.createdStringFormatted
        setThumbnailImage(by: item.thumbnail)
    }
    
    private func setThumbnailImage(by url: URL?) {
        thumbnailImageButton?.isHidden = true
        
        guard let url = item?.thumbnail,
              url.absoluteString.hasPrefix("http") else {
            return
        }
        
        imageService.getImage(by: url) { [weak self] (image) in
            guard let self = self,
                  let image = image else {
                return
            }
            
            self.thumbnailImageButton?.setImage(image, for: .normal)
            self.thumbnailImageButton?.isHidden = false
        }
    }
    
    @IBAction func imageButtonPressed(_ sender: Any) {
        guard let item = item,
              let image = item.preview.images?.first else {
            return
        }
        
        delegate?.topFeedCell(self, didImagePressedWithUrl: image.source.url)
    }

}
