//
//  TopFeedViewModel.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import UIKit

final class TopFeedViewModel: NSObject {
    
    var onImagePreviewPressed: ((_: URL) -> Void)?

    private(set) var items: [TopFeedViewModelItem] = []
    private lazy var mockData: [TopEntry.Data] = {
        var mocks: [TopEntry.Data] = []
        let count = Int.random(in: 10..<50)
        
        for _ in 0..<count {
            mocks.append(TopEntry.Data.mock())
        }
        
        return mocks
    }()
    
    override init() {
        super.init()
        
        // mock data for test
        updateItems(with: mockData)
    }
    
    private func updateItems(with data: [TopEntry.Data]) {
        items.removeAll()
        
        let item = TopFeedViewModelItem(data)
        items.append(item)
    }

}

// MARK: - UITableViewDataSource

extension TopFeedViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
