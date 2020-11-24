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
        items.removeAll()
        
        let item = TopFeedViewModelItem(data)
        items.append(item)
        
        // reload tableview
        reload?()
    }
    
    // MARK: - Request data
    
    private func requestData() {
        guard isLoading == false else {
            return
        }
        
        isLoading = true
        
        let request = TopFeedRequest(after: afterHash)
        apiService.send(request) { [weak self] (result) in
            self?.isLoading = false
            
            switch result {
            case .success(let feedData):
                self?.afterHash = feedData.data.after
                self?.updateItems(with: feedData.data.children.map({ $0.data }))
            case .failure(let error):
                print(error)
            }
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


extension TopFeedViewModel: TopFeedCellDelegate {
    
    func topFeedCell(_ cell: TopFeedCell, didImagePressedWithUrl url: URL) {
        onImagePreviewPressed?(url)
    }
    
}
