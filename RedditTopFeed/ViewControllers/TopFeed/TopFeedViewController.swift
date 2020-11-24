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
    }
    
    private func prepareUI() {
        tableView?.dataSource = viewModel
        tableView?.delegate = viewModel
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = UITableView.automaticDimension
        tableView?.tableFooterView = UIView()
    }
    
}
