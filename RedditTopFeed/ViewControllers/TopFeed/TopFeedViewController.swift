//
//  TopFeedViewController.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import UIKit

final class TopFeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: TopFeedViewModel = TopFeedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        
        // show image preview
        viewModel.onImagePreviewPressed = { [weak self] url in
            self?.showImagePreview(with: url)
        }
    }
    
    private func prepareUI() {
        tableView?.dataSource = viewModel
        tableView?.delegate = viewModel
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = UITableView.automaticDimension
        tableView?.tableFooterView = UIView()
    }
    
    // MARK: - Actions
    
    private func showImagePreview(with url: URL) {
        let viewController = TopFeedImagePreviewViewController.instantiate(fromStoryboardType: .topFeedImagePreview)
        viewController.imageUrl = url
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.show(viewController, sender: nil)
        }
    }
    
}
