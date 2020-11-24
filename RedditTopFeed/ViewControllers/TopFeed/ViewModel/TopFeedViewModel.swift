//
//  TopFeedViewModel.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import UIKit

final class TopFeedViewModel: NSObject {
    
    var onImagePreviewPressed: ((_: URL) -> Void)?
    var reload: (() -> Void)?
    
    private var apiService: APIServiceProtocol = Services.dependencies.apiService

    private(set) var items: [TopFeedViewModelItem] = []
    private lazy var mockData: [TopEntry.Data] = {
        var mocks: [TopEntry.Data] = []
        let count = Int.random(in: 10..<50)
        
        for _ in 0..<count {
            mocks.append(TopEntry.Data.mock())
        }
        
        return mocks
    }()
    private var isLoading: Bool = false
    private var afterHash: String? = nil
    
    override init() {
        super.init()
        
        // mock data for test
        // updateItems(with: mockData)
        
        requestData()
    }
    
    // MARK: - Prepare & update UI
    
    private func updateItems(with data: [TopEntry.Data]) {
        if afterHash == nil {
            items.removeAll()
        }
        
        if let item = items.first {
            item.models.append(contentsOf: data)
        } else {
            items = [TopFeedViewModelItem(data)]
        }
    }
    
    private func updateUI() {
        reload?()
    }
    
    // MARK: - Request data
    
    @objc func forceRequestData() {
        afterHash = nil
        requestData()
    }
    
    private func requestData() {
        guard isLoading == false else {
            updateUI()
            return
        }
        
        isLoading = true
        
        let request = TopFeedRequest(after: afterHash)
        apiService.send(request) { [weak self] (result) in
            self?.isLoading = false
            
            switch result {
            case .success(let feedData):
                self?.updateItems(with: feedData.data.children.map({ $0.data }))
                self?.afterHash = feedData.data.after
            case .failure(let error):
                print(error)
            }
            
            self?.updateUI()
        }
    }

}

// MARK: - UITableViewDataSource

extension TopFeedViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard items.isEmpty == false else {
            return 0
        }
        
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item: TopEntry.Data = items[indexPath.section].models[indexPath.row]
        let cell: TopFeedCell = tableView.dequeueReusableCell(for: indexPath)
        cell.item = item
        cell.delegate = self
        return cell
    }

}

// MARK: - UITableViewDelegate

extension TopFeedViewModel: UITableViewDelegate {}

// MARK: - UITableViewDataSourcePrefetching

extension TopFeedViewModel: UITableViewDataSourcePrefetching {
    
    static let prefetchShearValue: Int = 10
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard isLoading == false,
              items.isEmpty == false,
              indexPaths.isEmpty == false,
              let lastIndexPath = indexPaths.last else {
            return
        }
        
        // prefetch condition
        if max(items[lastIndexPath.section].rowCount - TopFeedViewModel.prefetchShearValue, 0) <= lastIndexPath.row {
            requestData()
        }
    }
    
}

// MARK: - TopFeedCellDelegate

extension TopFeedViewModel: TopFeedCellDelegate {
    
    func topFeedCell(_ cell: TopFeedCell, didImagePressedWithUrl url: URL) {
        onImagePreviewPressed?(url)
    }
    
}
