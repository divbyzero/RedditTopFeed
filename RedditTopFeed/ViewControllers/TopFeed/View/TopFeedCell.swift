//
//  TopFeedCell.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import UIKit

protocol TopFeedCellDelegate: AnyObject {
    func topFeedCell(_ cell: TopFeedCell, didImagePressedWithUrl: URL)
}

final class TopFeedCell: UITableViewCell, Identifiable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var numCommentsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var thumbnailImageButton: UIButton!
    
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
        
        // thumbnail
        thumbnailImageButton?.isHidden = true
        
        // TODO: request image from url
        if let _ = item.thumbnail {
            thumbnailImageButton?.isHidden = false
        }
    }
    
    @IBAction func imageButtonPressed(_ sender: Any) {
        
    }    

}
