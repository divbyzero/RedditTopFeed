//
//  TopFeedViewController.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import UIKit

final class TopFeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: TopFeedViewModel?
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = TopFeedViewModel()
        
        prepareUI()
        
        // show image preview
        viewModel?.onImagePreviewPressed = { [weak self] url in
            self?.showImagePreview(with: url)
        }
        // update table view with new data
        viewModel?.reload = { [weak self] in
            self?.stopRefreshing()
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func prepareUI() {
        tableView?.dataSource = viewModel
        tableView?.delegate = viewModel
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = UITableView.automaticDimension
        tableView?.tableFooterView = UIView()
        tableView?.refreshControl = refreshControl
        refreshControl.addTarget(viewModel, action: #selector(viewModel?.forceRequestData), for: .valueChanged)
    }
    
    private func stopRefreshing() {
        guard refreshControl.isRefreshing else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
        }
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
